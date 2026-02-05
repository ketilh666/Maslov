import numpy as np
import scipy.io
import matplotlib.pyplot as plt
import pickle

# Load model and horizons
with open('Horizons.pkl', 'rb') as fid:
    [horizons] =  pickle.load(fid)
    
with open('Heatflow.pkl', 'rb') as fid:
    [hf_decim] = pickle.load(fid)

# Load ray data
rayini = np.loadtxt('SeaFloor_for_3DRT_CoarseUp_varQ.ascii', 
                    usecols=[0,1,2])

nray = int(rayini[0,0])
nrayel = 240
DBRAY_xz = np.loadtxt('DB_RAY_XZ.ASCII')
DBRAY_yz = np.loadtxt('DB_RAY_YZ.ASCII')

xray = DBRAY_xz[:, 1].reshape(nray, nrayel)
yray = DBRAY_yz[:, 1].reshape(nray, nrayel)
zray = DBRAY_yz[:, 0].reshape(nray, nrayel)

# Temperature along the ray
T0 = 5.
dT = 1.0
Tray = T0*np.ones_like(zray)
for jr in range(nray):
    
    isb_list = np.where(zray[jr,:]<=0)[0]
    if len(isb_list) == 0:
        isb = nrayel-1
    else:
        isb = isb_list[0]
        
    Tray[jr,0:isb] = [T0 + (isb-jt)*dT for jt in range(isb)]

#------------------------------
# Plot rays in the xz plane
#------------------------------

# Grid spacing of TC model
scl=1e-3
dx = dy = 200
xtnt = scl*np.array([np.min(hf_decim['x']), np.max(hf_decim['x']),
                     np.min(hf_decim['zreg']), np.max(hf_decim['zreg'])])

fig, axs = plt.subplots(3, 1, figsize=(12,8))
ax = axs.ravel()[0]

for ja, yc in enumerate([20000, 30000, 40000]):

    ky = int(yc/dy)    
    kH = hf_decim['kH'][:,ky,:]

    ax = axs.ravel()[ja]
    im = ax.imshow(kH, origin='lower', extent=xtnt)
    cb = ax.figure.colorbar(im, ax=ax, label='TC [W/mK]')
    ind = yray[:,0] == yc
    xwrk, zwrk = xray[ind,:], zray[ind,:]
    
    for jr in range(xwrk.shape[0]):
        jnd = zwrk[jr,:] >= 0
        ax.plot(scl*xwrk[jr,jnd], scl*zwrk[jr,jnd], 'k-')
        ax.scatter(scl*xwrk[jr,jnd], scl*zwrk[jr,jnd], c=Tray[jr,jnd],
                   marker='.', cmap='magma')
    
    ax.set_xlabel('x [km]')
    ax.set_ylabel('z [km]')
    ax.set_title(f'y={scl*yc}km')
    ax.axis('scaled')
    ax.set_ylim(0,scl*9000)
    
    ax.invert_yaxis()
    
fig.tight_layout(pad=1.)
fig.savefig('Rays_xz_Up.png')
    
# PLot rays in the xy plane
fig, axs = plt.subplots(1, 4, figsize=(20,6))
for ja, jr in enumerate(reversed([0, 80, 160, 239])):
    ax = axs.ravel()[ja]
    sc = ax.scatter(scl*xray[:,jr], scl*yray[:,jr], c=scl*zray[:,jr], 
                    marker='.', vmin=0,  vmax=9)
    ax.axis('equal')
    ax.figure.colorbar(sc, ax=ax)
    ax.set_xlabel('x [km]')
    ax.set_ylabel('y [km]')
    Tc = np.mean(Tray[:,jr])
    ax.set_title(f'T={Tc:.0f}oC')

fig.tight_layout(pad=1)
fig.savefig('Isotherms_Up.png')

plt.show()


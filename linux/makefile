#--------------------------------------------------------------- 
#   Makefile for art (anisotropic ray tracing) on
#   SGI Origin 2000
#--------------------------------------------------------------- 

TOPDIR  = /project/FEG_area/
SRCF90  = $(TOPDIR)/maslov/src_f90/
SRCF90  = $(TOPDIR)/maslov/src_f90/
OBJDIR  = $(TOPDIR)/maslov/linux/obj/
ARTLIB  = $(TOPDIR)/maslov/linux/lib/
IKULIB  = $(TOPDIR)//maslov/ikulib/linux/lib

F90C     = ifort
F77C     = ifort
OPTFLAGS = -O1 
F90FLAGS = -c $(OPTFLAGS) -I$(LIBDIR) -I$(IKULIB) 
LDFLAGS  = $(OPTFLAGS) 

OBJ  =  $(OBJDIR)/art_geo_model_inc.o\
        $(OBJDIR)/art_interpol_inc.o\
        $(OBJDIR)/art_ray_control_inc.o\
        $(OBJDIR)/art_runge_kutta_inc.o\
        $(OBJDIR)/art_jobfile_1st_module.o\
        $(OBJDIR)/art_kind_real_module.o\
        $(OBJDIR)/art_lagrange_interp_module.o\
        $(OBJDIR)/art_runge_kutta_module.o\
        $(OBJDIR)/art_geo_model_module.o\
        $(OBJDIR)/art_kinetic_module.o\
        $(OBJDIR)/art_dynamic_module.o\
        $(OBJDIR)/art_kin_interp_module.o\
        $(OBJDIR)/art_raiuno_module.o\
        $(OBJDIR)/art_ray_tracer_1st_module.o

#----------------------------------------------------------------

all: ikulib f77lib art_main_1st_rt
	cp *.mod $(ARTLIB)

#----------------------------------------------------------------

art_main_1st_rt: $(OBJ) $(OBJDIR)/art_main_1st_rt.o
	$(F90C) -o art_rt_1st $(LDFLAGS) $(OBJ) $(OBJDIR)/art_main_1st_rt.o\
                -L$(IKULIB) -liku -L$(ARTLIB) -lart_f77
	mv art_rt_1st $(TOPDIR)/maslov/linux/bin/

$(OBJDIR)/art_main_1st_rt.o:  $(SRCF90)/art_main_1st/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_main_1st_rt.o\
        $(SRCF90)/art_main_1st/art_main_1st_rt.f90

#--------------------------------------------------------------

$(OBJDIR)/art_geo_model_inc.o:  $(SRCF90)/art_include_files/*.f90
	$(F90C) $(F90FLAGS) -fixed\
        -o $(OBJDIR)/art_geo_model_inc.o\
        $(SRCF90)/art_include_files/art_geo_model_inc.f90

$(OBJDIR)/art_interpol_inc.o:  $(SRCF90)/art_include_files/*.f90
	$(F90C) $(F90FLAGS) -fixed\
        -o $(OBJDIR)/art_interpol_inc.o\
        $(SRCF90)/art_include_files/art_interpol_inc.f90

$(OBJDIR)/art_ray_control_inc.o:  $(SRCF90)/art_include_files/*.f90
	$(F90C) $(F90FLAGS) -fixed\
        -o $(OBJDIR)/art_ray_control_inc.o\
        $(SRCF90)/art_include_files/art_ray_control_inc.f90

$(OBJDIR)/art_runge_kutta_inc.o:  $(SRCF90)/art_include_files/*.f90
	$(F90C) $(F90FLAGS) -fixed\
        -o $(OBJDIR)/art_runge_kutta_inc.o\
        $(SRCF90)/art_include_files/art_runge_kutta_inc.f90

$(OBJDIR)/art_jobfile_1st_module.o:  $(SRCF90)/art_jobfile_1st/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_jobfile_1st_module.o\
        $(SRCF90)/art_jobfile_1st/art_jobfile_1st_module.f90

$(OBJDIR)/art_kind_real_module.o:  $(SRCF90)/art_kind_real/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_kind_real_module.o\
        $(SRCF90)/art_kind_real/art_kind_real_module.f90

$(OBJDIR)/art_lagrange_interp_module.o:  $(SRCF90)/art_lagrange_interp/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_lagrange_interp_module.o\
        $(SRCF90)/art_lagrange_interp/art_lagrange_interp_module.f90

$(OBJDIR)/art_runge_kutta_module.o:  $(SRCF90)/art_runge_kutta/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_runge_kutta_module.o\
        $(SRCF90)/art_runge_kutta/art_runge_kutta_module.f90

$(OBJDIR)/art_geo_model_module.o:  $(SRCF90)/art_geo_model/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_geo_model_module.o\
        $(SRCF90)/art_geo_model/art_geo_model_module.f90

$(OBJDIR)/art_kinetic_module.o:  $(SRCF90)/art_kinetic/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_kinetic_module.o\
        $(SRCF90)/art_kinetic/art_kinetic_module.f90

$(OBJDIR)/art_dynamic_module.o:  $(SRCF90)/art_dynamic/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_dynamic_module.o\
        $(SRCF90)/art_dynamic/art_dynamic_module.f90

$(OBJDIR)/art_kin_interp_module.o:  $(SRCF90)/art_kin_interp/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_kin_interp_module.o\
        $(SRCF90)/art_kin_interp/art_kin_interp_module.f90

$(OBJDIR)/art_raiuno_module.o:  $(SRCF90)/art_raiuno/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_raiuno_module.o\
        $(SRCF90)/art_raiuno/art_raiuno_module.f90

$(OBJDIR)/art_ray_tracer_1st_module.o:  $(SRCF90)/art_ray_tracer_1st/*.f90
	$(F90C) $(F90FLAGS) -o $(OBJDIR)/art_ray_tracer_1st_module.o\
        $(SRCF90)/art_ray_tracer_1st/art_ray_tracer_1st_module.f90

#----------------------------------------------------------------

f77lib:
	make -f makefile_f77

#----------------------------------------------------------------

ikulib:
	cp $(IKULIB)/iku_io_module.mod $(ARTLIB)
	cp $(IKULIB)/iku_constants_module.mod $(ARTLIB)
	cp $(IKULIB)/iku_io_module.mod .
	cp $(IKULIB)/iku_constants_module.mod .

#----------------------------------------------------------------

clean:
	rm $(OBJDIR)/*.o
	rm *.mod










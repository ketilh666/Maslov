echo coldrays.job > nhin
cp Rayini_Up_Dec10.ascii SeaFloor_for_3DRT_CoarseUp_varQ.ascii
../linux/bin/art_rt_1st < nhin > nhut
b2a < DB_RAY_XZ.DIR > DB_RAY_XZ.ASCII
b2a < DB_RAY_YZ.DIR > DB_RAY_YZ.ASCII
rm DB_*.DIR


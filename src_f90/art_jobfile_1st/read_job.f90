!**********************************************************************
!
!  IKU Seismic subroutine read_job
!
!
!  Purpose : Read jobfile for 3D anisotropic ray tracing
!            
!  Subroutines called :   none
!  Functions called   :   none
! 
!  Programmed         :   Jabuary 2000
!     
!**********************************************************************

subroutine read_job(lu,upars,uname)

   implicit none

   !--- External variables:
   integer              ,intent(in)  :: lu
   type(art_user_pars)  ,intent(out) :: upars
   type(art_user_names) ,intent(out) :: uname


   !--- Internal variables:
   integer :: i

   !-----------------------------------------------------------------
   !    Input formats
   !-----------------------------------------------------------------

1  format(40x,a40)
2  format(40x,i8)
3  format(40x,f12.6)
4  format(A)

   !-----------------------------------------------------------------
   !    Read jobfile
   !-----------------------------------------------------------------

   !--- Jobfile header:
   read(lu,*)
   read(lu,*)
   read(lu,*)

   !--- General parameters:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,2)upars%is_frst
   read(lu,2)upars%is_last
   read(lu,2)upars%is_step
  
   !--- Initial polar and azimuth angles
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,2)upars%npol
   read(lu,2)upars%naz2
   read(lu,3)upars%apol1
   read(lu,3)upars%apol2
   read(lu,3)upars%aazi1
   read(lu,3)upars%aazi2

   !--- Adaptive 4th order Runge Kutta: 
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,2)upars%maxel
   read(lu,3)upars%t0
   read(lu,3)upars%t1
   read(lu,3)upars%h0
   read(lu,3)upars%hmin
   read(lu,3)upars%accur

   !--- Ray tracing options:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,1)upars%ckin
   read(lu,1)upars%cdyn2
   read(lu,1)upars%cdir
   read(lu,1)upars%cevin      ! How to solve the Christoffel equation
   read(lu,1)uname%sor_pos
   read(lu,1)uname%rec_pos
   read(lu,1)uname%ray_qs1
   read(lu,1)uname%head_qs1
   read(lu,1)uname%ray_qs2
   read(lu,1)uname%head_qs2
   read(lu,1)uname%ray_qp
   read(lu,1)uname%head_qp

   !--- Gridded geological model:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,1)upars%casino
   read(lu,1)upars%cmodpar
   read(lu,2)upars%nxglb(1)
   read(lu,2)upars%nxglb(2)
   read(lu,2)upars%nxglb(3)
   read(lu,3)upars%dxglb(1)
   read(lu,3)upars%dxglb(2)
   read(lu,3)upars%dxglb(3)
   read(lu,2)upars%npoly
   read(lu,1)uname%rho
   do i=1,max_elk_fil
      read(lu,1)uname%elk(i)
   end do

   do i=max_elk_fil+1,21
      uname%elk(i) = 'none : not used'
   enddo

   !--- Logfile and scratch directories:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,1)uname%joblog
   read(lu,1)uname%errmsg
   read(lu,1)uname%wrkdir1
   read(lu,1)uname%wrkdir2

   !--- File formats:
   read(lu,*)
   read(lu,*)
   read(lu,*)  
   read(lu,1)upars%fio_cube
   read(lu,1)upars%fio_head
   read(lu,1)upars%fio_gmod
   read(lu,1)upars%fio_ray

!-----------------------------------------------------------------------
end subroutine read_job
!-----------------------------------------------------------------------


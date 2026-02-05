!*********************************************************************         
!
!  IKU Seismic subroutine read_geo_mod
!
!  Purpose : Read elastic model from disk
!
!  Programmed  :   Ketil Hokstad November 1999 
!
!**********************************************************************
    
subroutine read_geo_mod(files,gmod,flag,ind1st)

   implicit none

   !--- External variables: 
   type(art_geo_files),intent(inout) :: files    ! Input files
   type(art_geo_mod)  ,intent(inout) :: gmod     ! Elastic model
   type(art_geo_ctrl) ,intent(inout) :: flag
   integer            ,intent(in)    :: ind1st   ! ind1st = 1 for (x,y,z) order
                                                 ! ind1st = 3 for (z,x,y) order

   !--- Internal variables:  
   integer            ::  j, jx,jy,jz
   real(kr4),pointer  :: rwrk(:,:,:)    ! IO work array

!-----------------------------------------------------------------------
!  Read velocities and Thomsen parameters
!-----------------------------------------------------------------------

   if (ind1st==1) then

      write(6,*) 'read_geo_mod (x,y,z): ind1st=',ind1st
      !--- Index order on file is (x,y,z): straight forward
      do j=1,gmod%nelk
         if (flag%lelk(j)) call iku_read(files%elk(j),gmod%elk(:,:,:,j))
      end do

      if (flag%lrho) call iku_read(files%rho,gmod%rho(:,:,:))

   else

      write(6,*) 'read_geo_mod (z,x,y): ind1st=',ind1st
      !--- Index order on file is (z,x,y): Need to swap indices
      allocate(rwrk(gmod%nz,gmod%nx,gmod%ny))

      do j=1,gmod%nelk
         if (flag%lelk(j)) then 
            !--- read
            call iku_read(files%elk(j),rwrk)
            !--- swap index order:
            do jz=1,gmod%nz
               do jy=1,gmod%ny
                  do jx=1,gmod%nx
                     gmod%elk(jx,jy,jz,j) = rwrk(jz,jx,jy)
                  end do
               end do
            end do

         end if
      end do

      if (flag%lrho) then 
         !--- read
         call iku_read(files%rho,rwrk)
         !--- swap index order:
         do jz=1,gmod%nz
            do jy=1,gmod%ny
               do jx=1,gmod%nx
                  gmod%rho(jx,jy,jz) = rwrk(jz,jx,jy)
               end do
            end do
         end do
      end if

   
      deallocate(rwrk)


   end if


!-----------------------------------------------------------------------
end subroutine read_geo_mod
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine open_geo_files
!
!  Purpose : Open disk files with gridded geological model
!
!  Programmed  :   Ketil Hokstad January 2000
!
!**********************************************************************
    
subroutine open_geo_files(files,flag,name_elk,name_rho,action,form,nrecl)

   type(art_geo_files) ,intent(out) :: files
   type(art_geo_ctrl)  ,intent(in)  :: flag
   character(len=*)    ,intent(in)  :: name_elk(21) 
   character(len=*)    ,intent(in)  :: name_rho
   character(len=*)    ,intent(in)  :: action    ! Read/write
   character(len=*)    ,intent(in)  :: form      ! dir/seq
   integer             ,optional    :: nrecl     ! Rec length (dir only)

   !--- Internal variables:
   integer :: mrecl
   integer :: j

!!$   write(6,*) 'open_geo_files: form = ',form

   !-----------------------------------------------------------------
   !   Check optional parameters
   !-----------------------------------------------------------------

   if (present(nrecl)) mrecl = nrecl

   !--------------------------------------------------------------------
   !   Open geological model files
   !--------------------------------------------------------------------

   do j=1,21
      if (flag%lelk(j)) call iku_open(files%elk(j),name_elk(j), &
                                      action,form,mrecl)
   end do

   if (flag%lrho) call iku_open(files%rho,name_rho,action,form,mrecl)

!-----------------------------------------------------------------------
end subroutine open_geo_files
!-----------------------------------------------------------------------

!*********************************************************************         
!
!  IKU Seismic subroutine close_geo_files
!
!  Purpose : Close disk files with gridded geological model
!
!  Programmed  :   Ketil Hokstad January 2000
!
!**********************************************************************
    
subroutine close_geo_files(files,flag)

   type(art_geo_files) ,intent(out) :: files
   type(art_geo_ctrl)  ,intent(in)  :: flag

   !--- Internal variables:
   integer :: j

   !--------------------------------------------------------------------
   !   Close geological model files
   !--------------------------------------------------------------------

   do j=1,21
      if (flag%lelk(j)) call iku_close(files%elk(j))
   end do

   if (flag%lrho) call iku_close(files%rho)

!-----------------------------------------------------------------------
end subroutine close_geo_files
!-----------------------------------------------------------------------


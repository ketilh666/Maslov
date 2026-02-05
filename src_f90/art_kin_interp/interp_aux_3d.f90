!********************************************************************* 
!
!  IKU Seismic subroutine three_corners
!
!  Purpose : Find the ray indices for the three vertices (corners)
!            of the current triangle.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine three_corners(kr1,kr2,kr3,lred,lblack,jr1,jr2,     &
                         jinsect,ninsect,ir1,ir2,jtrek,ntrek)

   implicit none

   !--- External variables: 
   logical ,intent(inout)  :: lred,lblack ! Color of current triangle
   integer ,intent(inout)  :: kr1,kr2,kr3 ! Vertices
   integer ,intent(inout)  :: jr1,jr2     ! Current ray indices
   integer ,intent(inout)  :: jinsect     ! Index in current sector 
   integer ,intent(in)     :: ninsect     ! Number of triangles per sector
   integer ,intent(in)     :: ir1,ir2     ! Initial ray indices
   integer ,intent(in)     :: jtrek,ntrek ! Current an no of triangle

   !--- Internal variables: 

   !---------------------------------------------------
   !  Get the vertex-rays of the current triangle
   !  The code is rather obscure, but it works
   !  Keep your hands off
   !---------------------------------------------------
 
   !--- Update the color:
   if (jinsect .eq. ninsect) then
      lred    = .true.
      lblack  = .not.lred
      jinsect = 1
   else
      lred    = .not.lred
      lblack  = .not.lblack
      jinsect = jinsect+1
   end if
   
   !--- Get the vertices:
   if     (lred  ) then
      !--- Red   triangle:
      if (jtrek.lt.ntrek  ) then
         !--- The normal case:
         kr1 = jr1
         kr2 = jr2
         kr3 = jr2+1
      else
         !--- Close the circle:
         kr1 = ir1
         kr2 = jr2
         kr3 = ir2
      endif
      jr2 = jr2+1
   elseif (lblack) then
      !--- Black triangle:
      if (jtrek.lt.ntrek-1) then
         !--- The normal case:
         kr1 = jr1
         kr2 = jr2
         kr3 = jr1+1
      else
         !--- Close the circle:
         kr1 = jr1
         kr2 = jr2
         kr3 = ir1
      end if
      jr1 = jr1+1
   else
      write(6,*) ' # three_corners: Oh Shit!!!!'
   end if
   
!--------------------------------------------------------------
end subroutine three_corners
!--------------------------------------------------------------

!********************************************************************* 
!
!  IKU Seismic subroutine three_edges
!
!  Purpose : Get the coordinates of the vertex-rays in the
!            xy-plane and the heads and tails of the
!            corresponding edge vectors.
!
!  Subroutines called : none
!                 f77 : SHELLA
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine three_edges(isort,vhead,vtail,vertx,nc,ned)

   implicit none

   !--- External variables: 
   integer   ,intent(out)   :: isort(ned)    ! Sort index array
   real(krx) ,intent(out)   :: vhead(nc,ned) ! Heads of edge vectors
   real(krx) ,intent(out)   :: vtail(nc,ned) ! Tails of edge vectors
   real(krx) ,intent(in)    :: vertx(nc,ned) ! Vertices
   integer   ,intent(in)    :: nc,ned      

   !--- Internal variables: 
   real(kr4) :: wrk3(ned)
   integer   :: ie1,ie2,ie3

   !----------------------------------------------------
   !  Sort vertices in ascending order on y-coord.
   !----------------------------------------------------

   wrk3(1:ned) = real(vertx(2,1:ned),kind=kr4)
   call SHELLA(ned,wrk3,isort)

   !----------------------------------------------------
   !  Set up the system of edge vectors.
   !  Vectors must point in positive y-dirextion.
   !----------------------------------------------------

   ie1 = isort(1)
   ie2 = isort(2)
   ie3 = isort(3)

   !--- Edge 1:
   vtail(1:2,1) = vertx(1:2,ie1)
   vhead(1:2,1) = vertx(1:2,ie2)

   !--- Edge 2:
   vtail(1:2,2) = vertx(1:2,ie1)
   vhead(1:2,2) = vertx(1:2,ie3)

   !--- Edge 3:
   vtail(1:2,3) = vertx(1:2,ie2)
   vhead(1:2,3) = vertx(1:2,ie3)

!!$   isort(1) = 1
!!$   isort(2) = 2
!!$   isort(3) = 3

!--------------------------------------------------------------
end subroutine three_edges
!--------------------------------------------------------------

!********************************************************************* 
!
!  IKU Seismic subroutine three_weights
!
!  Purpose : Get the coordinates of the vertex-rays in the
!            xy-plane and the heads and tails of the
!            corresponding edge vectors.
!
!  Subroutines called : none
!                 f77 : SHELLA
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine three_weights(weight,xgrid,vertx,nc,ned)

   implicit none

   !--- External variables: 
   real(krx) ,intent(out)   :: weight(ned)   ! Sort index array
   real(krx) ,intent(in)    :: xgrid(nc)     ! Current grid point
   real(krx) ,intent(in)    :: vertx(nc,ned) ! Vertices
   integer   ,intent(in)    :: nc,ned      

   !--- Internal variables: 
   real(krx) :: xoff(nc,ned)
   real(krx) :: wrk1,wrk3(ned)

   !----------------------------------------------------
   !  Distance from gridpoint to vertices
   !----------------------------------------------------

   xoff(1,1) = xgrid(1)-vertx(1,1)
   xoff(1,2) = xgrid(1)-vertx(1,2)
   xoff(1,3) = xgrid(1)-vertx(1,3)
   xoff(2,1) = xgrid(2)-vertx(2,1)
   xoff(2,2) = xgrid(2)-vertx(2,2)
   xoff(2,3) = xgrid(2)-vertx(2,3)

   !----------------------------------------------------
   !  Interpolation weights
   !----------------------------------------------------

   !--- Unormalized weights:
   wrk3(1)   = xoff(1,3)*xoff(2,2)-xoff(1,2)*xoff(2,3)
   wrk3(2)   = xoff(1,1)*xoff(2,3)-xoff(1,3)*xoff(2,1)
   wrk3(3)   = xoff(1,2)*xoff(2,1)-xoff(1,1)*xoff(2,2)
   
   !--- Normalization:
   wrk1      = 1.0/(wrk3(1)+wrk3(2)+wrk3(3))
   weight(1) = wrk1*wrk3(1)
   weight(2) = wrk1*wrk3(2)
   weight(3) = wrk1*wrk3(3)

!--------------------------------------------------------------
end subroutine three_weights
!--------------------------------------------------------------

!********************************************************************* 
!
!  IKU Seismic subroutine iy_in_trek
!
!  Purpose : Compute first and last integer y-coordinate
!            inside triangle.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine iy_in_trek(iy1,iy2,ny,x0grid,dxgrid,vhead,vtail,nc,ned)

   implicit none

   !--- External variables: 
   integer   ,intent(out)   :: iy1,iy2       ! First and last iy
   integer   ,intent(in)    :: ny            ! iy2<=ny 
   real(krx) ,intent(in)    :: x0grid(nc)    ! Upper left corner of grid
   real(krx) ,intent(in)    :: dxgrid(nc)    ! Sampling of the grid
   real(krx) ,intent(in)    :: vhead(nc,ned) ! Heads of edge vectors
   real(krx) ,intent(in)    :: vtail(nc,ned) ! Tails of edge vectors
   integer   ,intent(in)    :: nc,ned      

   !--- Internal variables: 
   real(krx) :: y1,y2

   !----------------------------------------------------
   !  compute first and last iy
   !----------------------------------------------------

   y1  = minval(vtail(2,1:ned))
   y2  = maxval(vhead(2,1:ned))
   iy1 = max(int((y1-x0grid(2))/dxgrid(2)) + 2,1)
   iy2 = min(int((y2-x0grid(2))/dxgrid(2)) + 1,ny)

!---------------------------------------------------------------
end subroutine iy_in_trek
!---------------------------------------------------------------

!********************************************************************* 
!
!  IKU Seismic subroutine ix_in_trek
!
!  Purpose : Compute first and last integer y-coordinate
!            inside triangle.
!
!  Subroutines called : none
!  Functions called   : none
!
!  Programmed  :   Ketil Hokstad March  2000
!
!**********************************************************************
    
subroutine ix_in_trek(ix1,ix2,nx,x0grid,dxgrid,xgrid,      &
                      ie1,ie2,vhead,vtail,nc,ned)

   implicit none

   !--- External variables: 
   integer   ,intent(out)   :: ix1,ix2       ! First and last ix
   integer   ,intent(in)    :: nx            ! ix2<=nx 
   integer   ,intent(in)    :: ie1,ie2       ! Active edges
   real(krx) ,intent(in)    :: x0grid(nc)    ! Upper left corner of grid
   real(krx) ,intent(in)    :: dxgrid(nc)    ! Sampling of the grid
   real(krx) ,intent(in)    :: xgrid(nc)     ! Current grid point
   real(krx) ,intent(in)    :: vhead(nc,ned) ! Heads of edge vectors
   real(krx) ,intent(in)    :: vtail(nc,ned) ! Tails of edge vectors
   integer   ,intent(in)    :: nc,ned      

   !--- Internal variables: 
   real(kr4) :: x1,x2,a1,a2,w1,w2

   !----------------------------------------------------
   !  Compute first and last ix
   !----------------------------------------------------

   a1  = (vhead(1,ie1)-vtail(1,ie1))/    &
         (vhead(2,ie1)-vtail(2,ie1))
   a2  = (vhead(1,ie2)-vtail(1,ie2))/    &
         (vhead(2,ie2)-vtail(2,ie2))
   w1  = vtail(1,ie1) + a1*(xgrid(2)-vtail(2,ie1))
   w2  = vtail(1,ie2) + a2*(xgrid(2)-vtail(2,ie2))
   x1  = min(w1,w2)
   x2  = max(w1,w2)
   ix1 = max(int((x1-x0grid(1))/dxgrid(1)) + 2,1)
   ix2 = min(int((x2-x0grid(1))/dxgrid(1)) + 1,nx)

!---------------------------------------------------------------
end subroutine ix_in_trek
!---------------------------------------------------------------


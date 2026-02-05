C************************************************************************
C
C SUBROUTINE RK_PAR
C
C PURPOSE: Return parameters in the include file runge_kutta.inc
C
C SUBROUTINES CALLED : NONE
C FUNCTIONS CALLED   : NONE
C
C PROGRAMMED         : KETIL HOKSTAD OCTOBER 1999
C
C************************************************************************

      SUBROUTINE RK_PAR(NXSTEP,IKIN,IDYN1,IDYN2,IDYN,IKAD,IMAX)

      IMPLICIT NONE

C---  External output variables:
      INTEGER    NXSTEP,IKIN,IDYN1,IDYN2,IDYN,IKAD,IMAX

C---  Parameters:
      INCLUDE '../include_files/runge_kutta.inc'

C---  Internal variables:

C-----------------------------------------------------------------------
C     Parameters in the include file runge_kutta.inc
C-----------------------------------------------------------------------

      NXSTEP = MXSTEP  ! Max no of Runge-Kutta steps
      IKIN   = NKIN    ! Dim of kinetic raytracing system
      IDYN1  = NDYN1   ! Dim of dynamic raytracing system
      IDYN2  = NDYN2   ! Dim of double dynamic system
      IDYN   = NDYN    ! Dim of kinetic+dynamic systems
      IKAD   = NKAD    ! Dim of kinetic+double dynamic
      IMAX   = NMAX    ! Max dim of raytracing system

C-----------------------------------------------------------------------
      RETURN
      END
C-----------------------------------------------------------------------
C   END OF SUBROUTINE RK_PAR
C-----------------------------------------------------------------------



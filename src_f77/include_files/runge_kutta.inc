C***********************************************************************
C INCLUDE FILE runge_kutta.inc
C
C PURPOSE: Define parameters for Runge-Kutta integration of kinetic  
C          and/or dynamic raytracing systems.
C
C PROGRAMMED : KETIL HOKSTAD DECEMBER 1998
C              KETIL HOKSTAD JANUARY  1999
C
C***********************************************************************

      INTEGER    MXSTEP,NKIN,NDYN1,NDYN2,NDYN,NKAD,NMAX
      PARAMETER (MXSTEP=1000)       ! Max no of Runge-Kutta steps
      PARAMETER (NKIN = 6)          ! Dim of kinetic raytracing system
      PARAMETER (NDYN1=12)          ! Dim of dynamic raytracing system
      PARAMETER (NDYN2=2*NDYN1)     ! Dim of double dynamic system
      PARAMETER (NDYN =NKIN+NDYN1)  ! Dim of kinetic+dynamic systems
      PARAMETER (NKAD =NKIN+NDYN2)  ! Dim of kinetic+double dynamic
      PARAMETER (NMAX =NKAD)        ! Max dim of raytracing system

C***********************************************************************
C   END OF INCLUDE FILE runge_kutta.inc
C***********************************************************************


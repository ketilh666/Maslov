!************************************************************************
!*****                                                             ******
!***  i  k  u    s  e  i  s  m  i  c    s  u  b  r  o  u  t  i  n  e ****
!*                                                                     **
!***                        s t r s t r                              ****
!*****                                                             ******
!************************************************************************

   subroutine strstr(string,length)
      
      character*(*) :: string
      integer       :: length
      
      integer       :: i, loindx, hiindx, indmin, indmax
      character*240 :: buffer

      
      hiindx = len(string)
      loindx = 1

      indmin = 0
      indmax = 0
      
      do i = 1, hiindx
         if (string(i:i) .ne. ' ') then
            indmin = i
            exit
         endif
      enddo
      
      do i = hiindx, indmin+1, -1
         if (string(i:i) .ne. ' ') then
            indmax = i
            exit
         endif
      enddo
      
      if ( (indmin .eq. 0) .or. (indmax .eq. 0) ) then
         length = 0
         buffer = ''
      else
         length = indmax - indmin + 1
         buffer = string(indmin:indmax)
      endif
      
      string = buffer(1:length)
      
   end subroutine strstr

!************************************************************************
!*****                                                             ******
!***  i  k  u    s  e  i  s  m  i  c    s  u  b  r  o  u  t  i  n  e ****
!*                                                                     **
!***  lower_case   ( transforms all characters into lower case )     ****
!*****                                                             ******
!************************************************************************

 subroutine lower_case( string )
   character(len=*) :: string
   integer          :: i,v

   do i=1,len(string)
     v = iachar(string(i:i))
     if((v .gt. 64).and.(v .lt. 91)) string(i:i) = achar(v+32)
   end do

 end subroutine lower_case




   !   **   segy  **   segy   **   segy  **   segy   **   segy  ** :

   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     wrehdr - write selected parameters from a segy file header
   !     Arild Buland 1995
   !
   !**************************************************************
   subroutine wrehdr( lu, ebchdr, irehdr )
      include      'segyio.f.h'
      character*1  ebchdr(iymebc)
      integer      lu,irehdr(iymreh)
      integer      i,j

      write(lu,*) ' ebcdic reel header:'
      write(lu,'()')

      do j = 1, 40
          write(lu,'(80a1)') (ebchdr((j-1)*80+i), i=1,80)
      enddo
      write(lu,*) '/**/'
      write(lu,*) ' binary reel header (secected fields):'
      write(lu,*) ' line number               : ',irehdr(iylnum)
      write(lu,*) ' reel number               : ',irehdr(iyrnum)
      write(lu,*) ' data traces/record        : ',irehdr(iydtpr)
      write(lu,*) ' aux. traces/record        : ',irehdr(iyanum)
      write(lu,*) ' sample interval(micro sec): ',irehdr(iysint)
      write(lu,*) ' no. samples/trace         : ',irehdr(iysptr)
      write(lu,*) ' data format               : ',irehdr(iyform)
      write(lu,*) ' cdp fold                  : ',irehdr(iyfold)
      write(lu,*) ' measurement system        : ',irehdr(iysi  )
      write(lu,'()')

   end subroutine wrehdr



   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     wrehdr - write selected parameters from segy trace header
   !     Arild Buland 1995
   !
   !**************************************************************
   subroutine wtrhdr(lu,itrhdr)
      include    'segyio.f.h'
      integer    lu, itrhdr(iymtrh)

      write(lu,*)' binary trace header'
      write(lu,*)' trace seq. number within line :',itrhdr(1)
      write(lu,*)' orig. field rec.no (shot) ffid:',itrhdr(3)
      write(lu,*)' trace no    (ch/cmp)      chan:',itrhdr(4)
      write(lu,*)' source point number     source:',itrhdr(5)
      write(lu,*)' cdp ensemble number        cdp:',itrhdr(6)
      write(lu,*)' trace no within cdp           :',itrhdr(7)
      write(lu,*)' trace id code                 :',itrhdr(8)
      write(lu,*)' fold                          :',itrhdr(10)
      write(lu,*)' offset                  offset:',itrhdr(12)
      write(lu,*)' delay recording time (ms)     :',itrhdr(36)
      write(lu,*)' no. samples                   :',itrhdr(39)
      write(lu,*)' samp. interval                :',itrhdr(40)

      write(lu,'()')
   end subroutine wtrhdr



   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     setebc - make the seg-y reel identification header
   !              part 1 : ebcdic
   !     Arild Buland 1995
   !
   !**************************************************************
   subroutine setebc( ebchdr )

      character*1   ebchdr(3200)

      character*80  str1, str2, str3, str4, str5
      character*80  str6, str7, str8, str9, str10
      character*80  str11,str12,str13,str14,str15
      character*80  str16,str17,str18,str19,str20
      character*80  str21,str22,str23,str24,str25
      character*80  str26,str27,str28,str29,str30
      character*80  str31,str32,str33,str34,str35
      character*80  str36,str37,str38,str39,str40

      integer       i


      ! Initialize seg-y header arrays :
      do i = 1, 3200
         ebchdr(i) = ' '
      enddo

      !----------------------------------------------------------------
      !  Reel identification header. Part 1, the ebcdic block
      !-------------         1         2         3         4
      !-------------1234567890123456789012345678901234567890
      !----------------------------------------------------------------
      str1 = 'c 1                                     '
      str2 = 'c 2     IKU PETROLEUM RESEARCH          '
      str3 = 'c 3                                     '
      str4 = 'c 4     SEISMIC METHODS SECTION         '
      str5 = 'c 5                                     '
      str6 = 'c 6                                     '
      str7 = 'c 7                                     '
      str8 = 'c 8                                     '
      str9 = 'c 9                                     '
      str10= 'c10                                     '
      str11= 'c11                                     '
      str12= 'c12                                     '
      str13= 'c13                                     '
      str14= 'c14                                     '
      str15= 'c15                                     '
      str16= 'c16                                     '
      str17= 'c17                                     '
      str18= 'c18                                     '
      str19= 'c19                                     '
      str20= 'c20                                     '
      str21= 'c21                                     '
      str22= 'c22                                     '
      str23= 'c23                                     '
      str24= 'c24                                     '
      str25= 'c25                                     '
      str26= 'c26                                     '
      str27= 'c27                                     '
      str28= 'c28                                     '
      str29= 'c29                                     '
      str30= 'c30                                     '
      str31= 'c31                                     '
      str32= 'c32                                     '
      str33= 'c33                                     '
      str34= 'c34                                     '
      str35= 'c35                                     '
      str36= 'c36                                     '
      str37= 'c37                                     '
      str38= 'c38                                     '
      str39= 'c39                                     '
      str40= 'c40                                     '

      do i = 1, 40
         ebchdr(     i) = str1(i:i)
         ebchdr(80*1+i) = str2(i:i)
         ebchdr(80*2+i) = str3(i:i)
         ebchdr(80*3+i) = str4(i:i)
         ebchdr(80*4+i) = str5(i:i)
         ebchdr(80*5+i) = str6(i:i)
         ebchdr(80*6+i) = str7(i:i)
         ebchdr(80*7+i) = str8(i:i)
         ebchdr(80*8+i) = str9(i:i)
         ebchdr(80*9+i) = str10(i:i 
         ebchdr(80*10+i) = str11(i:i)
         ebchdr(80*11+i) = str12(i:i)
         ebchdr(80*12+i) = str13(i:i)
         ebchdr(80*13+i) = str14(i:i)
         ebchdr(80*14+i) = str15(i:i)
         ebchdr(80*15+i) = str16(i:i)
         ebchdr(80*16+i) = str17(i:i)
         ebchdr(80*17+i) = str18(i:i)
         ebchdr(80*18+i) = str19(i:i)
         ebchdr(80*19+i) = str20(i:i)
         ebchdr(80*20+i) = str21(i:i)
         ebchdr(80*21+i) = str22(i:i)
         ebchdr(80*22+i) = str23(i:i)
         ebchdr(80*23+i) = str24(i:i)
         ebchdr(80*24+i) = str25(i:i)
         ebchdr(80*25+i) = str26(i:i)
         ebchdr(80*26+i) = str27(i:i)
         ebchdr(80*27+i) = str28(i:i)
         ebchdr(80*28+i) = str29(i:i)
         ebchdr(80*29+i) = str30(i:i)
         ebchdr(80*30+i) = str31(i:i)
         ebchdr(80*31+i) = str32(i:i)
         ebchdr(80*32+i) = str33(i:i)
         ebchdr(80*33+i) = str34(i:i)
         ebchdr(80*34+i) = str35(i:i)
         ebchdr(80*35+i) = str36(i:i)
         ebchdr(80*36+i) = str37(i:i)
         ebchdr(80*37+i) = str38(i:i)
         ebchdr(80*38+i) = str39(i:i)
         ebchdr(80*39+i) = str40(i:i)
      enddo

   end subroutine setebc





   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     setreel - set values in the segy reel header.
   !     Arild Buland 1995
   !
   !**************************************************************
   subroutine setreel( irehdr, nrec, dt, nt, nfold )
      include    'segyio.f.h'

      integer  irehdr(iymreh)
      integer  nrec, nt, nfold, i
      real     dt

      do i = 1, iymreh
         irehdr(i) = 0
      enddo

      !-----line number:
      irehdr(iylnum) = 1 
      !-----reel number:
      irehdr(iyrnum) = 1 
      !-----data traces/record:
      irehdr(iydtpr) = nrec 
      !-----no. aux. traces/record:
      irehdr(iyanum) = 0 
      !-----sample period (micro sec):
      irehdr(iysint) = nint( dt*1000 ) 
      !-----no. of samples/trace:
      irehdr(iysptr) = nt 
      !-----data format:
      irehdr(iyform) = 1 
      !-----cdp fold:
      irehdr(iyfold) = nfold 
      !-----measurement system:
      irehdr(iysi) = 1 

   end subroutine setreel




   !**************************************************************
   !
   !     IKU seismic I/O routines
   !     sethdr - set values in the segy trace header.
   !     Arild Buland  1995
   !
   !**************************************************************
   subroutine sethdr( itrhdr, ishot, ix, x, nt, dt )
      include    'segyio.f.h'

      integer  itrhdr(iymtrh)
      integer  ishot, ix, nt, i
      real     x, dt

      do i = 1, iymtrh
         itrhdr(i) = 0
      enddo

      !-----trace sequence:
      itrhdr(1)  = 1 
      !-----field record number (shot) (ffid):
      itrhdr(3)  = ishot 
      !-----trace number in orig. field record:
      itrhdr(4)  = ix 
      !-----source point number (source):
      itrhdr(5)  = ishot 
      !-----cdp ensemble number (cdp):
      itrhdr(6)  = ishot 
      !-----trace number within cdp:
      itrhdr(7)  = ix 
      !-----trace id. code :  1 = seismic data:
      itrhdr(8)  = 1 
      !-----fold:
      itrhdr(10) = 0 
      !-----offset:
      itrhdr(12) = x 
      !-----receiver group elevation:
      itrhdr(13) = 0 
      !-----surface elevation at source:
      itrhdr(14) = 0 
      !-----source depth below surface:
      itrhdr(15) = 0 
      !-----water depth at source:
      itrhdr(18) = 0 
      !-----water depth at receiver:
      itrhdr(19) = 0 
      !-----number of samples in (this) trace:
      itrhdr(39) = nt 
      !-----sampling interval:
      itrhdr(40) = int( dt*1000. ) 

   end subroutine sethdr











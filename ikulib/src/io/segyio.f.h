C**********************************************************************
C
C  TOF magic.inc                            
C  SEG-Y Magic Numbers (index to headers)   
C                                                                     
C  Refer to Barry et. al.:                                            
C     Recommended standards for digital tape formats, SEG 1975.
C
C  Each parameter in the headers are assumed located in one cell      
C  in an array. The following magic numbers are indexes to these     
C  (two) arrays:             
C                                                                     
C  IYMREC : 64000: Maximal size of file record in bytes .             
C                                                                     
C  IYMEBC :  3200: Dimension of Reel Character header.                
C  IYMREH :   197: Dimension of Reel header array.                    
C  IYMTRH :   101: Dimension of Trace header array.                   
C                                                                     
C  Reel identification header indexes:                     
C                                                                     
C  IYLNUM :  2: Line number.                                          
C  IYRNUM :  3: Reel number.                                          
C  IYDTPR :  4: Number of data traces per record.                     
C  IYANUM :  5: Number of aux. traces per record.                     
C  IYSINT :  6: Sample interval in micro seconds.                     
C  IYSPTR :  8: Number of samples per data trace.                     
C  IYFORM : 10: Data sample format code.                              
C  IYFOLD : 11: CDP fold.                                             
C  IYSI   : 25: Measurement system (meters/feet)                      
C                                                                     
C                                                                     
C  Trace identification header indexes:
C                                                                     
C  IYTSEQ :  1:   1-  4: Trace sequence number within line.            
C  IYOFRN :  3:   9- 12: Original field record number.                 
C  IYOFTN :  4:  13- 16: Trace number within the original field record.
C  IYCMPN :  6:  21- 24: CMP number.                                   
C  IYTRID :  8:  29- 30: Trace identification code. (1=seismic data)   
C  IYDREC : 36: 109-110: Delay recording time (ms).                    
C  IYNOSA : 39: 115-116: Number of samples in this trace.              
C  IYDTTR : 40: 117-118: Sample interval in micro s. for this trace.   
C                                                                     
C**********************************************************************

      INTEGER   IYMREC
      INTEGER   IYMEBC, IYMREH, IYMTRH
      INTEGER   IYLNUM, IYRNUM, IYDTPR, IYANUM, IYSINT
      INTEGER   IYSPTR, IYFORM, IYFOLD, IYSI
      INTEGER   IYTSEQ, IYOFRN, IYOFTN, IYTRID, IYNOSA
      INTEGER   IYDTTR, IYCMPN, IYDREC

C ... Var. dimensions:
      PARAMETER	 (IYMREC=64000)
      PARAMETER	 (IYMEBC=3200, IYMREH=197, IYMTRH=101)

C ... Reel identification header:
      PARAMETER	 (IYLNUM= 2, IYRNUM= 3, IYDTPR= 4, IYANUM= 5)
      PARAMETER	 (IYSINT= 6, IYSPTR= 8, IYFORM=10, IYFOLD=11)
      PARAMETER  (IYSI  =25)

C ... Trace identification header:
      PARAMETER	 (IYTSEQ= 1, IYOFRN= 3, IYOFTN= 4, IYTRID= 8)
      PARAMETER	 (IYNOSA=39, IYDTTR=40, IYCMPN= 6, IYDREC=36)

C ... EOF magic.inc





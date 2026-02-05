program art_main_rt

   use iku_io_module   
   use iku_constants_module   
   use art_jobfile_module
   use art_ray_tracing_module

   implicit none

   integer              :: lujob,lulog
   type(file_type)      :: file_job 
   type(file_type)      :: file_log 
   type(art_user_pars)  :: upars       ! Parameters from the jobfile
   character(len=80)    :: name_job
   
   !--------------------------------------------------------------------
   !   Read jobfile
   !--------------------------------------------------------------------   

11 format(a)
   write(6,11) '*** ART_RT Version 1.0 (2nd) ***'
   write(6,FMT=11,ADVANCE='NO') 'Job file name: '     
   read (5,11) name_job
   write(6,11) name_job

   call iku_open(file_job,name_job,'READ','ASCII')
   lujob = iku_get_file_unit(file_job)
   call read_job(lujob,upars)
   call iku_close(file_job)

   !--------------------------------------------------------------------
   !   Open logfile
   !--------------------------------------------------------------------   

   call iku_open(file_log,upars%name_log_file,'WRITE','ASCII')
   lulog = iku_get_file_unit(file_log)

   call write_job(lulog,upars)

   !--------------------------------------------------------------------
   !   Perform ray tracing
   !--------------------------------------------------------------------   

   call art_ray_tracing(upars,lulog)

   !--------------------------------------------------------------------
   !   Close logfile
   !--------------------------------------------------------------------   

   write(6,*) 'CLOSE LOGFILE'
   call iku_close(file_log)
   write(6,*) 'THE END'

!-------------------------------------------------------------------------
 end program art_main_rt
!-------------------------------------------------------------------------












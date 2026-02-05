/*
**
** Known systems: 
** UNIX   -- Default UNIX, C version (HP9000/350, HP9000/840)
** UX350F -- HP 9000/350, UNIX, FORTRAN77.
** UX840F -- HP 9000/840, UNIX, FORTRAN77.
**
*/

#define UNIX   1

/** 
***
*** FSDRIV: Device dirvers for mini file system.
*** Used in SEGYIO, LISIO.
***
*** This software implements the "Device Handler" level
*** in various I/O libraries. These modules knows about
*** the physical media and the operating system. They do
*** not know about the content of the physical records
*** passed for I/O.
***
**/


/**
*** Various Flags
***/

/*
#define DEBUG  1   
*/

/**

 Modules available to outside world:
 ==================================

   fsindx(fnum)            --  Find internal index from world file number.
   fsfd(fnum)              --  File descriptor for specifyed file number.
   fsdef(fnum)             --  Define and reserve file number.
   fsoprd(fnum,fname)      --  Open file for input.
   fsopwr(fnum,fname)      --  Open file for output.
   fsread(fnum,buf,mbuf)   --  Read  mbuf bytes from file to buffer.
   fswrit(fnum,buf,mbuf)   --  Write mbuf bytes from buffer to file.
   fsclos(fnum)            --  Close file.

**/

/**

  System dependencies:
  ===================

**/
/**/

/**
***
*** Includes.
***
**/

#include <fcntl.h>		/* file control */
#include <stdio.h>		/* C standard i/o */
#include <errno.h>              /* Error indicator for system calls */
#include <math.h>               /* Math functions and constants */
extern int errno;

#include "fsdriv.h"             /* File system Error indicators */

#ifdef DEBUG
/* If in debugging mode, a function, debug(), is called */
/* tracing the modules executing.                       */
#include "debug.h"              /* Formats for debug() */
#endif

/**
***
*** System identification.
***
**/

/**/
/**
***
*** Declarations.
***
**/

/* Declarations of structures global WITHIN this module */

#define IFIL int        /* System file descriptors are integers */
                        /* for level 1 (raw) I/O */

struct fidtab {         /* Internal file system data base */
  int  no;              /* File number */
  IFIL fd;              /* File descriptor */
  int  status;          /* File status (as defined above) */
};


/* Declarations of variables global WITHIN this module */
                                 
                        /* Allocation of internal filsystem data base, */
			/* to enable more cuncurrent open files, simply */
			/* add more initializers. */
static struct fidtab fsys[] = {
  { FSUNUS, NULL, FSUNUS },
  { FSUNUS, NULL, FSUNUS },
  { FSUNUS, NULL, FSUNUS },
  { FSUNUS, NULL, FSUNUS }
};
                        /* Determine the number of concurrent files */
#define MAXFID (sizeof(fsys) / sizeof(struct fidtab))

/**/
/**
***
*** Internal functions used in this module.
***
**/

#ifdef DEBUG
#include "debug.c"      /* Include the function void debug()  */
#endif

/**/
/**
***
*** Internal File System.
***
**/


/*  F S I N D X  --  Find internal index from world file number */

/*  
** Returns the positive file index if filenumber is found.
**	   -1 if the filenumber dosen't exist as an opened file
*/

IFIL fsindx(fnum)
  int   fnum;           /* world file number (user defined) */
{
  int   i;                              /* Local def. */
#ifdef DEBUG
  char  s[100]; 
#endif

  for (i = 0; i < MAXFID; i++) {
    if (fsys[i].no == fnum &&
	fsys[i].fd != NULL) {
#ifdef DEBUG
        sprintf(s,"%d",fnum);
	debug(stderr,F111,"fsindx",s,i);
#endif
        return(i);                      /* Return internal index */
      }
  }
  return(EFSNOF);                       /* Filenumber not found */
} /* fsindx */



/*  F S F D      --  File descriptor for specifyed file number */

/*  
** Returns the file descriptor if filenumber is active.
**	  NULL  if the filenumber dosen't exist as an opened file
*/

int   fsfd(fnum)
  int   fnum;           /* world file number (user defined) */
{
  int   indx;

  if ((indx = fsindx(fnum)) >= 0)
    return(fsys[indx].fd);
  return(NULL);                           /* Filenumber not found */
} /* fsfd */
/**/



/*  F S D E F    --  Define and reserve file number */

/*  
** Returns the non negative file index if filenumber is reserved.
**        -1 if the filenumber already is reserved 
*/

int fsdef(fnum)
  int   fnum;           /* world file number (user defined) */
{
  int   i;

  if (fsindx(fnum) >= 0)
    return(EFSINU);                     /* Filenumber already reserved */
  for (i = 0; i < MAXFID; i++) {
    if (fsys[i].no == FSUNUS &&
	fsys[i].status == FSUNUS ) {
      fsys[i].no = fnum;                /* Updata data base */
      fsys[i].fd = NULL;
      fsys[i].status = FSRESV;
      return(i);                        /* Return internal index */
    }
  }
  return(EFSMAX);                       /* Filenumber not found */
} /* fsdef */
/**/

/*  F S O P R D  --  Open file for input. */

/*  
** Returns  0 if the is opned.
**         <0 if an error 
*/

int fsoprd(fnum,fname)
  int   fnum;           /* world file number (user defined) */
  char  *fname;         /* file name string */
{
  IFIL  fd;                             /* file des. */
  int   indx;                           /* file index. */

#ifdef DEBUG
  debug(stderr,F110,"fsoprd",fname,0);
#endif
  if ((indx = fsdef(fnum)) < 0) {       /* Define new file number */
    return(indx);
  }
					/* Open the file */
  if ((fd = open(fname,O_RDONLY)) == -1) {
    return(EFSOPR);
  } 
  fsys[indx].fd = fd;                   /* Update data base */
  fsys[indx].status = FSOPNR;
#ifdef DEBUG
  debug(stderr,F101,"fsoprd - exit","",0);
#endif
  return(0);
} /* fsoprd */
/**/


/*  F S O P W R  --  Open file for output. */

/*  
 * Returns  0 if the is opned.
 *         <0 if an error 
 */

int fsopwr(fnum,fname)
  int   fnum;           /* world file number (user defined) */
  char  *fname;         /* file name string */
{
  IFIL  fd;                             /* file des. */
  int   indx;                           /* file index. */

#ifdef DEBUG
  debug(stderr,F110,"fsopwr",fname,0);
#endif
  if ((indx = fsdef(fnum)) < 0) {       /* Define new file number */
    return(indx);
  }
					/* Open the file */
  if ((fd = open(fname, (O_WRONLY | O_CREAT), 0666)) == -1) {
    return(EFSOPW);
  } 
  fsys[indx].fd = fd;                   /* Update data base */
  fsys[indx].status = FSOPNW;
  return(0);
} /* fsopwr */
/**/

/*  F S R E A D  --  Read  mbuf bytes from file to buffer. */

/*  
** Returns the positive number of bytes actual read or 
**         <0 if error.
*/

int fsread(fnum,buf,mbuf)
  int   fnum;           /* world file number (user defined) */
  char  *buf;           /* buffer of min dimension mbuf */
  int   mbuf;           /* number of bytes to read */
{
  IFIL  fd;
  int   indx;                           /* file index. */
  int   ier;

  if ((indx = fsindx(fnum)) < 0) {      /* Determine file index */
    return(EFSNOF);
  }
  if (fsys[indx].status != FSOPNR) {    /* Open for input ? */
    return(EFSNRD);
  }
  fd = fsys[indx].fd;
  ier = read(fd, buf, mbuf);            /* SYSTEM read */
  return(ier);
} /* fsread */
/**/

/*  F S W R I T  --  Write mbuf bytes from buffer to file. */

/*  
** Returns the positive number of bytes actual written or 
**         <0 if error.
*/

int fswrit(fnum,buf,mbuf)
  int   fnum;           /* world file number (user defined) */
  char  *buf;           /* buffer of min dimension mbuf */
  int   mbuf;           /* number of bytes to write */
{
  IFIL  fd;
  int   indx;                           /* file index. */
  int   ier;

  if ((indx = fsindx(fnum)) < 0) {      /* Determine file index */
    return(EFSNOF);
  }
  if (fsys[indx].status != FSOPNW) {    /* Open for writing ? */
    return(EFSNWR);
  }
  fd = fsys[indx].fd;
  ier = write(fd, buf, mbuf);           /* SYSTEM write */
  return(ier);
} /* fswrit */
/**/

/*  F S C L O S  --  close file. */

/*  
** Returns 0 if the file is closed.
**        <0 if error
*/

int fsclos(fnum)
  int   fnum;           /* world file number (user defined) */
{
  int   indx    =   -1;                 /* file index. */
  int   ier     =   -1; 

  if ((indx = fsindx(fnum)) < 0) {      /* Determine index */
    return(EFSNOF);
  }
					/* Close file */
  if ((ier = close(fsys[indx].fd)) < 0) {
    return(ier);
  }
  fsys[indx].no = FSUNUS;               /* Update data base */
  fsys[indx].fd = NULL;
  fsys[indx].status = FSUNUS;
  return(0);
} /* fsclos */

























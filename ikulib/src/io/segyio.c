/*
**
** Known systems: 
** UNIX   -- Default UNIX, C version (HP9000/350, HP9000/840)
** UX350F -- HP 9000/350, UNIX, FORTRAN77.
** UX840F -- HP 9000/840, UNIX, FORTRAN77.
** UXNWSF -- SONY, UNIX, FORTRAN77.
** SPARC1 -- Sun SPARC station 1, SunOS 4.0   
** CON120 -- Convex C-120, UNIX              
** STARP3 -- Stardent ST3000 P3 processor. UNIX 3.0.
** ALLIAN -- Alliant FX??
**
*/
/*                                                                    */
/* define the symbol coresponding to the system base to compile for.  */
/* only ONE of the above mentioned symbols are allowed #define'd !    */
/*                                                                    */

/* #define SPARC1   1  */

/** 
***
*** SEGYIO: SEG-Y format I/O library (FORTRAN callable)
***
**/


/**
*** Various Flags
***/

/*                                                                    */
/* Debug version: '#define DEBUG 1'                                   */
/*                                                                    */

/*
 #define DEBUG  1   
*/

/*                                                                    */
/* Enable disc file as well as tapes: '#define DISKIO 1'              */
/*                                                                    */

#define DISKIO 1

/**

 Variables available to outside world:
 ====================================


 Functions for SEG-Y I/O from named files:
 ========================================


   segyor(no,na,err)       -- Open the named file for SEG-Y input.
   segyow(no,na,err)       -- Open the named file for SEG-Y output.
   segyrh(no,ah,bh,err)    -- Read Reel header from SEG-Y file.
   segywh(no,ah,bh,err)    -- Write Reel header to SEG-Y file.
   segyrd(no,th,da,md,err) -- Read data from SEG-Y file.
   segywr(no,th,da,md,err) -- Write data to SEG-Y file.
   segycl(no,err)          -- Close SEG-Y file.

   segywe(no,err)          -- Write EOF mark to SEG-Y file.
   segysk(no,sz,err)       -- Skip record in SEG-Y file.
   segyff(no,f,n,err)      -- Force format.
   segyid(err)             -- Identify library version.

**/
/**/
/**

 Internal functions, mini FileSystem:
 ===================================

   powtwo(pow)             --  Returns 2**pow as double.
   pow16(pow)              --  Returns 16**pow as double.
   *f2cstr(fs, cs, ns)     --  Conv. "F77" string to "C" string.
   ebc2as(ebc)             --  Conv. EBCDIC to ASCII (returns int).
   as2ebc(as)              --  Conv. ASCII to EBCDIC (returns int).
   syupi2(buf)             --  Unpack SEG-Y Int*2
   syupi4(buf)             --  Unpack SEG-Y Int*4
   sypi2(buf)              --  Pack SEG-Y Int*2
   sypi4(buf)              --  Pack SEG-Y Int*4
   sy12re(sy1)             --  Conv. SEG-Y format 1 to double.
   re2sy1(x,sy1)           --  Conv. double to SEG-Y format 1.

**/

/**

  System dependencies:
  ===================

  The following c data types are assumed having a given size:

  char          1 byte,   8 bit.
  int           4 bytes, 32 bit.
  unsigned int  4 bytes, 32 bit.

  double is assumed to be able to handle the SEG-Y dynamic range 
  -1*(16**64) to -(2**(-24))*(16**-64)  (-1.2e77 to -5.2e-85) and 
  (2**(-24))*(16**-64) to 1*(16**64)    ( 5.2e-85 to 1.2e77)  and 
  zero.

  These double values are converted to floats, any execptions should be
  reported by the c error system.

  All data I/O is done via the mini file system, supported
  by the fsxxxx modules. The source is found in fsdriv.c and fsdriv.h.

**/
/**/

/**
***
*** Includes.
***
**/

#include <fcntl.h>              /* file control */
#include <stdio.h>              /* C standard i/o */
#include <errno.h>              /* Error indicator for system calls */
#include <math.h>               /* Math functions and constants */
#include <errno.h>		/* For errno */
#include <stdlib.h>

#include "segyio.h"             /* SEG-Y const def's. */
#include "ebcdic.h"             /* EBCDIC def's */

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

#ifdef UX350F
/* HP 9000/360 FORTRAN equals HP 9000/350 C */
#define UNIX 1
#endif

#ifdef STARP3
char *csys = "Stardent series 3000 P3, UNIX3.0, FORTRAN77 ";
#elif defined(SPARC1)
char *csys = "SUN SPARC station 1, SunOS 4.0, FORTRAN77 ";
#elif defined(CON120)
char *csys = "Convex C-120, UNIX, FORTRAN77 ";
#elif defined(UXNWSF)
char *csys = "Sony NEWS NWS-1750, UNIX, FORTRAN77 ";
#elif defined(UX840F)
char *csys = "HP 9000/840, HP-UX, FORTRAN77 ";
#elif defined(UX350F)
char *csys = "HP 9000/350, HP-UX, FORTRAN77 ";
#elif defined(ALLIAN)
char *csys = "Alliant FX ???, UNIX, FORTRAN77 ";
#define UXNWSF
#elif defined(UNIX)
char *csys = "UNIX, C ";
#elif defined(__ICC)
char *csys = "Intel C/C++/Fortran Compiler on Linux";
#else
char *csys = "UNKNOWN at compilation time -- defaults to UNIX, C ";
#endif

/**/
/**
***
*** Declarations.
***
**/

/* Declarations of structures global WITHIN this module */

struct systat {         /* SEG-Y information data base */
  int  status;          /* SEG-Y I/O status */
  int  drecl;           /* data record length in current file */
  int  nosamp;          /* number of samples per trace */
  int  format;          /* Data format number (1-4) */

  /* The following variables were added june 1998, and are used only to calculate
     default traceheaders in function segy_write.                                          */
  int  trprec;          /* Number of data traces per record                                */
  int  trcount;         /* Trace count per record                                          */
  int  rccount;         /* Record count                                                    */
  int  samppe;          /* Sample period per trace (micro sec)                             */
};


/* Declarations of variables global WITHIN this module */
                                 
                        /* Define the number of concurrent files */
                        /* MUST be coherent with fsdriv size ... */
#define MAXFID 3

                        /* Allocation of SEG-Y info data base */
static struct systat sys[MAXFID];

/**/
/**
***
*** Internal functions used in this module.
***
**/

#ifdef DEBUG
#include "debug.c"      /* Include the function void debug()  */
#endif

/*  P O W T W O  --  Primitive power of two. */

/*
** Returns 2 raised to the integer power pow as a double.
*/
double powtwo(pow)
  int   pow;
{
#define M_F_02  2.0
  int   i;
  double ans;

  ans = 1.0;
  if (pow == 0) 
    return(ans);
  if (pow < 0) {
    for (i = -1; i >= pow; i --)
      ans = ans / M_F_02;
  } else {
    for (i = 1; i <= pow; i++)
      ans = ans * M_F_02;
  }
  return(ans);
} /* powtwo */
/**/


/*  P O W 1 6    --  Primitive power of 16. */

/*
** Returns 16 raised to the integer power pow as a double.
** In this implementation, this module is called very
** often, so the implementation is basically a table.
*/
double pow16(pow)
  int   pow;
{
#define M_F_16 16.0
  int   i;
  double ans;

  switch (pow) {
  case -70: return((double) 514.7557589e-87);
  case -64: return((double) 8.636168555e-78);
  case -14: return((double) 13.87778781e-18);
  case -13: return((double) 222.0446049e-18);
  case -12: return((double) 3.552713679e-15);
  case -11: return((double) 56.84341886e-15);
  case -10: return((double) 909.4947018e-15);
  case  -9: return((double) 14.55191523e-12);
  case  -8: return((double) 232.8306437e-12);
  case  -7: return((double) 3.725290298e-09);
  case  -6: return((double) 59.60464478e-09);
  case  -5: return((double) 953.6743164e-09);
  case  -4: return((double) 15.25878906e-06);
  case  -3: return((double) 244.1406250e-06);
  case  -2: return((double) 3.906250000e-03);
  case  -1: return((double) 62.50000000e-03);
  case   0: return((double) 1.0);
  case   1: return((double) 16.0);
  case   2: return((double) 256.0);
  case   3: return((double) 4096.0);
  case   4: return((double) 65536.0);
  case   5: return((double) 1048576.0);
  case   6: return((double) 16777216.0);
  case   7: return((double) 268435456.0);
  case   8: return((double) 4294967296.0);

/* cont`d... */
/**/
/* ... pow16, cont`d */

  default :
#ifdef DEBUG
  debug(stderr,F101,"pow16","",pow);
#endif
    ans = 1.0;
    if (pow < 0) {
      for (i = -1; i >= pow; i --)
        ans = ans / M_F_16;
    } else {
      for (i = 1; i <= pow; i++)
        ans = ans * M_F_16;
    }
    return(ans);
  }
} /* pow16 */
/**/


/*  F 2 C S T R  --  Convert FORTRAN string to C string */

/*  
** Returns pointer to C string buffer supplied by the calling 
** function. 
** The conversion stops when a space occurs or when nstr chars
** has been processed. 
** The C string i zero terminated.
*/

char *f2cstr(fstr, cstr, nstr)
  char  *fstr;          /* pointer to FORTRAN string buffer */
  char  *cstr;          /* pointer to C string buffer */
  int   nstr;           /* length of C string buffer */
{
  int   i      =    0;                  /* Local def. */
  char  *sp;                            /* Return pointer */

  sp = cstr;
  for (i = 0; (i < nstr-1) && (*fstr != ' ') && (*fstr != '\0');
                                cstr++, nstr++,fstr++) {
    *cstr = *fstr;
  }
  *cstr = '\0';
  return(sp);
} /* f2cstr */
/**/
/**
***
*** SEG-Y conversion functions.
***
***/

/*  E B C 2 A S  --  EBCDIC to ASCII character conversion. */

/*  
** Returns the ASCII value of the EBCDIC character.  
*/

int ebc2as(ebc)
  int   ebc;                            /* EBCDIC character value */
{

  ebc = ebc & 0x0FF;  /* avoid systenm dependent sign extension */
  if (ebc >= EBC_A && ebc <= EBC_I)     /* A - I */
    return(ebc - EBC_A + (int) 'A');
  if (ebc >= EBC_J && ebc <= EBC_R)     /* J - R */
    return(ebc - EBC_J + (int) 'J');
  if (ebc >= EBC_S && ebc <= EBC_Z)     /* S - Z */
    return(ebc - EBC_S + (int) 'S');
  if (ebc >= EBC_0 && ebc <= EBC_9)     /* 0 - 9 */
    return(ebc - EBC_0 + (int) '0');
  if (ebc >= EBC_a && ebc <= EBC_i)     /* a - i */
    return(ebc - EBC_a + (int) 'a');
  if (ebc >= EBC_j && ebc <= EBC_r)     /* j - r */
    return(ebc - EBC_j + (int) 'j');
  if (ebc >= EBC_s && ebc <= EBC_z)     /* s - z */
    return(ebc - EBC_s + (int) 's');
  switch (ebc) {                        /* handle misc. characters */
     case  EBC_sp :                     /* space */
       return((int) ' ');                
     case  EBC_pe :                     /* period */
       return((int) '.');                
     case  EBC_op :                     /* opening parenthesis */
       return((int) '(');                
     case  EBC_pl :                     /* plus */
       return((int) '+');                
     case  EBC_cp :                     /* closing parenthesis */
       return((int) ')');                
     case  EBC_mi :                     /* minus */
       return((int) '-');                
     case  EBC_sl :                     /* slant */
       return((int) '/');                
     case EBC_eq :                      /* equal sign */
       return((int) '=');                
     default:                           /* defaults to space */
       return((int) ' ');  
  } /* end switch (ebc) */
} /* ebc2as */
/**/

/*  A S 2 E B C  --  ASCII to EBCDIC character conversion. */

/*  Returns the EBCDIC value of the ASCII character.  */

int as2ebc(asc)
  int   asc;                            /* ASCII character value */
{

  asc = asc & 0x0FF;  /* avoid system dependent sign extension */
  if (asc >= (int) 'A' && asc <= (int) 'I')     /* A - I */
    return(asc - (int) 'A' + EBC_A);
  if (asc >= (int) 'J' && asc <= (int) 'R')     /* J - R */
    return(asc - (int) 'J' + EBC_J);
  if (asc >= (int) 'S' && asc <= (int) 'Z')     /* S - Z */
    return(asc - (int) 'S' + EBC_S);
  if (asc >= (int) '0' && asc <= (int) '9')     /* 0 - 9 */
    return(asc - (int) '0' + EBC_0);
  if (asc >= (int) 'a' && asc <= (int) 'i')     /* a - i */
    return(asc - (int) 'a' + EBC_a);
  if (asc >= (int) 'j' && asc <= (int) 'r')     /* j - r */
    return(asc - (int) 'j' + EBC_j);
  if (asc >= (int) 's' && asc <= (int) 'z')     /* s - z */
    return(asc - (int) 's' + EBC_s);
  switch (asc) {                        /* handle misc. characters */
     case ' ' :                         /* space */
       return(EBC_sp);                
     case '.' :                         /* period */
       return(EBC_pe);                
     case '(' :                         /* opening parenthesis */
       return(EBC_op);                
     case '+' :                         /* plus */
       return(EBC_pl);                
     case ')' :                         /* closing parenthesis */
       return(EBC_cp);                
     case '-' :                         /* minus */
       return(EBC_mi);                
     case '/' :                         /* slant */
       return(EBC_sl);                
     case '=' :                         /* equal sign */
       return(EBC_eq);                
     default:                           /* defaults to space */
       return(EBC_sp);                
  } /* end switch (ebc) */
} /* as2ebc */
/**/
/**
***
*** Resten er implementeret med livrem og seler ...
*** (kan formodentlig optimeres).
***
**/

/*  S Y U P I 2  --  Convert 2bytes to int. */

/*  
** Returns the int value of the two-byte buffer. 
*/

int syupi2(buf)
  char  *buf;                           /* Pointer to buffer */
{
  int   res;
  char  *bp;

  bp = buf;
  res = 0;
  res = (0x0FF & (int) (*bp));
  bp++;
  res = ((res) << 8) & 0x0FF00;
  res = (res) | (0x0FF & (int) (*bp));
/*                                                                    */
/*                           Well, two's complement means that you    */
/*                             need to sign extend.                   */
/*                                                                    */
  if ((res & 0x08000) != 0x00) {
     res = ((res) | (~0x0FFFF));
  }
  return(res);
} /* syupi2 */



/*  S Y U P I 4  --  Convert 4bytes to int. */

/* 
** Returns the int value of the four-byte buffer. 
*/

int syupi4(buf)
  char  *buf;                           /* Pointer to buffer */
{
  int   res;
  char  *cptr;

  cptr = buf;
  res = 0;
  res = 0x0FF & ((int) (*cptr));
  cptr++;
  res = ((res) << 8) & ~0x0FF;
  res = (res) | (0x0FF & (int) (*cptr));
  cptr++;
  res = ((res) << 8) & ~0x0FF;
  res = (res) | (0x0FF & (int) (*cptr));
  cptr++;
  res = ((res) << 8) & ~0x0FF;
  res = (res) | (0x0FF & (int) (*cptr));
  return(res);
} /* syupi4 */
/**/

/*  S Y P I 2    --  Convert int to 2 bytes int. */

/*  
** Returns the value of int value in the two-byte buffer. 
*/

void sypi2(i,buf)
  int   i;
  char  *buf;                           /* Pointer to buffer */
{
  *(buf++) = (char) ((i >> 8) & 0x0FF);
  *buf     = (char) (i & 0x0FF);
  return;
} /* sypi2 */



/*  S Y P I 4    --  Convert int to 4 bytes int. */

/*  
** Returns the value of int value in the four-byte buffer. 
*/

void sypi4(i,buf)
  int   i;
  char  *buf;                           /* Pointer to buffer */
{
  *(buf++) = (char) ((i >> 24) & 0x0FF);
  *(buf++) = (char) ((i >> 16) & 0x0FF);
  *(buf++) = (char) ((i >>  8) & 0x0FF);
  *buf     = (char) (i & 0x0FF);
  return;
} /* sypi4 */
/**/

/*  S Y 1 2 R E  --  Convert SEG-Y format 1 to double. */

/*  
** Returns the double value of the SEG-Y formatted 4 bytes.  
*/

double sy12re(sy1)
  char  *sy1;                           /* Pointer to SEG-Y format 1 */
{
  int   sign, c_exp;
  unsigned int q_mag;
  double res, p;

  if ((*sy1 & ~0x07F) == 0x00) {
    sign = 1;
  } else {
    sign = -1;
  }
  c_exp = *sy1 & 0x07F;
  q_mag = ((((unsigned int) *(sy1+1)) << 16) & 0x0FF0000);
  q_mag = q_mag + ((((unsigned int) *(sy1+2)) << 8) & 0x0FF00);
  q_mag = q_mag + ((((unsigned int) *(sy1+3)) << 0) & 0x000FF);
  p     = pow16(c_exp - 64 - 6);
  res   = sign * (double) q_mag * p;
  return(res);
} /* sy12re */
/**/


/*  R E 2 S Y 1  --  Convert float to SEG-Y format 1. */

/*  
** Returns the float value as a SEG-Y formatted 4 bytes.  
*/

void re2sy1(x,sy1)
  double x;
  char  *sy1;                           /* Pointer to SEG-Y format 1 */
{
  unsigned int   qf;
  double         mag, xf;
  char           qc, *cptr;

  cptr = sy1;
  mag = fabs(x);
  if (mag > 0) {                   /* Avoid log(zero) */
    qc  = (char) (((int) (log(mag)/M_LN16)) + 1 + 64);
  } else {
    qc  = (char) 0;
  }
  /*
  xf = mag / pow(16.0, (qc-64.0));
  */
  xf = mag / pow16(qc-64);
  qf = (unsigned int) ((xf * M_2i24) + 0.5);
  *cptr = *cptr ^ *cptr;
  if (x < 0) {
    *cptr = *cptr | 0x080;
  }
  *cptr = *cptr | (qc & 0x07F);
  cptr += 3;
  *(cptr--) = (char) ((qf & 0x0FF));
  *(cptr--) = (char) ((qf & 0x0FF00) >> 8);
  *cptr     = (char) ((qf & 0x0FF0000) >> 16);
  return;
} /* re2sy1 */
/**/
/**
***
*** FORTRAN callable SEG-Y I/O modules.
***
***/


/*--------------------------------------------------------------------*/
/* Title          : SEGYCL                                            */
/* Purpose        : Close a SEG-Y file.                               */
/*                                                                    */
/* Computer       : ConvexOS, Release V8.1 (bullard)                  */
/* Compiler       : C                                                 */
/*                                                                    */
/* Usage          : CALL SEGYCL(NO, IERR)                             */
/* Formal param.  : I  INTEGER       NO                               */
/*                   O INTEGER       IERR                             */
/* Description    : This subroutine closes a SEG-Y file.              */
/*                                                                    */
/*                  On entry, NO holds the internal logical unit      */
/*                  number associated with the file to be closed.     */
/*                                                                    */
/*                  On exit, IERR is an error indicator. If ierr is   */
/*                  less than zerro an error occured.                 */
/* See also       : SEGYOR, SEGYOW                                    */
/* External calls :                                                   */
/* Cautions       : The logical unit number NO is NOT a FORTRAN unit  */
/*                  number.                                           */
/*                                                                    */
/*       1         2         3         4         5         6         7*/
/*34567890123456789012345678901234567890123456789012345678901234567890*/
#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYCL(no,err)
#elif defined(CON120)           /* Convex C-120 */
void segycl_(no,err)
#elif defined(SPARC1)           /* Sun SPARC station 1 */
void segycl_(no,err)
#elif defined(UXNWSF) || defined(__ICC)
void segycl_(no,err)
#else
void segycl(no,err)
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *err;           /*  O Error indicator */
{
  int   ier;

  if ((ier = fsclos(*no)) < 0) {
    *err = YERCL1;
    return;
  }
  *err = YERNON;
  return;
} /* segycl */
/**/
/*--------------------------------------------------------------------*/
/* Title          : SEGYOR                                            */
/* Purpose        : Open the named file for SEG-Y input.              */
/*                                                                    */
/* Computer       : ConvexOS, Release V8.1 (bullard)                  */
/* Compiler       : C                                                 */
/*                                                                    */
/* Usage          : CALL SEGYOR(NO, NA, IERR)                         */
/* Formal param.  : I  INTEGER       NO                               */
/*                  I  CHARACTER*64  NA                               */
/*                   O INTEGER       IERR                             */
/* Description    : This subroutine opens a SEG-Y file for reading.   */
/*                                                                    */
/*                  On entry, NO holds the internal logical unit      */
/*                  number to be associated with the file name held   */
/*                  in NA.                                            */
/*                                                                    */
/*                  On exit, IERR is an error indicator. If ierr is   */
/*                  less than zerro an error occured.                 */
/* See also       : SEGYOW, SEGYCL                                    */
/* External calls :                                                   */
/* Cautions       : The logical unit number NO is NOT a FORTRAN unit  */
/*                  number.                                           */
/*                                                                    */
/*       1         2         3         4         5         6         7*/
/*34567890123456789012345678901234567890123456789012345678901234567890*/
#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYOR(no,transfer,err) 
  int        *no;       /* I  SEG-Y file number */
  struct {   char   *na;
             int    len;
             int    magic;
  }          *transfer; /* I  SEG-Y file name */
  int        *err;      /*  O Error indicator */
#elif defined(CON120) || defined(SPARC1)
void segyor_(no,na,err,ls) 
  int        *no;       /* I  SEG-Y file number */
  char       *na;       /* I  SEG-Y file name */
  int        *err;      /*  O Error indicator */
  long int   ls;        /* I  Sun string passing */
#elif defined(UXNWSF)
void segyor_(no,na,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   *err;           /*  O Error indicator */
#elif defined(UX840F)
void segyor(no,na,ls,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   ls;             /* I  HP 9000 F77 string passing */
  int   *err;           /*  O Error indicator */
#elif defined(__ICC)
void segyor_(int *no, char *na, int *err) 
#else
void segyor(no,na,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   *err;           /*  O Error indicator */
#endif
{
  int   ierr;
  char  fname[MFNAME], *sptr, *bptr;
#ifdef STARP3           /* Stardent 3000 P3 */
  char       *na;       /* I  SEG-Y file name */
  na = (*transfer).na;
#endif
  sptr = &fname[0];
#ifdef DEBUG
  debug(stderr,F111,"segyor","no",*no);
  debug(stderr,F110,"--  --",f2cstr(na,sptr,MFNAME),0);
#ifdef UX840F
  debug(stderr,F111,"--  --","ls",ls);
#endif
  debug(stderr,F111,"--  --","err",*err);
#endif
  bptr = f2cstr(na,sptr,MFNAME);        /* build C file name */
  ierr = fsoprd(*no,fname);             /* open file for input */
  *err = ierr;
  return;
} /* segyor */
/**/


/*--------------------------------------------------------------------*/
/* Title          : SEGYOW                                            */
/* Purpose        : Open the named file for SEG-Y output.             */
/*                                                                    */
/* Computer       : ConvexOS, Release V8.1 (bullard)                  */
/* Compiler       : C                                                 */
/*                                                                    */
/* Usage          : CALL SEGYOW(NO, NA, IERR)                         */
/* Formal param.  : I  INTEGER       NO                               */
/*                  I  CHARACTER*64  NA                               */
/*                   O INTEGER       IERR                             */
/* Description    : This subroutine opens a SEG-Y file for writing.   */
/*                                                                    */
/*                  On entry, NO holds the internal logical unit      */
/*                  number to be associated with the file name held   */
/*                  in NA.                                            */
/*                                                                    */
/*                  On exit, IERR is an error indicator. If ierr is   */
/*                  less than zerro an error occured.                 */
/* See also       : SEGYOR, SEGYCL                                    */
/* External calls :                                                   */
/* Cautions       : The logical unit number NO is NOT a FORTRAN unit  */
/*                  number.                                           */
/*                                                                    */
/*       1         2         3         4         5         6         7*/
/*34567890123456789012345678901234567890123456789012345678901234567890*/
#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYOW(no,transfer,err) 
  int        *no;       /* I  SEG-Y file number */
  struct {   char   *na;
             int    len;
             int    magic;
  }          *transfer; /* I  SEG-Y file name */
  int        *err;      /*  O Error indicator */
#elif defined(CON120) || defined(SPARC1)
void segyow_(no,na,err,ls) 
  int        *no;       /* I  SEG-Y file number */
  char       *na;       /* I  SEG-Y file name */
  int        *err;      /*  O Error indicator */
  long int   ls;        /* I  Sun string passing */
#elif defined(UXNWSF)
void segyow_(no,na,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   *err;           /*  O Error indicator */
#elif defined(UX840F)
void segyow(no,na,ls,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   ls;             /* I  HP 9000 F77 string passing */
  int   *err;           /*  O Error indicator */
#elif defined(__ICC)
void segyow_(int *no, char *na, int *err)
#else
void segyow(no,na,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *na;            /* I  SEG-Y file name */
  int   *err;           /*  O Error indicator */
#endif
{
  int   i;
  char  fname[MFNAME], *sptr, *bptr;
#ifdef STARP3           /* Stardent 3000 P3 */
  char       *na;       /* I  SEG-Y file name */
  na = (*transfer).na;
#endif
  
  sptr = &fname[0];
#ifdef DEBUG
  debug(stderr,F111,"segyow","no",*no);
  debug(stderr,F110,"--  --",f2cstr(na,sptr,MFNAME),0);
  debug(stderr,F111,"--  --","err",*err);
#endif
  bptr = f2cstr(na,sptr,MFNAME);        /* build C file name */
  i    = fsopwr(*no,fname);             /* open file for input */
  *err = i;
  return;
} /* segyow */
/**/


/*  S E G Y R H  --  Read Reel header from SEG-Y file. */

/*  
 * return reel header info.  
 *
 * IF DISKIO is set THEN
 * The header variables 
 * "number of data traces per record" bh[3]
 * "number of aux. traces per record" bh[4]
 * and
 * "number of samples/per data trace" bh[7]
 * MUST be present AND valid in the header on the input medium.
 */

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYRH(no,transfer,bh,err) 
  int        *no;       /* I  SEG-Y file number */
  struct {   char   *na;
             int    len;
             int    magic;
  }          *transfer; /*  O SEG-Y ASCII reel header */
  int        *bh;       /*  O SEG-Y binary reel header */
  int        *err;      /*  O Error indicator */
#elif defined(CON120) || defined(SPARC1)
void segyrh_(no,ah,bh,err,ls) 
  int        *no;       /* I  SEG-Y file number */
  char       *ah;       /*  O SEG-Y ASCII reel header */
  int        *bh;       /*  O SEG-Y binary reel header */
  int        *err;      /*  O Error indicator */
  long int   ls;        /* I  Sun string passing */
#elif defined(UXNWSF)
void segyrh_(no,ah,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /*  O SEG-Y ASCII reel header */
  int   *bh;            /*  O SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#elif defined(UX840F)
void segyrh(no,ah,ls,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /*  O SEG-Y ASCII reel header */
  int   ls;             /* I  HP 9000 F77 string passing */
  int   *bh;            /*  O SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#elif defined(__ICC)
void segyrh_(int *no,char *ah, int *bh, int *err) 
#else
void segyrh(no,ah,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /*  O SEG-Y ASCII reel header */
  int   *bh;            /*  O SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#endif
{
  int   i, index, *ip;
  char  *ap, *bp;
  char  ibuf[MBUF], *buf;               /* I/O buffer */
  
#ifdef STARP3           /* Stardent 3000 P3 */
  char       *ah;       /*  O SEG-Y ASCII reel header */
  ah = (*transfer).na;
#endif


#ifdef DEBUG
  debug(stderr,F111,"segyrh","no",*no);
  debug(stderr,F111,"--  --","ah",(int) ah);
  debug(stderr,F111,"--  --","bh",(int) bh);
  debug(stderr,F111,"--  --","err",*err);
#endif

/* cont'd... */
/**/
/* segyrh cont'd */

  buf = &ibuf[0];
                                  /* Read EBCDIC reel header. */
#ifdef DISKIO
  if ((*err = fsread(*no, buf, MEBCHD)) <= 0) {
#else
  if ((*err = fsread(*no, buf, MBUF)) <= 0) {
#endif
    if (*err == 0) {
      *err = YEREOF;
    } else {
      *err = YERRD1;
    }
#ifdef DEBUG
  debug(stderr,F111,"segyrh","EBCDIC header return",*err);
#endif
    return;
  }
#ifdef DEBUG
  debug(stderr,F111,"segyrh","EBCDIC header",*err);
#endif
  for (i = 0, ap = ah, bp = buf; 
       (i < *err) && (i < MEBCHD); i++, ap++, bp++) {
    *ap = (char) ebc2as((int) *bp);
  }

/* cont'd... */
/**/
/* segyrh cont'd */

                                  /* Read binary reel header. */

  

#ifdef DISKIO
  if ((*err = fsread(*no, buf, MRBIHD)) < 0) {
#else
  if ((*err = fsread(*no, buf, MRBIHD)) < 0) {
#endif
    if (*err == 0) {
      *err = YEREOF;
    } else {
      *err = YERRD2;
    }
#ifdef DEBUG
    debug(stderr,F111,"segyrh","return val",*err);
#endif
    return;
  }
  
#ifdef DEBUG
  debug(stderr,F111,"segyrh","bin reel header",*err);
#endif
  
  for (i = 0, bp = buf, ip = bh; i < 3; i++) {
    *ip = syupi4(bp);
    bp += 4;
    ip++;
  }
  
  for (i = 3; i < MBREHD; i++) {   
    *ip = syupi2(bp);
    bp += 2;
    ip++;
  }
  
  index = fsindx(*no);
  ip = bh;
#ifdef AGIP
  fprintf(stderr,"\nWARNING AGIP format nosamp forced to 3000\n");
  ip[7] = 3000;
#endif
  sys[index].nosamp = ip[7];
  if ((sys[index].format = ip[9]) == 3) {
    sys[index].drecl = MTBIHD + (2 * sys[index].nosamp);
  } else {
    sys[index].drecl = MTBIHD + (4 * sys[index].nosamp);
  }
  
#ifdef DEBUG
  debug(stderr,F111,"segyrh","format",sys[index].format);
  debug(stderr,F111,"--  --","nosamp",sys[index].nosamp);
  debug(stderr,F111,"--  --","drecl",sys[index].drecl);
#endif

  *err = YERNON;
  return;
} /* segyrh */
/**/


/*  S E G Y W H  --  Write Reel header from SEG-Y file. */

/*  
 * write reel header info.  
 *
 * The header variables 
 * "number of data traces per record" bh[3]
 * "number of aux. traces per record" bh[4]
 * "sample period per trace" bh[5]                   ( <-- This line added june 1998 )
 * and
 * "number of samples/per data trace" bh[7]
 * MUST be present AND valid.
 */

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYWH(no,transfer,bh,err) 
  int        *no;       /* I  SEG-Y file number */
  struct {   char   *na;
             int    len;
             int    magic;
  }          *transfer; /* I  SEG-Y ASCII reel header */
  int        *bh;       /* I  SEG-Y binary reel header */
  int        *err;      /*  O Error indicator */
#elif defined(CON120) || defined(SPARC1)
void segywh_(no,ah,bh,err,ls) 
  int        *no;       /* I  SEG-Y file number */
  char       *ah;       /* I  SEG-Y ASCII reel header */
  int        *bh;       /* I  SEG-Y binary reel header */
  int        *err;      /*  O Error indicator */
  long int   ls;        /* I  Sun string passing */
#elif defined(UXNWSF) || defined(__ICC)
void segywh_(no,ah,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /* I  SEG-Y ASCII reel header */
  int   *bh;            /* I  SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#elif defined(UX840F)
void segywh(no,ah,ls,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /* I  SEG-Y ASCII reel header */
  int   ls;             /* I  HP 9000 F77 string passing */
  int   *bh;            /* I  SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#else
void segywh(no,ah,bh,err) 
  int   *no;            /* I  SEG-Y file number */
  char  *ah;            /* I  SEG-Y ASCII reel header */
  int   *bh;            /* I  SEG-Y binary reel header */
  int   *err;           /*  O Error indicator */
#endif
{
  int   i, index, *ip;
  char  *ap, *bp;
  char  ibuf[MBUF], *buf;              /* I/O buffer */
  
#ifdef STARP3           /* Stardent 3000 P3 */
  char       *ah;       /* I  SEG-Y ASCII reel header */
  ah = (*transfer).na;
#endif

#ifdef DEBUG
  debug(stderr,F111,"segywh","no",*no);
  debug(stderr,F111,"--  --","ah",(int) ah);
  debug(stderr,F111,"--  --","bh",(int) bh);
  debug(stderr,F111,"--  --","err",*err);
#endif
  buf = &ibuf[0];
                                  /* Write EBCDIC reel header. */
  for (i = 0, ap = ah, bp = buf; 
       (i < MBUF) && (i < MEBCHD); i++, ap++, bp++) {
    *bp = (char) as2ebc((int) *ap);
  }

/* cont'd... */
/**/
/* segywh cont'd */

  if ((*err = fswrit(*no, buf, MEBCHD)) != MEBCHD) {
    if (*err < 0) {
      *err = YERWR1;
    } else {
      *err = YEROOS;
    }
    return;
  }
#ifdef DEBUG
  debug(stderr,F111,"segywh","EBCDIC header",*err);
#endif
                                  /* Write binary reel header. */
  for (i = 0, bp = buf, ip = bh; i < 3; i++) {
    sypi4(*ip,bp);
    bp += 4;
    ip++;
  }
  for (i = 3; i < MBREHD; i++) {
    sypi2(*ip,bp);
    bp += 2;
    ip++;
  }
  if ((*err = fswrit(*no, buf, MRBIHD)) != MRBIHD) {
    if (*err < 0) {
      *err = YERWR2;
    } else {
      *err = YEROOS;
    }
    return;
  }
#ifdef DEBUG
  debug(stderr,F111,"segywh","bin reel header",*err);
#endif
  index = fsindx(*no);
  sys[index].nosamp = *(bh + 7);

  sys[index].samppe  = *(bh + 5);  /* Sample period per trace           (Added june 1998)   */
  sys[index].trprec  = *(bh + 3);  /* Number of data traces per record  (Added june 1998)   */
  sys[index].trcount = 1;          /* Trace count per record            (Added june 1998)   */
  sys[index].rccount = 1;          /* Record count                      (Added june 1998)   */

  if ((sys[index].format = *(bh + 9)) == 3) {
    sys[index].drecl = MTBIHD + (2 * sys[index].nosamp);
  } else {
    sys[index].drecl = MTBIHD + (4 * sys[index].nosamp);
  }
  *err = YERNON;
  return;
} /* segywh */

/**/
   
/*--------------------------------------------------------------------*/
/* Title          : SEGYRD                                            */
/* Purpose        : Read data from a SEG-Y file.                      */
/*                                                                    */
/* Computer       : ConvexOS, Release V8.1 (bullard)                  */
/* Compiler       : C                                                 */
/*                                                                    */
/* Usage          : CALL SEGYRD(NO, TH, DA, MD, IERR)                 */
/* Formal param.  : I  INTEGER       NO                               */
/*                   O INTEGER       TH                               */
/*                   O REAL          DA                               */
/*                  I  INTEGER       MD                               */
/*                   O INTEGER       IERR                             */
/* Description    : This subroutine opens a SEG-Y file for reading.   */
/*                                                                    */
/*                  On entry, NO holds the internal logical unit      */
/*                  number to be associated with the file name held   */
/*                  in NA.                                            */
/*                                                                    */
/*                  On exit, IERR is an error indicator. If ierr is   */
/*                  less than zerro an error occured.                 */
/* See also       : SEGYOW, SEGYCL                                    */
/* External calls :                                                   */
/* Cautions       : The logical unit number NO is NOT a FORTRAN unit  */
/*                  number.                                           */
/*                                                                    */
/*       1         2         3         4         5         6         7*/
/*34567890123456789012345678901234567890123456789012345678901234567890*/
/*  S E G Y R D  --  Read data from SEG-Y file. */

/*  Read and decode data from the specified SEG-Y file. 
 *  err < 0 indicates an error,
 *  err > 0 is the number of samples read.
 */
#ifdef __ICC
void segyrd_(int *no, int *th, float *da, int *md, int *err) {
	segyrd(no, th, da, md, err);
}
#endif
#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYRD(no,th,da,md,err)
#elif defined(CON120) || defined(SPARC1) || defined(UXNWSF)
void segyrd_(no,th,da,md,err)
#else
void segyrd(no,th,da,md,err)
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *th;            /*  O SEG-Y trace header */
  float *da;            /*  O Data buffer (md samples) */
  int   *md;            /* I  Dimension of data buffer */
  int   *err;           /*  O Error indicator */
{
  char  ibuf[MBUF], *buf;               /* I/O buffer */
  char  *cptr;
  int   *iptr,i,index;
  int   rsiz, iformat, nosam;
  float *fptr;

  buf = &ibuf[0];
  
  /* Read data block. */
  index = fsindx(*no);
#ifdef DISKIO
  i = sys[index].drecl;
   
  if (i > MBUF) 
    i = MBUF;
#else
  i = MBUF;
#endif 
  if ((rsiz = fsread(*no, buf, i)) <= 0) {
    if (rsiz == 0) {
      *err = YEREOF;
    } else {
      *err = YERRD3;
    }
    return;
  }
  
#ifdef DEBUG
  debug(stderr,F101,"segyrd: read","",rsiz);
#endif

/* cont'd... */
/**/
/* ...segyrd, cont'd */
  
  for (i = 0, cptr = buf, iptr = th; i < 7; i++) {
    *iptr = syupi4(cptr);
    cptr += 4;
    iptr++;
  }
  for (i = 7; i < 11; i++) {
    *iptr = syupi2(cptr);
    cptr += 2;
    iptr++;
  }
  for (i = 11; i < 19; i++) {
    *iptr = syupi4(cptr);
    cptr += 4;
    iptr++;
  }
  for (i = 19; i < 21; i++) {
    *iptr = syupi2(cptr);
    cptr += 2;
    iptr++;
  }
  for (i = 21; i < 25; i++) {
    *iptr = syupi4(cptr);
    cptr += 4;
    iptr++; 
  }
  for (i = 25; i < MBTRHD; i++) {
    *iptr = syupi2(cptr);
    cptr += 2;
    iptr++;
  }
  
/* cont'd... */
/**/
/* ...segyrd, cont'd */
  
  iformat = sys[index].format;
   *err = nosam = (rsiz-MTBIHD)/4;    /* Number of samples read */
  if (iformat == 3)
    *err = nosam = (rsiz-MTBIHD)/2;
  if (nosam > *md) {
    nosam = *md;                   /* use all available space */
    *err = YERMDA;
  } else {
    for (i = nosam, fptr = da + nosam; i < *md; i++, fptr++) {
      *fptr = 0;                   /* fill rest with zeros */
    }
  }
  
  switch (iformat) {
  case 1:
    for (i = 0, cptr = buf+MTBIHD, fptr = da; i < nosam;
                                     i++, cptr += 4, fptr++) {
      *fptr = (float) sy12re(cptr);
    }
    break;
  case 2:
  case 3:
  case 4:
  default:
    *err = YERFOR;
    return;
  }
  return;
} /* segyrd */
/**/

/*
 ___________________________________________________________________________________________

                                 S E G Y _ R E A D     

 segy_read (int* no, int* th, float* da, int* md, int* howmany, int* readheaders);
	
 ____________________________________________________________________________________________
*/

#ifdef STARP3                                          /* Stardent 3000 P3 */
void SEGY_READ(no,th,da,md,hmany,rdhdrs)
#elif defined(CON120) || defined(SPARC1) || defined(UXNWSF) || defined(__ICC)
void segy_read_(no,th,da,md,hmany,rdhdrs)
#else
void segy_read(no,th,da,md,hmany,rdhdrs)
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *th;            /*  O SEG-Y trace header */
  float *da;            /*  O Data buffer (md samples) */
  int   *md;            /* I  Dimension of data buffer */
  int   *hmany;          /* I  How many traces to be read */
  int   *rdhdrs;         /* I  !=0 if trace headers are to be read  */
{
  int   err;           
  int   count;

  if(*rdhdrs==0) th = (int*)malloc(MTBIHD);

  for(count=0; count<*hmany; count++) { 
      #ifdef STARP3                              /* Stardent 3000 P3 */
      SEGYRD(no,th,da,md,&err);
      #else
      #ifdef CON120                              /* Convex C-120 */
      segyrd_(no,th,da,md,&err);
      #else
      #ifdef SPARC1                              /* Sun SPARC station 1 */
      segyrd_(no,th,da,md,&err);
      #else
      #ifdef UXNWSF
      segyrd_(no,th,da,md,&err);
      #else
      segyrd(no,th,da,md,&err);
      #endif
      #endif
      #endif
      #endif

      da += (*md);
      if(*rdhdrs!=0) th += MBTRHD;
  }
  if(*rdhdrs==0) free(th);
}


/*  ______________________________________________________________________________________
 */



/*  S E G Y W R  --  Write data to SEG-Y file. */

/*  Encode and write data to the specified SEG-Y file. */

#ifdef __ICC
void segywr_(int *no, int *th, float *da, int *md, int *err) {
	segywr(no, th, da, md, err);
}
#endif

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYWR(no,th,da,md,err)
#elif defined(CON120) || defined(SPARC1) || defined(UXNWSF)
void segywr_(no,th,da,md,err)
#else
void segywr(no,th,da,md,err)
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *th;            /* I  SEG-Y trace header */
  float *da;            /* I  Data buffer (md samples) */
  int   *md;            /* I  Dimension of data buffer */
  int   *err;           /*  O Error indicator */
{
  char  ibuf[MBUF], *buf;               /* I/O buffer */
  char  *cptr;
  int   *iptr,i,index;
  int   recl, iformat, nosam;
  float *fptr;

#ifdef DEBUG
  debug(stderr,F111,"segywr","no",*no);
  debug(stderr,F111,"--  --","th",(int) th);
  debug(stderr,F111,"--  --","da",(int) da);
  debug(stderr,F111,"--  --","md",*md);
  debug(stderr,F111,"--  --","err",*err);
#endif

  buf = &ibuf[0];

  for (i = 0, cptr = buf, iptr = th; i < 7; i++) {
    sypi4(*iptr, cptr);
    cptr += 4;
    iptr++;
  }
  for (i = 7; i < 11; i++) {
    sypi2(*iptr, cptr);
    cptr += 2;
    iptr++;
  }
  for (i = 11; i < 19; i++) {
    sypi4(*iptr, cptr);
    cptr += 4;
    iptr++;
  }
  for (i = 19; i < 21; i++) {
    sypi2(*iptr, cptr);
    cptr += 2;
    iptr++;
  }
  for (i = 21; i < 25; i++) {
    sypi4(*iptr, cptr);
    cptr += 4;
    iptr++;
  }

  /* cont'd... */
  /**/
  /* ...segywr, cont'd */

  for (i = 25; i < MBTRHD; i++) {
    sypi2(*iptr, cptr);
    cptr += 2;
    iptr++;
  }
  index = fsindx(*no);
  iformat = sys[index].format;
  nosam = sys[index].nosamp;
  switch (iformat) {
  case 1:
    if (nosam > *md) {
#ifdef DEBUG
    debug(stderr,F110,"segywr","append zero's",0);
#endif
      for (i = 0, cptr = buf+MTBIHD, fptr = da; i < *md; 
                             i++, cptr += 4, fptr++) {
        re2sy1(*fptr, cptr);
      }
      for (i = *md; i < nosam; 
                             i++, cptr += 4, fptr++) {
        re2sy1(0.0, cptr);
      }
    } else {
      for (i = 0, cptr = buf+MTBIHD, fptr = da; i < nosam;
                             i++, cptr += 4, fptr++) {
        re2sy1(*fptr, cptr);
      }
    }
    break;
  case 2:
  case 3:
  case 4:

  /* cont'd... */
  /**/
  /* ...segywr, cont'd */

  default:
#ifdef DEBUG
    debug(stderr,F111,"segywr","iformat",iformat);
#endif
    *err = YERFOR;
    return;
  }
                                        /* Write data block. */
  recl = sys[index].drecl;       /* As set by segywh() */
  if ((*err = fswrit(*no, buf, recl)) != recl) {
#ifdef DEBUG
  debug(stderr,F101,"segywr: write","",*err);
#endif
    if (*err < 0) {
      *err = YERWR3;
    } else {
      *err = YEROOS;
    }
    return;
  }
#ifdef DEBUG
  debug(stderr,F101,"segywr: write","",*err);
#endif
  return;
} /* segywr */

/**/




/*
 ___________________________________________________________________________________________

                                 S E G Y _ W R I T E

 segy_write (int* no, int* th, float* da, int* md, int* howmany, int* writeheaders);

 Note to the latter parameter: segy_write will ALWAYS write a trace header. If
                               "*writeheaders" equals zero, the routine will calculate
			       default trace headers.
 ____________________________________________________________________________________________
*/

#ifdef STARP3                                          /* Stardent 3000 P3 */
void SEGY_WRITE(no,th,da,md,hmany,rdhdrs)
#elif defined(CON120) || defined(SPARC1) || defined(UXNWSF) || defined(__ICC)
void segy_write_(no,th,da,md,hmany,rdhdrs)
#else
void segy_write(no,th,da,md,hmany,rdhdrs)
#endif
  int   *no;            /*  I   SEG-Y file number            */
  int   *th;            /*  I   SEG-Y trace header           */
  float *da;            /*  I   Data buffer (md samples)     */
  int   *md;            /*  I   Dimension of data buffer     */
  int   *hmany;         /*  I   How many traces to be read   */
  int   *rdhdrs;        /*  I   !=0 if trace headers are to be read  */
{
  int   err;           
  int   count;
  int   i,index;

  if(*rdhdrs==0) {
    th    = (int*)malloc(MTBIHD);                  /* Allocate space for default header */
    index = fsindx(*no);                           /* Find internal file-index     */
    for( i=0; i<MTBIHD; i++) (*(th+i)) = 0;        /* Reset trace header           */  

    if(sys[index].trcount > sys[index].trprec) {   /* Start new record if          */
      sys[index].trcount = 1;                      /* number of traces exceeds     */
      sys[index].rccount++;                        /* traces per record            */
    }
  
    *(th +1-1) = 1;                     /*  Trace sequence                        */       
                                        /*  (empty) Field record number (SHOT)    */
                                        /*  (empty) Trace number defined BELOW    */ 
    *(th +5-1) = 1;                     /*  Source point number (SOURCE)          */ 
    *(th +6-1) = 1;                     /*  CDP ensemble number (CDP)             */  
    *(th +7-1) = 1;                     /*  Trace number within cdp               */
    *(th +8-1) = 1;                     /*  Trace id. code :  1 = seismic data:   */        
    *(th+10-1) = 0;                     /*  Fold                                  */
    *(th+12-1) = 0;                     /*  Offset                                */
    *(th+13-1) = 0;                     /*  Receiver group elevation              */
    *(th+14-1) = 0;                     /*  Surface elevation at source           */
    *(th+15-1) = 0;                     /*  Source depth below surface            */    
    *(th+18-1) = 0;                     /*  Water depth at source                 */
    *(th+19-1) = 0;                     /*  Water depth at receiver               */
    *(th+39-1) = sys[index].nosamp;     /*  Number of samples in (this) trace     */  
    *(th+40-1) = sys[index].samppe/     
                 (sys[index].nosamp-1); /*  Sampling interval                     */
    
  } /*  if(*rdhrds==0)  */
 
  for(count=0; count<*hmany; count++) {

    if(*rdhdrs==0){                      /*  Calculate header if it is not given            */
      *(th+3-1) = sys[index].rccount;    /*  Calculate record number                        */
      *(th+4-1) = sys[index].trcount;    /*  Overrides: Trace number in orig. field record  */

      sys[index].trcount++;
      if(sys[index].trcount > sys[index].trprec){
	sys[index].trcount =1;
	sys[index].rccount ++;
      }
    }
    
    #ifdef STARP3                              /* Stardent 3000 P3 */
    SEGYWR(no,th,da,md,&err);
    #else
    #ifdef CON120                              /* Convex C-120 */
    segywr_(no,th,da,md,&err);
    #else
    #ifdef SPARC1                              /* Sun SPARC station 1 */
    segywr_(no,th,da,md,&err);
    #else
    #ifdef UXNWSF
    segywr_(no,th,da,md,&err);
    #else
    segywr(no,th,da,md,&err);
    #endif
    #endif
    #endif
    #endif

      da += (*md);
      if(*rdhdrs!=0) th += MBTRHD;
  }
  if(*rdhdrs==0) free(th);
}


/*  ______________________________________________________________________________________
 */



/*  S E G Y W E  --  Write EOF mark to SEG-Y file. */

/*   */

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYWE(no,err)
#else
#ifdef CON120           /* Convex C-120 */
void segywe_(no,err)
#else
#ifdef SPARC1           /* Sun SPARC station 1 */
void segywe_(no,err)
#else
#ifdef UXNWSF
void segywe_(no,err)
#else
void segywe(no,err)
#endif
#endif
#endif
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *err;           /*  O Error indicator */
{
  int   ier;
  char  ibuf[2];

  *err = YERNON;
  if ((ier = fswrit(*no, &ibuf[0], 0)) != 0) 
    *err = ier;
  return;
} /* segywe */
/**/
   
/*  S E G Y S K  --  Skip record in SEG-Y file. */

/* 
 * Dummy read of record  
 * if sz >  0: sz bytes (one record) is skipped
 *    sz <= 0: -sz data records is skipped 
 */

#ifdef Con120           /* Convex C-120 */
void segysk_(no,sz,err)
#else
#ifdef SPARC1           /* Sun SPARC station 1 */
void segysk_(no,sz,err)
#else
#ifdef UXNWSF
void segysk_(no,sz,err)
#else
void segysk(no,sz,err)
#endif
#endif
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *sz;            /* I  Record size */
  int   *err;           /*  O Error indicator */
{
  int   ier;
  int   noskip;
  int   i, index, isz;
  char  ibuf[MBUF];

#ifdef DEBUG
  debug(stderr,F111,"segysk","no",*no);
  debug(stderr,F111,"--  --","sz",*sz);
  debug(stderr,F111,"--  --","err",*err);
#endif
  if (*sz > MBUF) {
    *err = YERBUF;
    return;
  }
  isz = *sz;
  if (*sz <= 0) {
    noskip = -(*sz);
    index = fsindx(*no);
    isz   = sys[index].drecl;
  }
  *err = YERNON;
  for (i = 0, ier = 1; i < noskip && ier > 0; i++) {
    if ((ier = fsread(*no, &ibuf[0], isz)) != isz) {
      if (ier == 0) {
        *err = YEREOF;
      } else {
        *err = ier;
      }
#ifdef DEBUG
  debug(stderr,F111,"segysk","return",*err);
#endif
      return;
    }
  }
  *err = ier;
  return;
} /* segysk */
/**/
   
/*  S E G Y F F  --  Force Format. */

/* 
 */

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYFF(no,fmt,nsamp,err)
#else
#ifdef CON120           /* Convex C-120 */
void segyff_(no,fmt,nsamp,err)
#else
#ifdef SPARC1           /* Sun SPARC station 1 */
void segyff_(no,fmt,nsamp,err)
#else
#ifdef UXNWSF
void segyff_(no,fmt,nsamp,err)
#else
void segyff(no,fmt,nsamp,err)
#endif
#endif
#endif
#endif
  int   *no;            /* I  SEG-Y file number */
  int   *fmt;           /* I  SEG-Y format number (1-4)*/
  int   *nsamp;         /* I  SEG-Y Number of samples/trace. */
  int   *err;           /*  O Error indicator */
{
  int   index;

  if ((index = fsindx(*no)) < 0) {
    *err = index;
    return;
  }
  if ((*fmt < 1 || *fmt > 4) ||
       *nsamp < 0 || *nsamp > (MBUF - MTBIHD)/2) {
    *err = YERFOR;
    return;
  }
  *err = YERNON;
  sys[index].format = *fmt;
  sys[index].nosamp = *nsamp;
  if (sys[index].format == 3) {
    sys[index].drecl = MTBIHD + (2 * sys[index].nosamp);
  } else {
    sys[index].drecl = MTBIHD + (4 * sys[index].nosamp);
  }
  return;
} /* segyff */
/**/
   
/*  S E G Y I D  --  Identify library version. */

/* 
 */

#ifdef STARP3           /* Stardent 3000 P3 */
void SEGYID(err)
#else
#ifdef CON120           /* Convex C-120 */
void segyid_(err)
#else
#ifdef SPARC1           /* Sun SPARC station 1 */
void segyid_(err)
#else
#ifdef UXNWSF
void segyid_(err)
#else
void segyid(err)
#endif
#endif
#endif
#endif
  int   *err;           /*  O Error indicator */
{
  *err = YERNON;
  return;
} /* segyid */

/* EOF segyio.c */

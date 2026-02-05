/**
 *
 * Declarations 
 *
 **/


/* Declarations of ERROR values returned by file system modules: */

#define YERNON   0      /* No Errors. */
#define EFSOPR -10      /* Can't open named file for reading */
#define EFSOPW -11      /* Can't open or create named file for writing */
#define EFSNRD -12      /* File not opened for reading */
#define EFSNWR -13      /* File not opened for writing */
#define EFSMAX -14      /* To many open files (file system overflow) */
#define EFSNOF -15      /* Attempt to adress unused file number */
#define EFSINU -16      /* Attempt to reopen used file number */
#define EFSNOC -17      /* Failed to close file */

/* File system status: */
#define FSUNUS -1       /* Unused file slot */
#define FSRESV 1        /* Reserved file slot */
#define FSOPNR 2        /* File open for reading */
#define FSOPNW 3        /* File open for writing */
/**/


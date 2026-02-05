/**
 *
 * Declarations 
 *
 **/


/* Declarations of ERROR values returned by segyio modules: */

#define YERNON   0      /* No Errors. */
#define YEREOF -20      /* EOF mark met. */
#define YERRD1 -21      /* Failed to read EBCDIC reel header from file */
#define YERRD2 -22      /* Failed to read binary reel header from file */
#define YERRD3 -23      /* Failed to read binary data block from file */
#define YERCL1 -24      /* Failed to close file */
#define YEROOS -25      /* Out Of Space, less bytes written than requested */
#define YERWR1 -26      /* Failed to write EBCDIC reel header to file */
#define YERWR2 -27      /* Failed to write binary reel header to file */
#define YERWR3 -28      /* Failed to write binary data block to file */
#define YERFOR -29      /* Format number not implemented. */
#define YERMDA -30      /* Dimension of data array less than signal length */
#define YERBUF -31      /* I/O-request exceeds internal buffer size. */


/* Declarations of constants global WITHIN this module */

/* Dimensions: */
#define MBUF   65536    /* MAX size of I/O buffer to MAC-tape (bytes) */
#define MEBCHD  3200    /* Size of EBCDIC reel header (bytes) */
#define MRBIHD   400    /* Size of binary reel header (bytes) */
#define MTBIHD   240    /* Size of binary trace header (bytes) */
#define MBREHD   197    /* Number of entries in the binary reel header */
#define MBTRHD   101    /* Number of entries in the binary trace header */
#define MFNAME    65    /* MAX size of file names. */

#define M_LN16 (log(16.0)) /* Log(16) (extention to math.h) */
#define M_2i24 16777216    /* 2**24   (extention to math.h) */

/**/

/* Taken from fsdriv.c */
#define IFIL int        /* System file descriptors are integers */
                        /* for level 1 (raw) I/O */

extern int fsclos(int);
extern int fsoprd(int, char*);
extern int fsopwr(int, char*);
extern int fsread(int, char*, int);
extern IFIL fsindx(int);
extern int fswrit(int, char*, int);

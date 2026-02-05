
/*  D E B U G  --  Enter a record in the debugging log  */

/*
 Call with a format, two strings, and a number:
   f  - Format, a bit string in range 0-7.
        If bit x is on, then argument number x is printed.
   s1 - String, argument number 1.  If selected, printed as is.
   s2 - String, argument number 2.  If selected, printed in brackets.
   n  - Int, argument 3.  If selected, printed preceded by equals sign.

   f=0 is fdecial: print s1,s2, and interpret n as a char.
*/
debug(fd,f,s1,s2,n) FILE *fd; int f, n; char *s1, *s2; {

    switch (f) {
    	case F000:			/* 0, print both strings, */
	    fprintf(fd,"%s%s%c\n",s1,s2,n); /*  and interpret n as a char */
	    break;
    	case F001:			/* 1, "=n" */
	    fprintf(fd,"=%d\n",n);
	    break;
    	case F010:			/* 2, "[s2]" */
	    fprintf(fd,"[%s]\n",s2);
	    break;
    	case F011:			/* 3, "[s2]=n" */
	    fprintf(fd,"[%s]=%d\n",s2,n);
	    break;
    	case F100:			/* 4, "s1" */
	    fprintf(fd,"%s\n",s1);
	    break;
    	case F101:			/* 5, "s1=n" */
	    fprintf(fd,"%s=%d\n",s1,n);
	    break;
    	case F110:			/* 6, "s1[s2]" */
	    fprintf(fd,"%s[%s]\n",s1,s2);
	    break;
    	case F111:			/* 7, "s1[s2]=n" */
	    fprintf(fd,"%s[%s]=%d\n",s1,s2,n);
	    break;
	default:
	    fprintf(fd,"\n?Invalid format for debug() - %d\n",n);
    }
}

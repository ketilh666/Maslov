	.set	noreorder
	.set	noat
	#	/usr/lib32/cmplrs/be
	#ident	"$Source: /hosts/bonnie.mti/depot/cmplrs.src/v7.2+/be/RCS/version.c,v $ $Revision: 3.0 $"
	#ism	1274555410

	#-----------------------------------------------------------
	# Compiling qroots.f (/tmp/ctmB.BAAa04dVn)
	#-----------------------------------------------------------

	#-----------------------------------------------------------
	# Options:
	#-----------------------------------------------------------
	#  Target:R10000, ISA:mips4, Pointer Size:64
	#  -O3	(Optimization level)
	#  -g0	(Debug level)
	#  -m1	(Report warnings)
	#-----------------------------------------------------------

	.file	1	"/home/sgisrv/d01/seisware/maslov/src_f77/lego/qroots.f"

	.section .text, 1, 0x00000006, 4, 16
.text:

	.section .lit8, 1, 0x30000002, 8, 8
.lit8:
	.section .text

	# Program Unit: qroots_
	.ent	qroots_
	.globl	qroots_
qroots_: 	 # 0x0
	.frame	$sp, 0, $31
.BB1.qroots_: 	 # 0x0
 #<freq>
 #<freq> BB:1 frequency = 1.00000 (heuristic)
 #<freq> BB:1 => BB:3 probability = 0.50000
 #<freq> BB:1 => BB:2 probability = 0.50000
 #<freq>
	.loc	1 14 18
 #  10  C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
 #  11  C
 #  12  C************************************************************************
 #  13  
 #  14        SUBROUTINE QROOTS(XM,XP,A,B,C)
	lui $2,%hi(%neg(%gp_rel(qroots_ +0)))	# [0]  
	addiu $2,$2,%lo(%neg(%gp_rel(qroots_ +0)))	# [1]  
	ldc1 $f4,0($7)                	# [2]  
	daddu $1,$25,$2               	# [2]  
	ldc1 $f5,%gp_rel(.lit8-30720)($1)	# [3]  
	ldc1 $f6,0($6)                	# [5]  
	mul.d $f4,$f4,$f5             	# [6]  
	div.d $f4,$f4,$f6             	# [8]  
	ldc1 $f5,0($8)                	# [22]  
	div.d $f5,$f5,$f6             	# [25]  
	mul.d $f6,$f4,$f4             	# [40]  
	div.d $f5,$f5,$f6             	# [42]  
	ldc1 $f6,%gp_rel(.lit8-30712)($1)	# [56]  
	ldc1 $f0,%gp_rel(.lit8-30704)($1)	# [58]  
	sub.d $f5,$f6,$f5             	# [59]  
	.loc	1 57 10
 #  53           XP = B1*(1.0d0 + D1)
 #  54           XM = B1*(1.0d0 - D1)
 #  55        ELSE
 #  56           D1 = SQRT(-D2)
 #  57           XP = B1*(1.0d0 + TOSH)
	ldc1 $f1,%gp_rel(.lit8-30696)($1)	# [61]  
	.loc	1 14 18
	c.le.d $fcc0,$f0,$f5          	# [61]  
	.loc	1 58 10
 #  58           XM = B1*(1.0d0 - TOSH)
	ldc1 $f2,%gp_rel(.lit8-30688)($1)	# [64]  
	.loc	1 14 18
	bc1f $fcc0,.L.1.3.temp        	# [64]  
	.loc	1 57 10
	mul.d $f1,$f4,$f1             	# [64]  
.BB2.qroots_: 	 # 0x50
 #<freq>
 #<freq> BB:2 frequency = 0.50000 (heuristic)
 #<freq>
	.loc	1 53 10
	sqrt.d $f0,$f5                	# [0]  
	.loc	1 54 10
	sub.d $f1,$f6,$f0             	# [30]  
	.loc	1 53 10
	add.d $f0,$f0,$f6             	# [31]  
	.loc	1 54 10
	mul.d $f1,$f1,$f4             	# [32]  
	.loc	1 53 10
	mul.d $f0,$f0,$f4             	# [33]  
	.loc	1 54 10
	sdc1 $f1,0($4)                	# [33]  
	.loc	1 76 7
 #  72  c$$$      WRITE(6,*) '     - GN    = ',SQRT(XM),SQRT(XP),A
 #  73  C******** END   DEBUGGING ********
 #  74  
 #  75  C-----------------------------------------------------------------------
 #  76        RETURN
	jr $31                        	# [0]  
	.loc	1 53 10
	sdc1 $f0,0($5)                	# [34]  
.L.1.3.temp: 	 # 0x70
 #<freq>
 #<freq> BB:3 frequency = 0.50000 (heuristic)
 #<freq>
	.loc	1 57 10
	sdc1 $f1,0($5)                	# [0]  
	.loc	1 58 10
	mul.d $f2,$f4,$f2             	# [0]  
	sdc1 $f2,0($4)                	# [1]  
.L.1.2.temp: 	 # 0x7c
 #<freq>
 #<freq> BB:4 frequency = 1.00000 (heuristic)
 #<freq>
	.loc	1 76 7
	jr $31                        	# [0]  
	nop                           	# [0]  
	.end	qroots_

	.section .lit8
	.origin 0x20
	.align	0
	# offset 32
	.dword	0x3feffffde7210be9  	# double 0.999999
	.origin 0x10
	.align	0
	# offset 16
	.dword	0x0000000000000000  	# double 0.00000
	.origin 0x0
	.align	0
	# offset 0
	.dword	0x3fe0000000000000  	# double 0.500000
	.origin 0x18
	.align	0
	# offset 24
	.dword	0x3ff000010c6f7a0b  	# double 1.00000
	.origin 0x8
	.align	0
	# offset 8
	.dword	0x3ff0000000000000  	# double 1.00000
	.section .text
	.align 4
	.section .lit8
	.align 3
	.gpvalue 30720

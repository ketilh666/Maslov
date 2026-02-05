	.set	noreorder
	.set	noat
	#	/usr/lib32/cmplrs/be
	#ident	"$Source: /hosts/bonnie.mti/depot/cmplrs.src/v7.2+/be/RCS/version.c,v $ $Revision: 3.0 $"
	#ism	1274555410

	#-----------------------------------------------------------
	# Compiling bill.f (/tmp/ctmB.BAAa04e9g)
	#-----------------------------------------------------------

	#-----------------------------------------------------------
	# Options:
	#-----------------------------------------------------------
	#  Target:R10000, ISA:mips4, Pointer Size:64
	#  -O3	(Optimization level)
	#  -g0	(Debug level)
	#  -m1	(Report warnings)
	#-----------------------------------------------------------

	.file	1	"/home/sgisrv/d01/seisware/maslov/src_f77/lego/bill.f"

	.section .text, 1, 0x00000006, 4, 16
.text:

	.section .lit8, 1, 0x30000002, 8, 8
.lit8:
	.section .text

	# Program Unit: bill_
	.ent	bill_
	.globl	bill_
bill_: 	 # 0x0
	.frame	$sp, 640, $31
	.mask	0x80000000, -128
	# DHDPP = 0
	# DHDPX = 72
	# DHDXP = 144
	# DHDXX = 216
.BB1.bill_: 	 # 0x0
 #<freq>
 #<freq> BB:1 frequency = 1.00000 (heuristic)
 #<freq>
	.loc	1 24 18
 #  20  C PROGRAMMED         : KETIL HOKSTAD DECEMBER 1998
 #  21  C
 #  22  C************************************************************************
 #  23  
 #  24        SUBROUTINE BILL(QXDOT,PXDOT,QX,PX,DGAMDX,DGAMDP,DGAMXX,
	daddiu $sp,$sp,-640           	# [0]  .frame.len.bill_
	sd $16,520($sp)               	# [1]  .gra_spill_b030
	sd $17,536($sp)               	# [2]  .gra_spill_b032
	sd $18,544($sp)               	# [3]  .gra_spill_b033
	sd $19,496($sp)               	# [4]  .gra_spill_b027
	sd $20,504($sp)               	# [5]  .gra_spill_b028
	sd $21,528($sp)               	# [6]  .gra_spill_b031
	sd $22,552($sp)               	# [7]  .gra_spill_b034
	sd $31,512($sp)               	# [8]  .gra_spill_b029
	.loc	1 56 7
 #  52  C-----------------------------------------------------------------------
 #  53  C  2nd derivatives of the Hamiltonian, Cerveny equation (4.14.7)
 #  54  C-----------------------------------------------------------------------
 #  55  
 #  56        DO L=1,3
	addiu $13,$0,1                	# [9]  
	sd $13,360($sp)               	# [9]  .gra_spill_b010
	sd $11,472($sp)               	# [10]  .gra_spill_b024
	sd $5,384($sp)                	# [11]  .gra_spill_b013
	sd $4,392($sp)                	# [12]  .gra_spill_b014
	sd $30,400($sp)               	# [13]  .gra_spill_b015
	sd $23,440($sp)               	# [14]  .gra_spill_b020
	sd $gp,448($sp)               	# [15]  .gra_spill_b021
	ld $12,640($sp)               	# [16]  DGAMPX
	sd $12,560($sp)               	# [17]  .gra_spill_b035
	addiu $gp,$0,32               	# [18]  
	sd $gp,352($sp)               	# [18]  .gra_spill_b009
	ld $gp,648($sp)               	# [19]  DGAMPP
	addiu $23,$0,36               	# [20]  
	sd $23,336($sp)               	# [20]  .gra_spill_b007
	ld $23,672($sp)               	# [21]  GIDGJP
	addiu $30,$0,40               	# [22]  
	sd $30,344($sp)               	# [22]  .gra_spill_b008
	ld $30,664($sp)               	# [23]  GIDGJX
	addiu $2,$0,13                	# [24]  
	sd $2,480($sp)                	# [24]  .gra_spill_b025
	ld $2,656($sp)                	# [25]  GIGJ
	sd $7,368($sp)                	# [26]  .gra_spill_b011
	.loc	1 24 18
	daddiu $3,$sp,0               	# [27]  DHDPP
	sd $6,376($sp)                	# [27]  .gra_spill_b012
	lui $7,%hi(%neg(%gp_rel(bill_ +0)))	# [27]  
	.loc	1 56 7
	daddiu $3,$3,56               	# [28]  
	sd $3,488($sp)                	# [28]  .gra_spill_b026
	.loc	1 24 18
	addiu $6,$7,%lo(%neg(%gp_rel(bill_ +0)))	# [28]  
	.loc	1 56 7
	daddiu $2,$2,32               	# [29]  
	sd $2,464($sp)                	# [29]  .gra_spill_b023
	.loc	1 24 18
	daddu $1,$25,$6               	# [29]  
	.loc	1 56 7
	ldc1 $f18,%gp_rel(.lit8-30712)($1)	# [30]  
	or $4,$12,$0                  	# [31]  
	ldc1 $f17,%gp_rel(.lit8-30720)($1)	# [31]  
.L.1.17.temp: 	 # 0xb0
 #<loop> Loop body line 56, nesting depth: 1, iterations: 3
 #<sched> 
 #<sched> Loop schedule length: 24 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    23 mem refs     ( 95% of peak)
 #<sched>    21 integer ops  ( 43% of peak)
 #<sched>    44 instructions ( 45% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:2 frequency = 3.00000 (heuristic)
 #<freq>
	ld $13,344($sp)               	# [0]  .gra_spill_b008
	sd $13,456($sp)               	# [1]  .gra_spill_b022
	ld $13,352($sp)               	# [2]  .gra_spill_b009
	daddiu $2,$sp,0               	# [3]  DHDPP
	daddiu $7,$sp,144             	# [3]  DHDXP
	daddiu $12,$sp,216            	# [4]  DHDXX
	daddu $7,$13,$7               	# [4]  
	sd $7,312($sp)                	# [4]  .gra_spill_b004
	daddiu $3,$sp,72              	# [5]  DHDPX
	daddu $12,$13,$12             	# [5]  
	sd $12,328($sp)               	# [5]  .gra_spill_b006
	daddu $3,$13,$3               	# [6]  
	daddu $13,$13,$2              	# [6]  
	sd $13,304($sp)               	# [6]  .gra_spill_b003
	ld $13,336($sp)               	# [7]  .gra_spill_b007
	addiu $12,$0,13               	# [8]  
	sd $12,296($sp)               	# [8]  .gra_spill_b002
	ld $12,472($sp)               	# [9]  .gra_spill_b024
	daddiu $7,$13,7               	# [9]  
	sd $3,320($sp)                	# [10]  .gra_spill_b005
	dsll $7,$7,3                  	# [10]  
	daddiu $13,$13,13             	# [11]  
	sd $13,288($sp)               	# [11]  .gra_spill_b001
	daddu $7,$7,$12               	# [11]  
.L.1.20.temp: 	 # 0x110
 #<loop> Loop body line 56, nesting depth: 2, iterations: 3
 #<sched> 
 #<sched> Loop schedule length: 24 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    16 flops        ( 33% of peak) (madds count as 2)
 #<sched>    12 flops        ( 25% of peak) (madds count as 1)
 #<sched>     4 madds        ( 16% of peak)
 #<sched>    24 mem refs     (100% of peak)
 #<sched>    15 integer ops  ( 31% of peak)
 #<sched>    51 instructions ( 53% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:3 frequency = 9.00000 (heuristic)
 #<freq>
	.loc	1 57 10
 #  57           DO K=1,3
	ld $2,456($sp)                	# [0]  .gra_spill_b022
	.loc	1 58 13
 #  58              H1XX = 0.0
	mov.d $f8,$f17                	# [1]  
	.loc	1 57 10
	ld $13,288($sp)               	# [1]  .gra_spill_b001
	.loc	1 59 13
 #  59              H1XP = 0.0
	mov.d $f4,$f17                	# [2]  
	.loc	1 65 13
 #  61              H1PP = 0.0
 #  62              H2XX = 0.0
 #  63              H2XP = 0.0
 #  64              H2PX = 0.0
 #  65              H2PP = 0.0
	ld $22,296($sp)               	# [2]  .gra_spill_b002
	.loc	1 60 13
	mov.d $f10,$f17               	# [3]  
	.loc	1 65 13
	ld $5,480($sp)                	# [3]  .gra_spill_b025
	.loc	1 61 13
	mov.d $f5,$f17                	# [4]  
	.loc	1 65 13
	dsll $22,$22,3                	# [4]  
	ld $6,456($sp)                	# [4]  .gra_spill_b022
	.loc	1 62 13
	mov.d $f7,$f17                	# [5]  
	.loc	1 65 13
	dsll $5,$5,3                  	# [5]  
	ld $20,288($sp)               	# [5]  .gra_spill_b001
	.loc	1 63 13
	mov.d $f11,$f17               	# [6]  
	.loc	1 65 13
	ld $21,472($sp)               	# [6]  .gra_spill_b024
	.loc	1 57 10
	daddiu $13,$13,9              	# [6]  
	.loc	1 65 13
	dsll $6,$6,3                  	# [6]  
	.loc	1 57 10
	ld $12,296($sp)               	# [7]  .gra_spill_b002
	.loc	1 64 13
	mov.d $f6,$f17                	# [7]  
	.loc	1 57 10
	daddiu $2,$2,9                	# [7]  
	.loc	1 65 13
	dsll $20,$20,3                	# [7]  
	ld $11,464($sp)               	# [8]  .gra_spill_b023
	mov.d $f9,$f17                	# [8]  
	daddu $20,$20,$21             	# [8]  
	daddu $21,$6,$21              	# [8]  
.L.1.23.temp: 	 # 0x174
 #<loop> Loop body line 65, nesting depth: 3, iterations: 3
 #<sched> 
 #<sched> Loop schedule length: 8 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     0 mem refs     (  0% of peak)
 #<sched>    15 integer ops  ( 93% of peak)
 #<sched>    15 instructions ( 46% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:4 frequency = 27.00000 (heuristic)
 #<freq>
	daddu $17,$6,$gp              	# [0]  
	daddu $24,$6,$10              	# [0]  
	daddu $14,$6,$4               	# [1]  
	.loc	1 67 16
 #  66              DO J=1,3
 #  67                 DO I=1,3
	daddiu $6,$6,8                	# [1]  
	.loc	1 65 13
	or $15,$11,$0                 	# [2]  
	or $25,$21,$0                 	# [2]  
	.loc	1 67 16
	daddiu $21,$21,8              	# [3]  
	.loc	1 65 13
	daddu $19,$5,$30              	# [3]  
	daddu $31,$5,$23              	# [4]  
	.loc	1 67 16
	daddiu $5,$5,8                	# [4]  
	.loc	1 65 13
	daddu $16,$22,$8              	# [5]  
	daddu $18,$22,$9              	# [5]  
.L.1.26.temp: 	 # 0x1a4
 #<loop> Loop body line 65, nesting depth: 4, iterations: 3
 #<loop> Not unrolled: would exceed limit CG:unroll_min_trip=5
 #<swpf> Loop line 65 wasn't pipelined -- small trip count (3).
 #<sched> 
 #<sched> Loop schedule length: 17 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    16 flops        ( 47% of peak) (madds count as 2)
 #<sched>     8 flops        ( 23% of peak) (madds count as 1)
 #<sched>     8 madds        ( 47% of peak)
 #<sched>     9 mem refs     ( 52% of peak)
 #<sched>    10 integer ops  ( 29% of peak)
 #<sched>    27 instructions ( 39% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:5 frequency = 81.00000 (heuristic)
 #<freq> BB:5 => BB:5 probability = 0.66667
 #<freq> BB:5 => BB:14 probability = 0.33333
 #<freq>
	.loc	1 75 19
 #  71                    H1PX = H1PX + DGAMPX(I,J,K,L)*GIGJ(I,J)
 #  72                    H1XP = H1XP + DGAMXP(I,J,K,L)*GIGJ(I,J)
 #  73  C---              2nd term:
 #  74                    H2PP = H2PP + DGAMDP(I,J,K)*GIDGJP(I,J,L)
 #  75                    H2XX = H2XX + DGAMDX(I,J,K)*GIDGJX(I,J,L)
	ldc1 $f15,-104($19)           	# [0]  
	ldc1 $f16,-104($16)           	# [1]  
	.loc	1 72 19
	ldc1 $f12,-320($25)           	# [2]  
	.loc	1 71 19
	ldc1 $f3,-320($14)            	# [3]  
	.loc	1 70 19
	ldc1 $f2,-320($24)            	# [4]  
	.loc	1 69 19
	ldc1 $f1,-320($17)            	# [5]  
	.loc	1 74 19
	ldc1 $f13,-104($31)           	# [6]  
	ldc1 $f14,-104($18)           	# [7]  
	.loc	1 77 19
 #  76                    H2PX = H2PX + DGAMDP(I,J,K)*GIDGJX(I,J,L)
 #  77                    H2XP = H2XP + DGAMDX(I,J,K)*GIDGJP(I,J,L)
	madd.d $f11,$f11,$f13,$f16    	# [9]  
	.loc	1 76 19
	madd.d $f6,$f6,$f15,$f14      	# [10]  
	.loc	1 69 19
	ldc1 $f0,-32($15)             	# [10]  
	.loc	1 75 19
	madd.d $f7,$f7,$f15,$f16      	# [11]  
	.loc	1 66 13
	daddiu $14,$14,24             	# [12]  
	daddiu $24,$24,24             	# [12]  
	.loc	1 74 19
	madd.d $f9,$f9,$f13,$f14      	# [12]  
	.loc	1 66 13
	daddiu $17,$17,24             	# [13]  
	daddiu $15,$15,24             	# [13]  
	.loc	1 72 19
	madd.d $f4,$f4,$f0,$f12       	# [13]  
	.loc	1 66 13
	daddiu $31,$31,24             	# [14]  
	daddiu $25,$25,24             	# [14]  
	.loc	1 71 19
	madd.d $f10,$f10,$f0,$f3      	# [14]  
	.loc	1 66 13
	daddiu $19,$19,24             	# [15]  
	daddiu $18,$18,24             	# [15]  
	.loc	1 70 19
	madd.d $f8,$f8,$f0,$f2        	# [15]  
	.loc	1 66 13
	daddiu $16,$16,24             	# [16]  
	bne $25,$20,.L.1.26.temp      	# [16]  
	.loc	1 69 19
	madd.d $f5,$f5,$f0,$f1        	# [16]  
.BB14.bill_: 	 # 0x210
 #<loop> Part of loop body line 65, head labeled .L.1.23.temp
 #<freq>
 #<freq> BB:14 frequency = 27.00000 (heuristic)
 #<freq> BB:14 => BB:4 probability = 0.66667
 #<freq> BB:14 => BB:15 probability = 0.33333
 #<freq>
	.loc	1 67 16
	daddiu $22,$22,8              	# [6]  
	daddiu $11,$11,8              	# [0]  
	bne $21,$7,.L.1.23.temp       	# [1]  
	daddiu $20,$20,8              	# [1]  
.BB15.bill_: 	 # 0x220
 #<loop> Part of loop body line 56, head labeled .L.1.20.temp
 #<freq>
 #<freq> BB:15 frequency = 9.00000 (heuristic)
 #<freq> BB:15 => BB:3 probability = 0.66667
 #<freq> BB:15 => BB:8 probability = 0.33333
 #<freq>
	.loc	1 82 13
 #  78                 ENDDO
 #  79              ENDDO
 #  80              DHDXX(K,L) = 0.5*H1XX + H2XX
 #  81              DHDXP(K,L) = 0.5*H1XP + H2XP
 #  82              DHDPX(K,L) = 0.5*H1PX + H2PX
	ld $3,320($sp)                	# [9]  .gra_spill_b005
	sd $13,288($sp)               	# [0]  .gra_spill_b001
	.loc	1 57 10
	daddiu $12,$12,9              	# [1]  
	sd $12,296($sp)               	# [1]  .gra_spill_b002
	.loc	1 81 13
	madd.d $f1,$f11,$f4,$f18      	# [2]  
	.loc	1 57 10
	ld $12,328($sp)               	# [2]  .gra_spill_b006
	.loc	1 81 13
	ld $13,312($sp)               	# [3]  .gra_spill_b004
	.loc	1 57 10
	daddiu $12,$12,8              	# [4]  
	sd $12,328($sp)               	# [4]  .gra_spill_b006
	.loc	1 81 13
	sdc1 $f1,-32($13)             	# [5]  
	.loc	1 57 10
	daddiu $13,$13,8              	# [6]  
	sd $13,312($sp)               	# [6]  .gra_spill_b004
	.loc	1 82 13
	madd.d $f2,$f6,$f10,$f18      	# [6]  
	sd $2,456($sp)                	# [7]  .gra_spill_b022
	.loc	1 83 13
 #  83              DHDPP(K,L) = 0.5*H1PP + H2PP
	ld $2,304($sp)                	# [8]  .gra_spill_b003
	madd.d $f3,$f9,$f5,$f18       	# [9]  
	.loc	1 82 13
	sdc1 $f2,-32($3)              	# [9]  
	.loc	1 80 13
	madd.d $f0,$f7,$f8,$f18       	# [10]  
	.loc	1 57 10
	daddiu $3,$3,8                	# [10]  
	sd $3,320($sp)                	# [10]  .gra_spill_b005
	ld $3,488($sp)                	# [11]  .gra_spill_b026
	.loc	1 83 13
	sdc1 $f3,-32($2)              	# [12]  
	.loc	1 57 10
	daddiu $2,$2,8                	# [12]  
	.loc	1 80 13
	sdc1 $f0,-40($12)             	# [13]  
	.loc	1 57 10
	daddiu $7,$7,72               	# [14]  
	bne $2,$3,.L.1.20.temp        	# [14]  
	sd $2,304($sp)                	# [14]  .gra_spill_b003
.L.1.29.temp: 	 # 0x28c
.L.1.18.temp: 	 # 0x28c
 #<loop> Part of loop body line 56, head labeled .L.1.17.temp
 #<freq>
 #<freq> BB:8 frequency = 3.00000 (heuristic)
 #<freq> BB:8 => BB:2 probability = 0.66667
 #<freq> BB:8 => BB:9 probability = 0.33333
 #<freq>
	.loc	1 56 7
	ld $13,344($sp)               	# [0]  .gra_spill_b008
	ld $2,488($sp)                	# [1]  .gra_spill_b026
	daddiu $13,$13,27             	# [2]  
	sd $13,344($sp)               	# [2]  .gra_spill_b008
	ld $13,480($sp)               	# [3]  .gra_spill_b025
	ld $3,352($sp)                	# [4]  .gra_spill_b009
	daddiu $2,$2,24               	# [5]  
	sd $2,488($sp)                	# [5]  .gra_spill_b026
	daddiu $3,$3,24               	# [6]  
	sd $3,352($sp)                	# [6]  .gra_spill_b009
	ld $3,360($sp)                	# [7]  .gra_spill_b010
	ld $2,336($sp)                	# [8]  .gra_spill_b007
	addiu $12,$0,4                	# [9]  
	addiu $3,$3,1                 	# [9]  
	sd $3,360($sp)                	# [9]  .gra_spill_b010
	daddiu $2,$2,27               	# [10]  
	sd $2,336($sp)                	# [10]  .gra_spill_b007
	daddiu $13,$13,9              	# [11]  
	bne $3,$12,.L.1.17.temp       	# [11]  
	sd $13,480($sp)               	# [11]  .gra_spill_b025
.L.1.30.temp: 	 # 0x2dc
.L.1.15.temp: 	 # 0x2dc
 #<freq>
 #<freq> BB:9 frequency = 1.00000 (heuristic)
 #<freq>
	ld $gp,448($sp)               	# [0]  .gra_spill_b021
	ld $22,552($sp)               	# [1]  .gra_spill_b034
	ld $18,544($sp)               	# [2]  .gra_spill_b033
	ld $17,536($sp)               	# [3]  .gra_spill_b032
	ld $21,528($sp)               	# [4]  .gra_spill_b031
	ld $16,520($sp)               	# [5]  .gra_spill_b030
	ld $31,512($sp)               	# [6]  .gra_spill_b029
	ld $23,440($sp)               	# [7]  .gra_spill_b020
	addiu $10,$0,4                	# [8]  
	daddiu $4,$sp,216             	# [8]  DHDXX
	ld $9,392($sp)                	# [8]  .gra_spill_b014
	daddiu $5,$sp,0               	# [9]  DHDPP
	daddiu $6,$sp,144             	# [9]  DHDXP
	ld $25,368($sp)               	# [9]  .gra_spill_b011
	daddiu $7,$sp,72              	# [10]  DHDPX
	daddiu $11,$sp,216            	# [10]  DHDXX
	ld $24,376($sp)               	# [10]  .gra_spill_b012
	daddiu $11,$11,104            	# [11]  
	ld $8,384($sp)                	# [11]  .gra_spill_b013
	daddiu $25,$25,8              	# [11]  
	ld $20,504($sp)               	# [12]  .gra_spill_b028
	daddiu $24,$24,8              	# [12]  
	daddiu $9,$9,8                	# [12]  
	ld $19,496($sp)               	# [13]  .gra_spill_b027
	daddiu $30,$8,32              	# [13]  
	daddiu $8,$8,8                	# [13]  
.L.1.33.temp: 	 # 0x344
 #<loop> Loop body line 56, nesting depth: 1, iterations: 3
 #<sched> 
 #<sched> Loop schedule length: 53 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    52 flops        ( 49% of peak) (madds count as 2)
 #<sched>    28 flops        ( 26% of peak) (madds count as 1)
 #<sched>    24 madds        ( 45% of peak)
 #<sched>    40 mem refs     ( 75% of peak)
 #<sched>    12 integer ops  ( 11% of peak)
 #<sched>    80 instructions ( 37% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:10 frequency = 3.00000 (heuristic)
 #<freq>
	sd $25,424($sp)               	# [0]  .gra_spill_b018
	.loc	1 95 13
 #  91  
 #  92        DO K=1,2
 #  93           DO J=1,3
 #  94              QXDOT(J,K) = 0.0
 #  95              PXDOT(J,K) = 0.0
	sdc1 $f17,16($8)              	# [1]  
	sd $24,416($sp)               	# [2]  .gra_spill_b017
	.loc	1 94 13
	sdc1 $f17,16($9)              	# [3]  
	.loc	1 97 16
 #  96              DO I=1,3
 #  97                 QXDOT(J,K) = QXDOT(J,K) + DHDPX(J,I)*QX(I,K)
	mov.d $f5,$f17                	# [4]  
	.loc	1 95 13
	sdc1 $f17,-8($8)              	# [4]  
	.loc	1 97 16
	or $14,$24,$0                 	# [4]  
	.loc	1 99 16
 #  98       +                                 + DHDPP(J,I)*PX(I,K)
 #  99                 PXDOT(J,K) = PXDOT(J,K) - DHDXP(J,I)*PX(I,K)
	mov.d $f4,$f17                	# [5]  
	.loc	1 94 13
	sdc1 $f17,-8($9)              	# [5]  
	.loc	1 97 16
	or $15,$25,$0                 	# [5]  
	dsll $12,$10,3                	# [5]  
	.loc	1 99 16
	mov.d $f6,$f17                	# [6]  
	.loc	1 97 16
	daddu $13,$12,$7              	# [6]  
	sd $13,408($sp)               	# [6]  .gra_spill_b016
	daddu $15,$12,$5              	# [6]  
	mov.d $f7,$f17                	# [7]  
	daddu $14,$12,$6              	# [7]  
	daddu $12,$12,$4              	# [7]  
	sd $12,432($sp)               	# [7]  .gra_spill_b019
.BB17.bill_: 	 # 0x390
 #<loop> Part of loop body line 56, head labeled .L.1.33.temp
 #<loop> Unrolled 3 times (fully)
 #<freq>
 #<freq> BB:17 frequency = 3.00000 (heuristic)
 #<freq>
	.loc	1 99 16
	ldc1 $f13,16($14)             	# [0]  
	.loc	1 97 16
	ldc1 $f15,-8($15)             	# [1]  
	ld $2,416($sp)                	# [2]  .gra_spill_b017
	ld $3,424($sp)                	# [3]  .gra_spill_b018
	.loc	1 99 16
	ldc1 $f3,-32($14)             	# [4]  
	.loc	1 97 16
	ld $13,408($sp)               	# [5]  .gra_spill_b016
	.loc	1 99 16
	ld $12,432($sp)               	# [6]  .gra_spill_b019
	.loc	1 97 16
	ldc1 $f2,-32($13)             	# [7]  
	.loc	1 99 16
	ldc1 $f1,-32($12)             	# [8]  
	.loc	1 97 16
	ldc1 $f0,-32($15)             	# [9]  
	.loc	1 99 16
	ldc1 $f18,-8($14)             	# [10]  
	.loc	1 97 16
	ldc1 $f8,-8($13)              	# [11]  
	.loc	1 99 16
	ldc1 $f16,-8($12)             	# [12]  
	.loc	1 97 16
	ldc1 $f12,16($13)             	# [13]  
	ldc1 $f14,16($3)              	# [14]  
	ldc1 $f10,16($2)              	# [15]  
	.loc	1 99 16
	ldc1 $f11,16($12)             	# [16]  
	.loc	1 97 16
	ldc1 $f9,16($15)              	# [17]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f14,$f3      	# [17]  
	.loc	1 97 16
	ldc1 $f19,24($3)              	# [18]  
	madd.d $f5,$f5,$f10,$f2       	# [18]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f10,$f1      	# [19]  
	.loc	1 97 16
	ldc1 $f10,24($2)              	# [19]  
	madd.d $f5,$f5,$f14,$f0       	# [20]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f19,$f18     	# [21]  
	.loc	1 97 16
	ldc1 $f14,32($3)              	# [22]  
	madd.d $f5,$f5,$f10,$f8       	# [22]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f10,$f16     	# [23]  
	.loc	1 97 16
	ldc1 $f10,32($2)              	# [23]  
	madd.d $f5,$f5,$f19,$f15      	# [24]  
	ldc1 $f19,-8($3)              	# [25]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f14,$f13     	# [25]  
	.loc	1 97 16
	madd.d $f5,$f5,$f10,$f12      	# [26]  
	.loc	1 99 16
	nmsub.d $f6,$f6,$f10,$f11     	# [27]  
	.loc	1 97 16
	ldc1 $f10,-8($2)              	# [27]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f19,$f3      	# [28]  
	.loc	1 97 16
	madd.d $f5,$f5,$f14,$f9       	# [29]  
	ldc1 $f14,0($3)               	# [30]  
	madd.d $f7,$f7,$f10,$f2       	# [30]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f10,$f1      	# [31]  
	.loc	1 97 16
	ldc1 $f10,0($2)               	# [31]  
	madd.d $f7,$f7,$f19,$f0       	# [32]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f14,$f18     	# [33]  
	.loc	1 97 16
	madd.d $f7,$f7,$f10,$f8       	# [34]  
	ldc1 $f8,8($3)                	# [34]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f10,$f16     	# [35]  
	.loc	1 97 16
	ldc1 $f10,8($2)               	# [35]  
	madd.d $f7,$f7,$f14,$f15      	# [36]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f8,$f13      	# [37]  
	.loc	1 97 16
	madd.d $f7,$f7,$f10,$f12      	# [38]  
	.loc	1 99 16
	nmsub.d $f4,$f4,$f10,$f11     	# [39]  
	.loc	1 97 16
	madd.d $f7,$f7,$f8,$f9        	# [40]  
.BB16.bill_: 	 # 0x460
 #<loop> Part of loop body line 56, head labeled .L.1.33.temp
 #<freq>
 #<freq> BB:16 frequency = 3.00000 (heuristic)
 #<freq> BB:16 => BB:10 probability = 0.66667
 #<freq> BB:16 => BB:13 probability = 0.33333
 #<freq>
	sdc1 $f7,-8($9)               	# [0]  
	.loc	1 99 16
	sdc1 $f6,16($8)               	# [1]  
	.loc	1 93 10
	daddiu $8,$8,8                	# [1]  
	daddiu $9,$9,8                	# [2]  
	daddiu $10,$10,1              	# [2]  
	.loc	1 99 16
	sdc1 $f4,-16($8)              	# [2]  
	.loc	1 93 10
	daddiu $11,$11,8              	# [3]  
	bne $8,$30,.L.1.33.temp       	# [3]  
	.loc	1 97 16
	sdc1 $f5,8($9)                	# [3]  
.L.1.38.temp: 	 # 0x484
.L.1.31.temp: 	 # 0x484
 #<freq>
 #<freq> BB:13 frequency = 1.00000 (heuristic)
 #<freq>
	.loc	1 106 7
 # 102           ENDDO
 # 103        ENDDO
 # 104  
 # 105  C-----------------------------------------------------------------------
 # 106        RETURN
	ld $30,400($sp)               	# [0]  .gra_spill_b015
	jr $31                        	# [0]  
	daddiu $sp,$sp,640            	# [0]  .frame.len.bill_
	.end	bill_

	.section .lit8
	.origin 0x0
	.align	0
	# offset 0
	.dword	0x0000000000000000  	# double 0.00000
	.origin 0x8
	.align	0
	# offset 8
	.dword	0x3fe0000000000000  	# double 0.500000
	.section .text
	.align 4
	.section .lit8
	.align 3
	.gpvalue 30720

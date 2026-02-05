	.set	noreorder
	.set	noat
	#	/usr/lib32/cmplrs/be
	#ident	"$Source: /hosts/bonnie.mti/depot/cmplrs.src/v7.2+/be/RCS/version.c,v $ $Revision: 3.0 $"
	#ism	1274555410

	#-----------------------------------------------------------
	# Compiling jacobi.f (/tmp/ctmB.BAAa04eLL)
	#-----------------------------------------------------------

	#-----------------------------------------------------------
	# Options:
	#-----------------------------------------------------------
	#  Target:R10000, ISA:mips4, Pointer Size:32
	#  -O3	(Optimization level)
	#  -g0	(Debug level)
	#  -m1	(Report warnings)
	#-----------------------------------------------------------

	.file	1	"/home/sgisrv/d01/seisware/maslov/src_f77/lego/jacobi.f"

	.section .text, 1, 0x00000006, 4, 16
.text:

	.section .lit8, 1, 0x30000002, 8, 8
.lit8:

	.section .rodata, 1, 0x00000002, 0, 8
.rodata:
	.section .text

	# Program Unit: jacobi_
	.ent	jacobi_
	.globl	jacobi_
jacobi_: 	 # 0x0
	.frame	$sp, 2416, $31
	.mask	0x80000000, -640
	# B = 800
	# Z = 0
	# _cilist = 1600
.BB1.jacobi_: 	 # 0x0
 #<freq>
 #<freq> BB:1 frequency = 1.00000 (heuristic)
 #<freq> BB:1 => BB:10 probability = 0.05970
 #<freq> BB:1 => BB:2 probability = 0.94030
 #<freq>
	.loc	1 20 18
 #  16  C MODIFIED           : KETIL HOKSTAD DECEMBER 1998
 #  17  C
 #  18  C************************************************************************
 #  19  
 #  20        SUBROUTINE JACOBI(A,N,NP,D,V,NROT)
	lw $3,0($6)                   	# [0]  
	addiu $sp,$sp,-2416           	# [0]  .frame.len.jacobi_
	sd $8,2048($sp)               	# [1]  .gra_spill_b048
	sd $7,1960($sp)               	# [2]  .gra_spill_b037
	sd $4,2136($sp)               	# [3]  .gra_spill_b059
	lw $1,0($5)                   	# [4]  
	sd $1,2128($sp)               	# [5]  .gra_spill_b058
	sd $3,2224($sp)               	# [6]  .gra_spill_b070
	slti $1,$1,1                  	# [6]  
	lui $2,%hi(%neg(%gp_rel(jacobi_ +0)))	# [7]  
	sd $21,1760($sp)              	# [7]  .gra_spill_b012
	xori $1,$1,1                  	# [7]  
	sd $gp,1800($sp)              	# [8]  .gra_spill_b017
	addiu $2,$2,%lo(%neg(%gp_rel(jacobi_ +0)))	# [8]  
	or $21,$9,$0                  	# [8]  
	addu $gp,$25,$2               	# [9]  
	beq $1,$0,.L.1.34.temp        	# [9]  
	sd $1,1920($sp)               	# [9]  .gra_spill_b032
.BB2.jacobi_: 	 # 0x48
 #<freq>
 #<freq> BB:2 frequency = 0.94030 (heuristic)
 #<freq>
	.loc	1 46 10
 #  42  C  Initiallize
 #  43  C-----------------------------------------------------------
 #  44  
 #  45        DO IP=1,N
 #  46           DO IQ=1,N
	ld $13,2224($sp)              	# [0]  .gra_spill_b070
	ld $8,2128($sp)               	# [1]  .gra_spill_b058
	addiu $10,$0,1                	# [2]  
	ld $1,2048($sp)               	# [2]  .gra_spill_b048
	sll $14,$13,3                 	# [2]  
	sll $13,$13,3                 	# [3]  
	addiu $8,$8,1                 	# [3]  
	sd $8,2200($sp)               	# [3]  .gra_spill_b067
	addiu $7,$1,8                 	# [4]  
	sll $8,$8,3                   	# [4]  
	b .L.1.37.temp                	# [5]  
	addu $8,$8,$1                 	# [5]  
.BB133.jacobi_: 	 # 0x78
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<freq>
 #<freq> BB:133 frequency = 94.02985 (heuristic)
 #<freq> BB:133 => BB:131 probability = 0.08333
 #<freq> BB:133 => BB:136 probability = 0.91667
 #<freq>
	sra $6,$11,3                  	# [0]  
	beq $6,$0,.BB131.jacobi_      	# [2]  
	or $12,$5,$0                  	# [2]  
.BB136.jacobi_: 	 # 0x84
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<swp> 
 #<swp> Pipelined loop line 46 short trip count test (<= 1)
 #<swp> 
 #<freq>
 #<freq> BB:136 frequency = 86.19403 (heuristic)
 #<freq> BB:136 => BB:140 probability = 0.00000
 #<freq> BB:136 => BB:139 probability = 1.00000
 #<freq>
	slti $1,$6,2                  	# [0]  
	bne $1,$0,.BB140.jacobi_      	# [2]  
	ldc1 $f10,%gp_rel(.lit8-30720)($gp)	# [0]  
.BB139.jacobi_: 	 # 0x90
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<swp> 
 #<swp> Pipelined loop line 46 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:139 frequency = 86.19403 (heuristic)
 #<freq>
	.loc	1 47 13
 #  47              V(IP,IQ)=0.d0
	sdc1 $f10,0($12)              	# [2]  
	addiu $2,$8,-64               	# [3]  
	or $1,$12,$0                  	# [3]  
	sdc1 $f10,-8($12)             	# [3]  
.BB138.jacobi_: 	 # 0xa0
 #<loop> Loop body line 46, nesting depth: 2, estimated iterations: 11
 #<loop> Unrolled 8 times
 #<swps> 
 #<swps> Pipelined loop line 46 steady state
 #<swps> 
 #<swps>    12 estimated iterations before pipelining
 #<swps>     8 unrollings before pipelining
 #<swps>     8 cycles per 8 iterations
 #<swps>     8 mem refs     (100% of peak)
 #<swps>     2 integer ops  ( 12% of peak)
 #<swps>    10 instructions ( 31% of peak)
 #<swps>     1 short trip threshold
 #<swps>     2 integer registers used.
 #<swps>     1 float register used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 46 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:138 frequency = 1128.35815 (heuristic)
 #<freq> BB:138 => BB:138 probability = 0.92361
 #<freq> BB:138 => BB:143 probability = 0.07639
 #<freq>
	sdc1 $f10,8($1)               	# [0]  
	sdc1 $f10,16($1)              	# [1]  
	sdc1 $f10,24($1)              	# [2]  
	sdc1 $f10,32($1)              	# [3]  
	sdc1 $f10,40($1)              	# [4]  
	sdc1 $f10,48($1)              	# [5]  
	.loc	1 45 7
	addiu $1,$1,64                	# [5]  
	.loc	1 47 13
	sdc1 $f10,-8($1)              	# [6]  
	.loc	1 45 7
	bne $1,$2,.BB138.jacobi_      	# [7]  
	.loc	1 47 13
	sdc1 $f10,0($1)               	# [7]  
.BB143.jacobi_: 	 # 0xc8
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<swp> 
 #<swp> Pipelined loop line 46 exit compensation for replication 0
 #<swp> 
 #<swp> 
 #<swp> Pipelined loop line 46 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:143 frequency = 86.19403 (heuristic)
 #<freq>
	ldc1 $f0,%gp_rel(.lit8-30720)($gp)	# [0]  
	or $2,$1,$0                   	# [1]  
	sdc1 $f0,48($2)               	# [2]  
	sdc1 $f0,40($2)               	# [3]  
	sdc1 $f0,32($2)               	# [4]  
	sdc1 $f0,24($2)               	# [5]  
	sdc1 $f0,16($2)               	# [6]  
	sdc1 $f0,8($2)                	# [7]  
.BB131.jacobi_: 	 # 0xe8
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<freq>
 #<freq> BB:131 frequency = 94.02984 (heuristic)
 #<freq> BB:131 => BB:11 probability = 0.01000
 #<freq> BB:131 => BB:5 probability = 0.99000
 #<freq>
	.loc	1 46 10
	ld $3,2200($sp)               	# [0]  .gra_spill_b067
	addiu $10,$10,1               	# [1]  
	addu $7,$13,$7                	# [2]  
	beq $3,$10,.L.1.33.temp       	# [3]  
	addu $8,$14,$8                	# [3]  
.L.1.37.temp: 	 # 0xfc
.L.1.39.temp: 	 # 0xfc
 #<loop> Loop body line 46, nesting depth: 1, estimated iterations: 100
 #<sched> 
 #<sched> Loop schedule length: 27 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    11 mem refs     ( 40% of peak)
 #<sched>    16 integer ops  ( 29% of peak)
 #<sched>    27 instructions ( 25% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:5 frequency = 94.02985 (heuristic)
 #<freq> BB:5 => BB:133 probability = 0.12500
 #<freq> BB:5 => BB:7 probability = 0.87500
 #<freq>
	ld $11,2128($sp)              	# [0]  .gra_spill_b058
	andi $6,$11,7                 	# [2]  
	beq $6,$0,.BB133.jacobi_      	# [4]  
	or $5,$7,$0                   	# [4]  
.L.1.40.temp: 	 # 0x10c
 #<loop> Loop body line 46, nesting depth: 2, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 7 iterations)
 #<sched> 
 #<sched> Loop schedule length: 3 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     2 mem refs     ( 66% of peak)
 #<sched>     3 integer ops  ( 50% of peak)
 #<sched>     5 instructions ( 41% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:7 frequency = 164.55223 (heuristic)
 #<freq> BB:7 => BB:7 probability = 0.50000
 #<freq> BB:7 => BB:354 probability = 0.50000
 #<freq>
	ldc1 $f1,%gp_rel(.lit8-30720)($gp)	# [0]  
	addi $6,$6,-1                 	# [0]  
	.loc	1 45 7
	addiu $5,$5,8                 	# [1]  
	bne $6,$0,.L.1.40.temp        	# [2]  
	.loc	1 47 13
	sdc1 $f1,-16($5)              	# [2]  
.BB354.jacobi_: 	 # 0x120
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<freq>
 #<freq> BB:354 frequency = 82.27612 (heuristic)
 #<freq>
	b .-164                       	# [0]  .BB133.jacobi_+4
	sra $6,$11,3                  	# [0]  
.L.1.34.temp: 	 # 0x128
 #<freq>
 #<freq> BB:10 frequency = 0.05970 (heuristic)
 #<freq>
	.loc	1 46 10
	ld $4,2128($sp)               	# [0]  .gra_spill_b058
	addiu $4,$4,1                 	# [2]  
	sd $4,2200($sp)               	# [2]  .gra_spill_b067
.L.1.33.temp: 	 # 0x134
 #<freq>
 #<freq> BB:11 frequency = 1.00000 (heuristic)
 #<freq> BB:11 => BB:18 probability = 0.07201
 #<freq> BB:11 => BB:12 probability = 0.92799
 #<freq>
	ld $1,1920($sp)               	# [0]  .gra_spill_b032
	beq $1,$0,.L.1.43.temp        	# [3]  
	ld $9,2128($sp)               	# [0]  .gra_spill_b058
.BB12.jacobi_: 	 # 0x140
 #<freq>
 #<freq> BB:12 frequency = 0.92799 (heuristic)
 #<freq> BB:12 => BB:146 probability = 0.25000
 #<freq> BB:12 => BB:15 probability = 0.75000
 #<freq>
	.loc	1 45 7
	or $7,$0,$0                   	# [2]  
	ld $8,2200($sp)               	# [2]  .gra_spill_b067
	andi $10,$9,3                 	# [2]  
	or $5,$0,$0                   	# [3]  
	addiu $6,$0,1                 	# [3]  
	beq $10,$0,.BB146.jacobi_     	# [4]  
	addiu $8,$8,-1                	# [4]  
.L.1.47.temp: 	 # 0x15c
 #<loop> Loop body line 45, nesting depth: 1, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 3 iterations)
 #<sched> 
 #<sched> Loop schedule length: 5 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     5 mem refs     (100% of peak)
 #<sched>     8 integer ops  ( 80% of peak)
 #<sched>    13 instructions ( 65% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:15 frequency = 1.39198 (heuristic)
 #<freq> BB:15 => BB:15 probability = 0.50000
 #<freq> BB:15 => BB:146 probability = 0.50000
 #<freq>
	.loc	1 49 10
 #  48           ENDDO
 #  49           V(IP,IP)=1.d0
	ld $2,2048($sp)               	# [0]  .gra_spill_b048
	addu $1,$6,$7                 	# [0]  
	ldc1 $f2,%gp_rel(.lit8-30712)($gp)	# [1]  
	sll $1,$1,3                   	# [1]  
	addi $10,$10,-1               	# [2]  
	addu $1,$1,$2                 	# [2]  
	.loc	1 45 7
	ld $2,2224($sp)               	# [2]  .gra_spill_b070
	addiu $5,$5,1                 	# [3]  
	addiu $6,$6,1                 	# [3]  
	.loc	1 49 10
	pref 1,248($1)                	# [3]  
	sdc1 $f2,-8($1)               	# [4]  
	bne $10,$0,.L.1.47.temp       	# [4]  
	.loc	1 45 7
	addu $7,$2,$7                 	# [4]  
.BB146.jacobi_: 	 # 0x190
 #<freq>
 #<freq> BB:146 frequency = 0.92799 (heuristic)
 #<freq> BB:146 => BB:144 probability = 0.04000
 #<freq> BB:146 => BB:149 probability = 0.96000
 #<freq>
	sra $11,$9,2                  	# [0]  
	or $10,$5,$0                  	# [1]  
	or $12,$7,$0                  	# [1]  
	beq $11,$0,.BB144.jacobi_     	# [2]  
	or $13,$6,$0                  	# [2]  
.BB149.jacobi_: 	 # 0x1a4
 #<swp> 
 #<swp> Pipelined loop line 45 short trip count test (<= 1)
 #<swp> 
 #<freq>
 #<freq> BB:149 frequency = 0.89087 (heuristic)
 #<freq> BB:149 => BB:154 probability = 0.00000
 #<freq> BB:149 => BB:153 probability = 1.00000
 #<freq>
	slti $2,$11,2                 	# [0]  
	bne $2,$0,.BB154.jacobi_      	# [2]  
	.loc	1 49 10
	ld $7,2048($sp)               	# [0]  .gra_spill_b048
.BB153.jacobi_: 	 # 0x1b0
 #<swp> 
 #<swp> Pipelined loop line 45 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:153 frequency = 0.89087 (heuristic)
 #<freq>
	addu $2,$13,$12               	# [0]  
	sll $2,$2,3                   	# [1]  
	addiu $14,$10,4               	# [1]  
	.loc	1 45 7
	ld $10,2224($sp)              	# [1]  .gra_spill_b070
	.loc	1 49 10
	addu $2,$2,$7                 	# [2]  
	.loc	1 45 7
	addiu $13,$13,1               	# [2]  
	addiu $15,$13,1               	# [3]  
	addu $3,$10,$12               	# [3]  
	sd $31,1776($sp)              	# [4]  .gra_spill_b014
	addiu $24,$15,1               	# [4]  
	addu $12,$10,$3               	# [4]  
	ldc1 $f0,%gp_rel(.lit8-30712)($gp)	# [5]  
	addiu $5,$24,1                	# [5]  
	addu $4,$10,$12               	# [5]  
	.loc	1 49 10
	pref 1,248($2)                	# [6]  
	.loc	1 45 7
	addiu $9,$5,1                 	# [6]  
	addu $6,$10,$4                	# [6]  
	nop                           	# [6]  
	nop                           	# [6]  
	nop                           	# [6]  
.BB151.jacobi_: 	 # 0x200
 #<loop> Loop body line 45, nesting depth: 1, estimated iterations: 12
 #<loop> Unrolled 4 times
 #<swps> 
 #<swps> Pipelined loop line 45 steady state
 #<swps> 
 #<swps>    25 estimated iterations before pipelining
 #<swps>     4 unrollings before pipelining
 #<swps>    11 cycles per 4 iterations
 #<swps>     8 mem refs     ( 72% of peak)
 #<swps>    22 integer ops  (100% of peak)
 #<swps>    30 instructions ( 68% of peak)
 #<swps>     1 short trip threshold
 #<swps>    20 integer registers used.
 #<swps>     1 float register used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 45 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:151 frequency = 11.82255 (heuristic)
 #<freq> BB:151 => BB:158 probability = 0.03768
 #<freq> BB:151 => BB:152 probability = 0.96232
 #<freq>
	.loc	1 49 10
	sdc1 $f0,-8($2)               	# [0]  
	addu $3,$13,$3                	# [0]  
	.loc	1 45 7
	addiu $11,$9,1                	# [0]  
	.loc	1 49 10
	addu $1,$15,$12               	# [1]  
	.loc	1 45 7
	addiu $12,$11,1               	# [1]  
	.loc	1 49 10
	sll $2,$1,3                   	# [2]  
	addu $1,$24,$4                	# [2]  
	addu $4,$2,$7                 	# [3]  
	sll $1,$1,3                   	# [3]  
	sll $3,$3,3                   	# [4]  
	pref 1,248($4)                	# [4]  
	addu $2,$1,$7                 	# [4]  
	addu $1,$5,$6                 	# [5]  
	addu $5,$3,$7                 	# [5]  
	pref 1,248($2)                	# [5]  
	sdc1 $f0,-8($2)               	# [6]  
	sll $1,$1,3                   	# [6]  
	.loc	1 45 7
	addu $3,$10,$6                	# [6]  
	.loc	1 49 10
	sdc1 $f0,-8($4)               	# [7]  
	addu $2,$1,$7                 	# [7]  
	.loc	1 45 7
	addu $1,$10,$3                	# [7]  
	.loc	1 49 10
	pref 1,248($5)                	# [8]  
	.loc	1 45 7
	addu $4,$10,$1                	# [8]  
	addiu $14,$14,4               	# [8]  
	.loc	1 49 10
	sdc1 $f0,-8($5)               	# [9]  
	.loc	1 45 7
	addiu $6,$12,1                	# [9]  
	addu $5,$10,$4                	# [9]  
	.loc	1 49 10
	pref 1,248($2)                	# [10]  
	.loc	1 45 7
	beq $14,$8,.BB158.jacobi_     	# [10]  
	addiu $13,$6,1                	# [10]  
.BB152.jacobi_: 	 # 0x278
 #<loop> Part of loop body line 45, head labeled .BB151.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 45 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:152 frequency = 11.37712 (heuristic)
 #<freq> BB:152 => BB:151 probability = 0.96085
 #<freq> BB:152 => BB:157 probability = 0.03915
 #<freq>
	.loc	1 49 10
	sdc1 $f0,-8($2)               	# [0]  
	addu $3,$9,$3                 	# [0]  
	.loc	1 45 7
	addiu $15,$13,1               	# [0]  
	.loc	1 49 10
	addu $1,$11,$1                	# [1]  
	.loc	1 45 7
	addiu $24,$15,1               	# [1]  
	.loc	1 49 10
	sll $2,$1,3                   	# [2]  
	addu $1,$12,$4                	# [2]  
	addu $4,$2,$7                 	# [3]  
	sll $2,$1,3                   	# [3]  
	sll $1,$3,3                   	# [4]  
	pref 1,248($4)                	# [4]  
	addu $3,$2,$7                 	# [4]  
	addu $2,$6,$5                 	# [5]  
	addu $1,$1,$7                 	# [5]  
	pref 1,248($3)                	# [5]  
	sdc1 $f0,-8($3)               	# [6]  
	sll $2,$2,3                   	# [6]  
	.loc	1 45 7
	addu $3,$10,$5                	# [6]  
	.loc	1 49 10
	sdc1 $f0,-8($4)               	# [7]  
	addu $2,$2,$7                 	# [7]  
	.loc	1 45 7
	addu $12,$10,$3               	# [7]  
	.loc	1 49 10
	pref 1,248($1)                	# [8]  
	.loc	1 45 7
	addu $4,$10,$12               	# [8]  
	addiu $14,$14,4               	# [8]  
	.loc	1 49 10
	sdc1 $f0,-8($1)               	# [9]  
	.loc	1 45 7
	addiu $5,$24,1                	# [9]  
	addu $6,$10,$4                	# [9]  
	.loc	1 49 10
	pref 1,248($2)                	# [10]  
	.loc	1 45 7
	bne $14,$8,.BB151.jacobi_     	# [10]  
	addiu $9,$5,1                 	# [10]  
.BB157.jacobi_: 	 # 0x2f0
 #<swp> 
 #<swp> Pipelined loop line 45 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:157 frequency = 0.44543 (heuristic)
 #<freq>
	or $25,$4,$0                  	# [0]  
	or $9,$3,$0                   	# [1]  
	or $10,$2,$0                  	# [1]  
.BB156.jacobi_: 	 # 0x2fc
 #<swp> 
 #<swp> Pipelined loop line 45 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:156 frequency = 0.89087 (heuristic)
 #<freq>
	.loc	1 49 10
	addu $3,$13,$9                	# [0]  
	ld $2,2048($sp)               	# [0]  .gra_spill_b048
	sll $3,$3,3                   	# [1]  
	addu $3,$3,$2                 	# [2]  
	pref 1,248($3)                	# [3]  
	addu $4,$15,$12               	# [3]  
	sll $4,$4,3                   	# [4]  
	addu $4,$4,$2                 	# [5]  
	pref 1,248($4)                	# [6]  
	ldc1 $f31,%gp_rel(.lit8-30712)($gp)	# [7]  
	addu $1,$24,$25               	# [7]  
	sll $1,$1,3                   	# [8]  
	sdc1 $f31,-8($10)             	# [9]  
	addu $1,$1,$2                 	# [9]  
	pref 1,248($1)                	# [10]  
	sdc1 $f31,-8($1)              	# [11]  
	sdc1 $f31,-8($4)              	# [12]  
	sdc1 $f31,-8($3)              	# [13]  
.BB144.jacobi_: 	 # 0x344
 #<freq>
 #<freq> BB:144 frequency = 0.92799 (heuristic)
 #<freq>
.L.1.43.temp: 	 # 0x344
 #<freq>
 #<freq> BB:18 frequency = 1.00000 (heuristic)
 #<freq> BB:18 => BB:24 probability = 0.07201
 #<freq> BB:18 => BB:19 probability = 0.92799
 #<freq>
	.loc	1 45 7
	ld $4,1920($sp)               	# [0]  .gra_spill_b032
	addiu $2,$sp,808              	# [1]  B+8
	sd $2,1888($sp)               	# [1]  .gra_spill_b028
	addiu $1,$sp,0                	# [1]  Z
	addiu $1,$1,8                 	# [2]  
	sd $1,1864($sp)               	# [2]  .gra_spill_b025
	beq $4,$0,.L.1.50.temp        	# [3]  
	sd $1,1896($sp)               	# [3]  .gra_spill_b029
.BB19.jacobi_: 	 # 0x364
 #<freq>
 #<freq> BB:19 frequency = 0.92799 (heuristic)
 #<freq> BB:19 => BB:161 probability = 0.50000
 #<freq> BB:19 => BB:22 probability = 0.50000
 #<freq>
	.loc	1 52 7
 #  50        ENDDO
 #  51  
 #  52        DO IP=1,N
	ld $12,1960($sp)              	# [0]  .gra_spill_b037
	ld $13,2128($sp)              	# [1]  .gra_spill_b058
	or $10,$0,$0                  	# [2]  
	addiu $5,$0,1                 	# [2]  
	ld $24,2200($sp)              	# [2]  .gra_spill_b067
	addiu $1,$sp,0                	# [3]  Z
	andi $3,$13,1                 	# [3]  
	ld $11,1888($sp)              	# [4]  .gra_spill_b028
	addiu $12,$12,8               	# [4]  
	sll $24,$24,3                 	# [4]  
	ld $8,1896($sp)               	# [5]  .gra_spill_b029
	beq $3,$0,.BB161.jacobi_      	# [5]  
	addu $24,$24,$1               	# [5]  
.L.1.53.temp: 	 # 0x398
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:22 frequency = 0.46399 (heuristic)
 #<freq>
	.loc	1 54 10
 #  53           B(IP)=A(IP,IP)
 #  54           D(IP)=B(IP)
	pref 1,248($11)               	# [0]  
	.loc	1 53 10
	ld $3,2136($sp)               	# [1]  .gra_spill_b059
	addu $2,$5,$10                	# [1]  
	sll $2,$2,3                   	# [2]  
	addu $2,$2,$3                 	# [3]  
	pref 0,248($2)                	# [4]  
	ldc1 $f0,-8($2)               	# [5]  
	sd $31,1776($sp)              	# [8]  .gra_spill_b014
	sd $16,1768($sp)              	# [9]  .gra_spill_b013
	.loc	1 54 10
	pref 1,248($12)               	# [10]  
	.loc	1 55 10
 #  55           Z(IP)=0.d0
	pref 1,248($8)                	# [11]  
	ldc1 $f1,%gp_rel(.lit8-30720)($gp)	# [12]  
	.loc	1 52 7
	ld $1,2224($sp)               	# [13]  .gra_spill_b070
	addiu $12,$12,8               	# [14]  
	.loc	1 55 10
	sdc1 $f1,-8($8)               	# [14]  
	.loc	1 52 7
	addiu $11,$11,8               	# [15]  
	addiu $8,$8,8                 	# [15]  
	.loc	1 54 10
	sdc1 $f0,-16($12)             	# [15]  
	.loc	1 52 7
	addiu $5,$5,1                 	# [16]  
	addu $10,$1,$10               	# [16]  
	.loc	1 53 10
	sdc1 $f0,-16($11)             	# [16]  
.BB161.jacobi_: 	 # 0x3ec
 #<freq>
 #<freq> BB:161 frequency = 0.92799 (heuristic)
 #<freq> BB:161 => BB:159 probability = 0.02000
 #<freq> BB:161 => BB:164 probability = 0.98000
 #<freq>
	or $25,$11,$0                 	# [0]  
	or $7,$12,$0                  	# [1]  
	sd $31,1776($sp)              	# [1]  .gra_spill_b014
	sra $14,$13,1                 	# [1]  
	or $6,$8,$0                   	# [2]  
	sd $16,1768($sp)              	# [2]  .gra_spill_b013
	or $31,$10,$0                 	# [2]  
	beq $14,$0,.BB159.jacobi_     	# [3]  
	or $16,$5,$0                  	# [3]  
.BB164.jacobi_: 	 # 0x410
 #<swp> 
 #<swp> Pipelined loop line 52 short trip count test (<= 1)
 #<swp> 
 #<freq>
 #<freq> BB:164 frequency = 0.90943 (heuristic)
 #<freq> BB:164 => BB:169 probability = 0.00000
 #<freq> BB:164 => BB:168 probability = 1.00000
 #<freq>
	slti $3,$14,2                 	# [0]  
	bne $3,$0,.BB169.jacobi_      	# [2]  
	or $10,$25,$0                 	# [0]  
.BB168.jacobi_: 	 # 0x41c
 #<swp> 
 #<swp> Pipelined loop line 52 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:168 frequency = 0.90943 (heuristic)
 #<freq>
	.loc	1 54 10
	pref 1,248($7)                	# [0]  
	.loc	1 55 10
	pref 1,248($6)                	# [1]  
	.loc	1 53 10
	ld $9,2136($sp)               	# [2]  .gra_spill_b059
	addu $4,$16,$31               	# [2]  
	sll $4,$4,3                   	# [3]  
	addu $4,$4,$9                 	# [4]  
	pref 0,248($4)                	# [5]  
	.loc	1 52 7
	ld $10,2224($sp)              	# [6]  .gra_spill_b070
	addiu $3,$16,1                	# [8]  
	addu $12,$10,$31              	# [8]  
	ld $16,1768($sp)              	# [9]  .gra_spill_b013
	.loc	1 53 10
	addu $5,$3,$12                	# [9]  
	ldc1 $f10,%gp_rel(.lit8-30720)($gp)	# [10]  
	sll $5,$5,3                   	# [10]  
	ldc1 $f2,-8($4)               	# [11]  
	addu $5,$5,$9                 	# [11]  
	addiu $11,$24,-16             	# [12]  
	pref 0,248($5)                	# [12]  
	or $4,$25,$0                  	# [13]  
	.loc	1 52 7
	addu $12,$10,$12              	# [13]  
	.loc	1 53 10
	ldc1 $f1,-8($5)               	# [13]  
	ld $31,1776($sp)              	# [14]  .gra_spill_b014
	.loc	1 52 7
	addiu $3,$3,1                 	# [14]  
	addu $1,$10,$12               	# [14]  
	addiu $8,$3,1                 	# [15]  
	addu $2,$10,$1                	# [15]  
	.loc	1 55 10
	sdc1 $f10,0($6)               	# [15]  
	nop                           	# [15]  
	nop                           	# [15]  
.BB166.jacobi_: 	 # 0x490
 #<loop> Loop body line 52, nesting depth: 1, estimated iterations: 25
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 52 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>    13 cycles per 2 iterations
 #<swps>    11 mem refs     ( 84% of peak)
 #<swps>    14 integer ops  ( 53% of peak)
 #<swps>    25 instructions ( 48% of peak)
 #<swps>     1 short trip threshold
 #<swps>    13 integer registers used.
 #<swps>     4 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 52 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:166 frequency = 23.42703 (heuristic)
 #<freq> BB:166 => BB:173 probability = 0.01941
 #<freq> BB:166 => BB:167 probability = 0.98059
 #<freq>
	.loc	1 53 10
	addu $5,$3,$12                	# [0]  
	.loc	1 54 10
	pref 1,248($4)                	# [0]  
	.loc	1 53 10
	addu $1,$8,$1                 	# [0]  
	.loc	1 54 10
	sdc1 $f1,0($7)                	# [1]  
	.loc	1 53 10
	sll $3,$1,3                   	# [1]  
	sdc1 $f1,0($4)                	# [2]  
	sll $1,$5,3                   	# [2]  
	addu $3,$3,$9                 	# [2]  
	addu $1,$1,$9                 	# [3]  
	pref 0,248($3)                	# [3]  
	ldc1 $f1,-8($3)               	# [4]  
	pref 0,248($1)                	# [5]  
	ldc1 $f0,-8($1)               	# [6]  
	.loc	1 55 10
	sdc1 $f10,-8($6)              	# [7]  
	.loc	1 54 10
	sdc1 $f2,-8($7)               	# [8]  
	.loc	1 53 10
	sdc1 $f2,-8($4)               	# [9]  
	.loc	1 52 7
	addiu $7,$7,16                	# [9]  
	addiu $6,$6,16                	# [9]  
	addu $5,$10,$2                	# [10]  
	addiu $4,$4,16                	# [10]  
	.loc	1 55 10
	sdc1 $f10,0($6)               	# [11]  
	.loc	1 52 7
	addiu $1,$8,1                 	# [11]  
	addu $12,$10,$5               	# [11]  
	beq $6,$11,.BB173.jacobi_     	# [12]  
	addiu $3,$1,1                 	# [12]  
.BB167.jacobi_: 	 # 0x4f4
 #<loop> Part of loop body line 52, head labeled .BB166.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 52 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:167 frequency = 22.97231 (heuristic)
 #<freq> BB:167 => BB:166 probability = 0.98021
 #<freq> BB:167 => BB:172 probability = 0.01979
 #<freq>
	.loc	1 53 10
	addu $2,$1,$2                 	# [0]  
	addu $1,$3,$5                 	# [0]  
	.loc	1 54 10
	sdc1 $f1,0($7)                	# [1]  
	.loc	1 53 10
	sll $1,$1,3                   	# [1]  
	sdc1 $f1,0($4)                	# [2]  
	sll $2,$2,3                   	# [2]  
	addu $1,$1,$9                 	# [2]  
	addu $2,$2,$9                 	# [3]  
	pref 0,248($1)                	# [3]  
	ldc1 $f1,-8($1)               	# [4]  
	pref 0,248($2)                	# [5]  
	ldc1 $f2,-8($2)               	# [6]  
	.loc	1 55 10
	sdc1 $f10,-8($6)              	# [7]  
	.loc	1 54 10
	sdc1 $f0,-8($7)               	# [8]  
	.loc	1 53 10
	sdc1 $f0,-8($4)               	# [9]  
	.loc	1 52 7
	addiu $7,$7,16                	# [9]  
	addiu $6,$6,16                	# [9]  
	.loc	1 55 10
	pref 1,248($6)                	# [10]  
	.loc	1 52 7
	addu $1,$10,$12               	# [10]  
	addiu $4,$4,16                	# [10]  
	.loc	1 55 10
	sdc1 $f10,0($6)               	# [11]  
	.loc	1 52 7
	addiu $3,$3,1                 	# [11]  
	addu $2,$10,$1                	# [11]  
	.loc	1 54 10
	pref 1,248($7)                	# [12]  
	.loc	1 52 7
	bne $6,$11,.BB166.jacobi_     	# [12]  
	addiu $8,$3,1                 	# [12]  
.BB172.jacobi_: 	 # 0x55c
 #<swp> 
 #<swp> Pipelined loop line 52 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:172 frequency = 0.45471 (heuristic)
 #<freq>
	mov.d $f6,$f1                 	# [0]  
	or $25,$4,$0                  	# [1]  
	mov.d $f5,$f2                 	# [1]  
.BB171.jacobi_: 	 # 0x568
 #<swp> 
 #<swp> Pipelined loop line 52 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:171 frequency = 0.90943 (heuristic)
 #<freq>
	.loc	1 54 10
	pref 1,248($25)               	# [0]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [1]  
	sdc1 $f6,0($7)                	# [2]  
	.loc	1 53 10
	sdc1 $f6,0($25)               	# [3]  
	.loc	1 55 10
	sdc1 $f2,-8($6)               	# [4]  
	.loc	1 54 10
	sdc1 $f5,-8($7)               	# [5]  
	.loc	1 53 10
	sdc1 $f5,-8($25)              	# [6]  
.BB159.jacobi_: 	 # 0x584
 #<freq>
 #<freq> BB:159 frequency = 0.92799 (heuristic)
 #<freq>
	sd $17,1816($sp)              	# [0]  .gra_spill_b019
	sdc1 $f20,1704($sp)           	# [1]  .gra_spill_b005
	sdc1 $f22,1688($sp)           	# [2]  .gra_spill_b003
	ld $16,1768($sp)              	# [3]  .gra_spill_b013
	ld $31,1776($sp)              	# [4]  .gra_spill_b014
.L.1.50.temp: 	 # 0x598
.L.1.49.temp: 	 # 0x598
 #<freq>
 #<freq> BB:24 frequency = 1.00000 (heuristic)
 #<freq>
	sd $30,1848($sp)              	# [0]  .gra_spill_b023
	sd $22,1840($sp)              	# [1]  .gra_spill_b022
	sd $19,1832($sp)              	# [2]  .gra_spill_b021
	sd $18,1824($sp)              	# [3]  .gra_spill_b020
	sd $20,1808($sp)              	# [4]  .gra_spill_b018
	sd $21,1792($sp)              	# [5]  .gra_spill_b016
	sd $31,1776($sp)              	# [6]  .gra_spill_b014
	sd $23,1784($sp)              	# [7]  .gra_spill_b015
	sd $16,1768($sp)              	# [8]  .gra_spill_b013
	sdc1 $f26,1712($sp)           	# [9]  .gra_spill_b006
	sdc1 $f28,1696($sp)           	# [10]  .gra_spill_b004
	sdc1 $f24,1680($sp)           	# [11]  .gra_spill_b002
	sdc1 $f30,1672($sp)           	# [12]  .gra_spill_b001
	sd $0,2120($sp)               	# [13]  .gra_spill_b057
	sdc1 $f20,1704($sp)           	# [14]  .gra_spill_b005
	.loc	1 66 7
 #  62  C  to machine underflow
 #  63  C-----------------------------------------------------------
 #  64  
 #  65        NROT=0
 #  66        DO I=1,MAXITER
	ld $2,2224($sp)               	# [15]  .gra_spill_b070
	sd $17,1816($sp)              	# [16]  .gra_spill_b019
	sll $17,$2,3                  	# [17]  
	sd $17,2104($sp)              	# [17]  .gra_spill_b055
	sll $17,$2,3                  	# [18]  
	sd $17,2176($sp)              	# [18]  .gra_spill_b064
	ldc1 $f20,%gp_rel(.lit8-30688)($gp)	# [19]  
	sll $17,$2,3                  	# [19]  
	sll $4,$2,3                   	# [20]  
	sd $4,2096($sp)               	# [20]  .gra_spill_b054
	sdc1 $f22,1688($sp)           	# [21]  .gra_spill_b003
	sll $4,$2,3                   	# [21]  
	sll $3,$2,3                   	# [22]  
	sd $3,1944($sp)               	# [22]  .gra_spill_b035
	ldc1 $f22,%gp_rel(.lit8-30696)($gp)	# [23]  
	sll $3,$2,3                   	# [23]  
	sll $1,$2,3                   	# [24]  
	sd $1,2208($sp)               	# [24]  .gra_spill_b068
	sll $1,$2,3                   	# [25]  
	sd $1,1936($sp)               	# [25]  .gra_spill_b034
	sd $17,1976($sp)              	# [26]  .gra_spill_b039
	sll $1,$2,3                   	# [26]  
	addiu $2,$2,1                 	# [26]  
	sll $2,$2,3                   	# [27]  
	sd $2,1880($sp)               	# [27]  .gra_spill_b027
	sd $3,2168($sp)               	# [28]  .gra_spill_b063
	sd $1,2160($sp)               	# [29]  .gra_spill_b062
	ld $1,2128($sp)               	# [30]  .gra_spill_b058
	ld $3,2200($sp)               	# [31]  .gra_spill_b067
	sd $4,2152($sp)               	# [32]  .gra_spill_b061
	mult $1,$1                    	# [32]  
	sll $4,$3,3                   	# [33]  
	sd $4,1856($sp)               	# [33]  .gra_spill_b024
	addiu $4,$3,-1                	# [34]  
	sd $4,2024($sp)               	# [34]  .gra_spill_b045
	addiu $4,$1,-1                	# [35]  
	sd $4,1872($sp)               	# [35]  .gra_spill_b026
	addiu $2,$0,1                 	# [36]  
	addiu $3,$3,-1                	# [36]  
	sd $3,1968($sp)               	# [36]  .gra_spill_b038
	slt $2,$2,$1                  	# [37]  
	addiu $3,$0,1                 	# [37]  
	sd $3,1928($sp)               	# [37]  .gra_spill_b033
	addiu $4,$1,-1                	# [38]  
	sd $4,1752($sp)               	# [38]  .gra_spill_b011
	mflo $3                       	# [38]  
	sd $2,1904($sp)               	# [39]  .gra_spill_b030
	addiu $4,$1,1                 	# [39]  
	mtc1 $3,$f31                  	# [39]  
	slti $1,$1,2                  	# [40]  
	sll $4,$4,3                   	# [40]  
	sd $4,1952($sp)               	# [40]  .gra_spill_b036
	xori $1,$1,1                  	# [41]  
	sd $1,1912($sp)               	# [41]  .gra_spill_b031
	cvt.d.w $f31,$f31             	# [41]  
	addiu $17,$0,16               	# [42]  
	b .L.1.57.temp                	# [42]  
	sdc1 $f31,1720($sp)           	# [42]  .gra_spill_b007
	nop                           	# [42]  
.L.1.73.temp: 	 # 0x6c0
.L.1.72.temp: 	 # 0x6c0
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:105 frequency = 24.40555 (heuristic)
 #<freq> BB:105 => BB:110 probability = 0.07201
 #<freq> BB:105 => BB:106 probability = 0.92799
 #<freq>
	ld $2,1920($sp)               	# [0]  .gra_spill_b032
	.loc	1 85 10
 #  81           ELSE
 #  82              TRESH=0.d0
 #  83           ENDIF
 #  84  
 #  85           DO IP=1,N-1
	beq $2,$0,.L.1.145.temp       	# [3]  
	ld $11,1960($sp)              	# [0]  .gra_spill_b037
.L.1.147.temp: 	 # 0x6cc
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:106 frequency = 22.64804 (heuristic)
 #<freq> BB:106 => BB:329 probability = 0.50000
 #<freq> BB:106 => BB:108 probability = 0.50000
 #<freq>
	ld $12,2128($sp)              	# [1]  .gra_spill_b058
	ld $13,1856($sp)              	# [2]  .gra_spill_b024
	andi $3,$12,1                 	# [3]  
	ld $6,1888($sp)               	# [4]  .gra_spill_b028
	addu $13,$13,$11              	# [4]  
	ld $7,1864($sp)               	# [5]  .gra_spill_b025
	beq $3,$0,.BB329.jacobi_      	# [5]  
	addiu $11,$11,8               	# [5]  
.L.1.148.temp: 	 # 0x6ec
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:108 frequency = 11.32402 (heuristic)
 #<freq>
	.loc	1 142 13
 # 138           ENDDO
 # 139  
 # 140           DO IP=1,N
 # 141              B(IP)=B(IP)+Z(IP)
 # 142              D(IP)=B(IP)
	pref 1,248($11)               	# [0]  
	pref 1,248($6)                	# [1]  
	.loc	1 141 13
	ldc1 $f1,-8($6)               	# [2]  
	.loc	1 143 13
 # 143              Z(IP)=0.d0
	pref 1,248($7)                	# [3]  
	.loc	1 141 13
	ldc1 $f0,-8($7)               	# [4]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [13]  
	.loc	1 143 13
	sdc1 $f2,-8($7)               	# [15]  
	.loc	1 141 13
	add.d $f0,$f0,$f1             	# [15]  
	.loc	1 140 10
	addiu $6,$6,8                 	# [16]  
	.loc	1 142 13
	sdc1 $f0,-8($11)              	# [16]  
	.loc	1 140 10
	addiu $11,$11,8               	# [17]  
	addiu $7,$7,8                 	# [17]  
	.loc	1 141 13
	sdc1 $f0,-16($6)              	# [17]  
.BB329.jacobi_: 	 # 0x720
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:329 frequency = 22.64804 (heuristic)
 #<freq> BB:329 => BB:327 probability = 0.02000
 #<freq> BB:329 => BB:332 probability = 0.98000
 #<freq>
	sra $10,$12,1                 	# [0]  
	or $9,$6,$0                   	# [1]  
	or $5,$7,$0                   	# [1]  
	beq $10,$0,.BB327.jacobi_     	# [2]  
	or $8,$11,$0                  	# [2]  
.BB332.jacobi_: 	 # 0x734
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:332 frequency = 22.19507 (heuristic)
 #<freq> BB:332 => BB:338 probability = 0.00000
 #<freq> BB:332 => BB:337 probability = 1.00000
 #<freq>
	slti $1,$10,3                 	# [0]  
	bne $1,$0,.BB338.jacobi_      	# [2]  
	or $6,$9,$0                   	# [0]  
.BB337.jacobi_: 	 # 0x740
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:337 frequency = 22.19507 (heuristic)
 #<freq>
	.loc	1 142 13
	pref 1,248($8)                	# [0]  
	.loc	1 143 13
	pref 1,248($5)                	# [1]  
	.loc	1 141 13
	ldc1 $f0,-8($5)               	# [2]  
	.loc	1 142 13
	pref 1,248($9)                	# [3]  
	.loc	1 141 13
	ldc1 $f3,0($9)                	# [4]  
	ldc1 $f1,-8($9)               	# [5]  
	ldc1 $f2,0($5)                	# [6]  
	ldc1 $f10,%gp_rel(.lit8-30720)($gp)	# [10]  
	.loc	1 143 13
	sdc1 $f10,0($5)               	# [12]  
	.loc	1 140 10
	addiu $10,$9,16               	# [13]  
	.loc	1 143 13
	sdc1 $f10,-8($5)              	# [13]  
	.loc	1 140 10
	addiu $7,$5,16                	# [14]  
	.loc	1 141 13
	ldc1 $f5,-8($10)              	# [14]  
	ldc1 $f6,-8($7)               	# [15]  
	.loc	1 140 10
	addiu $3,$8,16                	# [16]  
	addiu $1,$13,-32              	# [16]  
	.loc	1 141 13
	ldc1 $f8,0($10)               	# [16]  
	add.d $f0,$f0,$f1             	# [16]  
	.loc	1 140 10
	addiu $6,$7,16                	# [17]  
	addiu $5,$10,16               	# [17]  
	.loc	1 141 13
	ldc1 $f7,0($7)                	# [17]  
	add.d $f2,$f2,$f3             	# [17]  
	nop                           	# [17]  
	nop                           	# [17]  
.BB334.jacobi_: 	 # 0x7a0
 #<loop> Loop body line 85, nesting depth: 2, estimated iterations: 16
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 85 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>    13 cycles per 2 iterations
 #<swps>     2 flops        (  7% of peak) (madds count as 2)
 #<swps>     2 flops        (  7% of peak) (madds count as 1)
 #<swps>     0 madds        (  0% of peak)
 #<swps>    10 mem refs     ( 76% of peak)
 #<swps>     4 integer ops  ( 15% of peak)
 #<swps>    16 instructions ( 30% of peak)
 #<swps>     2 short trip threshold
 #<swps>    10 integer registers used.
 #<swps>    13 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 85 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:334 frequency = 384.86560 (heuristic)
 #<freq> BB:334 => BB:343 probability = 0.01922
 #<freq> BB:334 => BB:335 probability = 0.98078
 #<freq>
	sdc1 $f0,-8($9)               	# [0]  
	.loc	1 142 13
	sdc1 $f0,-8($8)               	# [1]  
	.loc	1 143 13
	sdc1 $f10,-8($7)              	# [2]  
	.loc	1 141 13
	sdc1 $f2,0($9)                	# [3]  
	.loc	1 142 13
	sdc1 $f2,0($8)                	# [4]  
	.loc	1 143 13
	sdc1 $f10,0($7)               	# [5]  
	.loc	1 141 13
	ldc1 $f9,0($6)                	# [7]  
	ldc1 $f1,0($5)                	# [9]  
	.loc	1 140 10
	addiu $4,$3,16                	# [10]  
	.loc	1 141 13
	add.d $f2,$f7,$f8             	# [11]  
	.loc	1 140 10
	addiu $2,$6,16                	# [11]  
	.loc	1 141 13
	ldc1 $f7,-8($6)               	# [11]  
	add.d $f0,$f6,$f5             	# [12]  
	.loc	1 140 10
	addiu $9,$5,16                	# [12]  
	beq $3,$1,.BB343.jacobi_      	# [12]  
	.loc	1 141 13
	ldc1 $f5,-8($5)               	# [12]  
.BB335.jacobi_: 	 # 0x7e0
 #<loop> Part of loop body line 85, head labeled .BB334.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 85 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:335 frequency = 377.46725 (heuristic)
 #<freq> BB:335 => BB:342 probability = 0.01960
 #<freq> BB:335 => BB:336 probability = 0.98040
 #<freq>
	sdc1 $f0,-8($10)              	# [0]  
	.loc	1 142 13
	sdc1 $f0,-8($3)               	# [1]  
	.loc	1 143 13
	sdc1 $f10,-8($6)              	# [2]  
	.loc	1 141 13
	sdc1 $f2,0($10)               	# [3]  
	.loc	1 142 13
	sdc1 $f2,0($3)                	# [4]  
	.loc	1 143 13
	sdc1 $f10,0($6)               	# [5]  
	.loc	1 141 13
	ldc1 $f4,0($2)                	# [7]  
	ldc1 $f3,0($9)                	# [9]  
	.loc	1 142 13
	pref 1,248($4)                	# [10]  
	.loc	1 140 10
	addiu $8,$4,16                	# [10]  
	.loc	1 141 13
	add.d $f2,$f9,$f1             	# [11]  
	.loc	1 140 10
	addiu $7,$2,16                	# [11]  
	.loc	1 141 13
	ldc1 $f1,-8($2)               	# [11]  
	add.d $f0,$f7,$f5             	# [12]  
	.loc	1 140 10
	addiu $10,$9,16               	# [12]  
	beq $4,$1,.BB342.jacobi_      	# [12]  
	.loc	1 141 13
	ldc1 $f5,-8($9)               	# [12]  
.BB336.jacobi_: 	 # 0x824
 #<loop> Part of loop body line 85, head labeled .BB334.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 85 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:336 frequency = 370.06888 (heuristic)
 #<freq> BB:336 => BB:334 probability = 0.98001
 #<freq> BB:336 => BB:341 probability = 0.01999
 #<freq>
	sdc1 $f0,-8($5)               	# [0]  
	.loc	1 142 13
	sdc1 $f0,-8($4)               	# [1]  
	.loc	1 143 13
	sdc1 $f10,-8($2)              	# [2]  
	.loc	1 141 13
	sdc1 $f2,0($5)                	# [3]  
	.loc	1 142 13
	sdc1 $f2,0($4)                	# [4]  
	.loc	1 143 13
	sdc1 $f10,0($2)               	# [5]  
	pref 1,248($7)                	# [6]  
	.loc	1 141 13
	ldc1 $f7,0($7)                	# [7]  
	.loc	1 142 13
	pref 1,248($10)               	# [8]  
	.loc	1 141 13
	ldc1 $f8,0($10)               	# [9]  
	.loc	1 140 10
	addiu $3,$8,16                	# [10]  
	.loc	1 141 13
	add.d $f2,$f4,$f3             	# [11]  
	.loc	1 140 10
	addiu $6,$7,16                	# [11]  
	.loc	1 141 13
	ldc1 $f6,-8($7)               	# [11]  
	add.d $f0,$f1,$f5             	# [12]  
	.loc	1 140 10
	addiu $5,$10,16               	# [12]  
	bne $8,$1,.BB334.jacobi_      	# [12]  
	.loc	1 141 13
	ldc1 $f5,-8($10)              	# [12]  
.BB341.jacobi_: 	 # 0x86c
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:341 frequency = 7.39836 (heuristic)
 #<freq>
	mov.d $f13,$f2                	# [0]  
	mov.d $f12,$f8                	# [1]  
	or $12,$3,$0                  	# [2]  
	or $13,$8,$0                  	# [2]  
	mov.d $f9,$f7                 	# [2]  
	or $14,$7,$0                  	# [3]  
	mov.d $f11,$f0                	# [3]  
	or $2,$10,$0                  	# [3]  
	mov.d $f10,$f6                	# [4]  
	or $10,$9,$0                  	# [4]  
	or $9,$2,$0                   	# [4]  
.BB340.jacobi_: 	 # 0x898
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:340 frequency = 22.19507 (heuristic)
 #<freq>
	ldc1 $f0,%gp_rel(.lit8-30720)($gp)	# [0]  
	sdc1 $f11,-8($10)             	# [1]  
	.loc	1 142 13
	sdc1 $f11,-8($13)             	# [2]  
	.loc	1 143 13
	sdc1 $f0,-8($14)              	# [3]  
	.loc	1 141 13
	sdc1 $f13,0($10)              	# [4]  
	.loc	1 142 13
	sdc1 $f13,0($13)              	# [5]  
	.loc	1 141 13
	add.d $f31,$f10,$f5           	# [6]  
	.loc	1 143 13
	sdc1 $f0,0($14)               	# [6]  
	.loc	1 141 13
	sdc1 $f31,-8($9)              	# [7]  
	add.d $f2,$f9,$f12            	# [8]  
	.loc	1 142 13
	sdc1 $f31,-8($12)             	# [8]  
	.loc	1 141 13
	sdc1 $f2,0($9)                	# [9]  
	.loc	1 142 13
	sdc1 $f2,0($12)               	# [10]  
.BB327.jacobi_: 	 # 0x8cc
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:327 frequency = 22.64804 (heuristic)
 #<freq>
.L.1.145.temp: 	 # 0x8cc
.L.1.144.temp: 	 # 0x8cc
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:110 frequency = 24.40555 (heuristic)
 #<freq> BB:110 => BB:111 probability = 0.02000
 #<freq> BB:110 => BB:25 probability = 0.98000
 #<freq>
	.loc	1 66 7
	ld $3,1928($sp)               	# [0]  .gra_spill_b033
	addiu $4,$0,51                	# [2]  
	addiu $3,$3,1                 	# [2]  
	beq $3,$4,.L.1.150.temp       	# [4]  
	sd $3,1928($sp)               	# [4]  .gra_spill_b033
.L.1.57.temp: 	 # 0x8e0
 #<loop> Loop body line 66, nesting depth: 1, estimated iterations: 50
 #<sched> 
 #<sched> Loop schedule length: 110 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     9 flops        (  4% of peak) (madds count as 2)
 #<sched>     9 flops        (  4% of peak) (madds count as 1)
 #<sched>     0 madds        (  0% of peak)
 #<sched>    61 mem refs     ( 55% of peak)
 #<sched>    44 integer ops  ( 20% of peak)
 #<sched>   118 instructions ( 26% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:25 frequency = 24.91744 (heuristic)
 #<freq> BB:25 => BB:34 probability = 0.05970
 #<freq> BB:25 => BB:26 probability = 0.94030
 #<freq>
	.loc	1 68 10
	ld $1,1912($sp)               	# [0]  .gra_spill_b031
	beq $1,$0,.L.1.59.temp        	# [3]  
	ldc1 $f12,%gp_rel(.lit8-30720)($gp)	# [3]  
.BB26.jacobi_: 	 # 0x8ec
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:26 frequency = 23.42983 (heuristic)
 #<freq>
	.loc	1 69 10
	ld $10,2136($sp)              	# [0]  .gra_spill_b059
	ld $8,1880($sp)               	# [1]  .gra_spill_b027
	addiu $12,$0,1                	# [2]  
	addiu $13,$0,2                	# [2]  
	addu $8,$8,$10                	# [3]  
	b .L.1.62.temp                	# [3]  
	ld $10,2224($sp)              	# [3]  .gra_spill_b070
	nop                           	# [3]  
	nop                           	# [3]  
.BB190.jacobi_: 	 # 0x910
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:190 frequency = 749.75464 (heuristic)
 #<freq>
	mov.d $f13,$f7                	# [0]  
	mov.d $f16,$f2                	# [1]  
	mov.d $f15,$f0                	# [2]  
	mov.d $f14,$f10               	# [3]  
	mov.d $f9,$f11                	# [4]  
	mov.d $f3,$f1                 	# [5]  
	mov.d $f6,$f8                 	# [6]  
	mov.d $f4,$f5                 	# [7]  
	mov.d $f11,$f6                	# [8]  
	mov.d $f8,$f4                 	# [9]  
	mov.d $f10,$f3                	# [10]  
.BB187.jacobi_: 	 # 0x93c
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:187 frequency = 2249.26392 (heuristic)
 #<freq>
	.loc	1 71 16
	add.d $f31,$f16,$f15          	# [0]  
	abs.d $f12,$f8                	# [1]  
	abs.d $f2,$f10                	# [2]  
	add.d $f12,$f12,$f31          	# [3]  
	abs.d $f1,$f9                 	# [4]  
	add.d $f2,$f2,$f12            	# [5]  
	abs.d $f0,$f14                	# [6]  
	add.d $f1,$f1,$f2             	# [7]  
	abs.d $f31,$f11               	# [8]  
	add.d $f0,$f0,$f1             	# [9]  
	abs.d $f12,$f13               	# [10]  
	add.d $f31,$f31,$f0           	# [11]  
	add.d $f12,$f12,$f31          	# [13]  
.BB174.jacobi_: 	 # 0x970
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<freq>
 #<freq> BB:174 frequency = 2342.98340 (heuristic)
 #<freq> BB:174 => BB:34 probability = 0.01000
 #<freq> BB:174 => BB:29 probability = 0.99000
 #<freq>
	.loc	1 69 10
	ld $3,1976($sp)               	# [0]  .gra_spill_b039
	ld $1,1968($sp)               	# [1]  .gra_spill_b038
	ld $2,2224($sp)               	# [2]  .gra_spill_b070
	addu $8,$3,$8                 	# [3]  
	beq $12,$1,.L.1.59.temp       	# [4]  
	addu $10,$2,$10               	# [4]  
.L.1.62.temp: 	 # 0x988
.L.1.64.temp: 	 # 0x988
 #<loop> Loop body line 69, nesting depth: 2, estimated iterations: 100
 #<sched> 
 #<sched> Loop schedule length: 50 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    25 flops        ( 25% of peak) (madds count as 2)
 #<sched>    25 flops        ( 25% of peak) (madds count as 1)
 #<sched>     0 madds        (  0% of peak)
 #<sched>    13 mem refs     ( 26% of peak)
 #<sched>    20 integer ops  ( 20% of peak)
 #<sched>    58 instructions ( 29% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:29 frequency = 2342.98340 (heuristic)
 #<freq> BB:29 => BB:176 probability = 0.25000
 #<freq> BB:29 => BB:31 probability = 0.75000
 #<freq>
	or $14,$12,$0                 	# [0]  
	ld $1,2136($sp)               	# [1]  .gra_spill_b059
	andi $6,$12,3                 	# [1]  
	addu $15,$13,$10              	# [1]  
	or $5,$8,$0                   	# [2]  
	sll $15,$15,3                 	# [2]  
	beq $6,$0,.BB176.jacobi_      	# [3]  
	addu $15,$15,$1               	# [3]  
.L.1.65.temp: 	 # 0x9a8
 #<loop> Loop body line 69, nesting depth: 3, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 3 iterations)
 #<sched> 
 #<sched> Loop schedule length: 15 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     2 flops        (  6% of peak) (madds count as 2)
 #<sched>     2 flops        (  6% of peak) (madds count as 1)
 #<sched>     0 madds        (  0% of peak)
 #<sched>     2 mem refs     ( 13% of peak)
 #<sched>     3 integer ops  ( 10% of peak)
 #<sched>     7 instructions ( 11% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:31 frequency = 3514.47510 (heuristic)
 #<freq> BB:31 => BB:31 probability = 0.50000
 #<freq> BB:31 => BB:176 probability = 0.50000
 #<freq>
	.loc	1 71 16
	pref 0,248($5)                	# [0]  
	ldc1 $f0,-8($5)               	# [1]  
	addi $6,$6,-1                 	# [12]  
	abs.d $f0,$f0                 	# [12]  
	.loc	1 70 13
	addiu $5,$5,8                 	# [14]  
	bne $6,$0,.L.1.65.temp        	# [14]  
	.loc	1 71 16
	add.d $f12,$f0,$f12           	# [14]  
.BB176.jacobi_: 	 # 0x9c4
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<freq>
 #<freq> BB:176 frequency = 2342.98340 (heuristic)
 #<freq> BB:176 => BB:174 probability = 0.04000
 #<freq> BB:176 => BB:179 probability = 0.96000
 #<freq>
	.loc	1 69 10
	addiu $12,$12,1               	# [0]  
	sra $6,$14,2                  	# [0]  
	addiu $13,$13,1               	# [1]  
	or $24,$5,$0                  	# [1]  
	mov.d $f5,$f12                	# [2]  
	beq $6,$0,.BB174.jacobi_      	# [2]  
	slti $1,$6,3                  	# [2]  
.BB179.jacobi_: 	 # 0x9e0
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:179 frequency = 2249.26392 (heuristic)
 #<freq> BB:179 => BB:185 probability = 0.00000
 #<freq> BB:179 => BB:184 probability = 1.00000
 #<freq>
	bne $1,$0,.BB185.jacobi_      	# [2]  
	mov.d $f3,$f5                 	# [0]  
.BB184.jacobi_: 	 # 0x9e8
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:184 frequency = 2249.26392 (heuristic)
 #<freq>
	.loc	1 71 16
	pref 0,248($24)               	# [0]  
	ldc1 $f0,-8($24)              	# [1]  
	ldc1 $f2,0($24)               	# [2]  
	.loc	1 70 13
	addiu $4,$24,32               	# [2]  
	.loc	1 71 16
	ldc1 $f3,8($4)                	# [3]  
	ldc1 $f10,16($24)             	# [10]  
	ldc1 $f11,8($24)              	# [11]  
	ldc1 $f1,16($4)               	# [12]  
	abs.d $f0,$f0                 	# [12]  
	addiu $1,$15,-64              	# [13]  
	ldc1 $f6,0($4)                	# [13]  
	abs.d $f2,$f2                 	# [13]  
	.loc	1 70 13
	addiu $3,$4,32                	# [14]  
	.loc	1 71 16
	ldc1 $f9,-8($4)               	# [14]  
	add.d $f0,$f0,$f5             	# [14]  
	mov.d $f5,$f3                 	# [14]  
	nop                           	# [14]  
	nop                           	# [14]  
.BB181.jacobi_: 	 # 0xa30
 #<loop> Loop body line 69, nesting depth: 3, estimated iterations: 8
 #<loop> Unrolled 4 times
 #<swps> 
 #<swps> Pipelined loop line 69 steady state
 #<swps> 
 #<swps>    25 estimated iterations before pipelining
 #<swps>     4 unrollings before pipelining
 #<swps>     8 cycles per 4 iterations
 #<swps>     8 flops        ( 50% of peak) (madds count as 2)
 #<swps>     8 flops        ( 50% of peak) (madds count as 1)
 #<swps>     0 madds        (  0% of peak)
 #<swps>     4 mem refs     ( 50% of peak)
 #<swps>     2 integer ops  ( 12% of peak)
 #<swps>    14 instructions ( 43% of peak)
 #<swps>     2 short trip threshold
 #<swps>     4 integer registers used.
 #<swps>    17 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 69 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:181 frequency = 20274.61719 (heuristic)
 #<freq> BB:181 => BB:190 probability = 0.03698
 #<freq> BB:181 => BB:182 probability = 0.96302
 #<freq>
	abs.d $f3,$f11                	# [0]  
	add.d $f0,$f2,$f0             	# [1]  
	ldc1 $f11,-8($3)              	# [1]  
	abs.d $f2,$f10                	# [2]  
	add.d $f0,$f3,$f0             	# [3]  
	ldc1 $f10,0($3)               	# [3]  
	abs.d $f7,$f9                 	# [4]  
	add.d $f0,$f2,$f0             	# [5]  
	.loc	1 70 13
	addiu $2,$3,32                	# [5]  
	.loc	1 71 16
	ldc1 $f8,8($3)                	# [5]  
	abs.d $f2,$f6                 	# [6]  
	add.d $f0,$f7,$f0             	# [7]  
	.loc	1 70 13
	beq $4,$1,.BB190.jacobi_      	# [7]  
	.loc	1 71 16
	ldc1 $f7,16($3)               	# [7]  
.BB182.jacobi_: 	 # 0xa68
 #<loop> Part of loop body line 69, head labeled .BB181.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 69 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:182 frequency = 19524.86133 (heuristic)
 #<freq> BB:182 => BB:189 probability = 0.03840
 #<freq> BB:182 => BB:183 probability = 0.96160
 #<freq>
	abs.d $f6,$f5                 	# [0]  
	add.d $f0,$f2,$f0             	# [1]  
	ldc1 $f4,-8($2)               	# [1]  
	abs.d $f2,$f1                 	# [2]  
	add.d $f0,$f6,$f0             	# [3]  
	ldc1 $f3,0($2)                	# [3]  
	abs.d $f1,$f11                	# [4]  
	add.d $f0,$f2,$f0             	# [5]  
	.loc	1 70 13
	addiu $4,$2,32                	# [5]  
	.loc	1 71 16
	ldc1 $f11,8($2)               	# [5]  
	abs.d $f2,$f10                	# [6]  
	add.d $f0,$f1,$f0             	# [7]  
	.loc	1 70 13
	beq $3,$1,.BB189.jacobi_      	# [7]  
	.loc	1 71 16
	ldc1 $f10,16($2)              	# [7]  
.BB183.jacobi_: 	 # 0xaa0
 #<loop> Part of loop body line 69, head labeled .BB181.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 69 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:183 frequency = 18775.10742 (heuristic)
 #<freq> BB:183 => BB:181 probability = 0.96007
 #<freq> BB:183 => BB:188 probability = 0.03993
 #<freq>
	pref 0,248($4)                	# [0]  
	abs.d $f1,$f8                 	# [0]  
	add.d $f0,$f2,$f0             	# [1]  
	ldc1 $f9,-8($4)               	# [1]  
	abs.d $f2,$f7                 	# [2]  
	add.d $f1,$f1,$f0             	# [3]  
	ldc1 $f6,0($4)                	# [3]  
	abs.d $f0,$f4                 	# [4]  
	add.d $f1,$f2,$f1             	# [5]  
	.loc	1 70 13
	addiu $3,$4,32                	# [5]  
	.loc	1 71 16
	ldc1 $f5,8($4)                	# [5]  
	abs.d $f2,$f3                 	# [6]  
	add.d $f0,$f0,$f1             	# [7]  
	.loc	1 70 13
	bne $2,$1,.BB181.jacobi_      	# [7]  
	.loc	1 71 16
	ldc1 $f1,16($4)               	# [7]  
.BB188.jacobi_: 	 # 0xadc
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:188 frequency = 749.75464 (heuristic)
 #<freq>
	mov.d $f13,$f1                	# [0]  
	mov.d $f16,$f2                	# [1]  
	mov.d $f14,$f6                	# [2]  
	mov.d $f15,$f0                	# [3]  
	mov.d $f3,$f5                 	# [4]  
	mov.d $f8,$f11                	# [5]  
	b .BB187.jacobi_              	# [6]  
	mov.d $f11,$f3                	# [6]  
.BB189.jacobi_: 	 # 0xafc
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<swp> 
 #<swp> Pipelined loop line 69 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:189 frequency = 749.75464 (heuristic)
 #<freq>
	mov.d $f13,$f10               	# [0]  
	mov.d $f10,$f7                	# [1]  
	mov.d $f16,$f2                	# [2]  
	mov.d $f14,$f3                	# [3]  
	mov.d $f15,$f0                	# [4]  
	b .BB187.jacobi_              	# [5]  
	mov.d $f9,$f4                 	# [5]  
.L.1.59.temp: 	 # 0xb18
.L.1.58.temp: 	 # 0xb18
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:34 frequency = 24.91744 (heuristic)
 #<freq> BB:34 => BB:35 probability = 0.02000
 #<freq> BB:34 => BB:36 probability = 0.98000
 #<freq>
	ldc1 $f31,%gp_rel(.lit8-30720)($gp)	# [0]  
	.loc	1 69 10
	c.eq.d $fcc0,$f12,$f31        	# [3]  
	bc1t $fcc0,.BB35.jacobi_      	# [6]  
	ld $2,1928($sp)               	# [0]  .gra_spill_b033
.L.1.69.temp: 	 # 0xb28
.L.1.68.temp: 	 # 0xb28
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:36 frequency = 24.41909 (heuristic)
 #<freq> BB:36 => BB:38 probability = 0.50000
 #<freq> BB:36 => BB:37 probability = 0.50000
 #<freq>
	.loc	1 76 24
	slti $2,$2,4                  	# [2]  
	beq $2,$0,.L.1.71.temp        	# [4]  
	.loc	1 80 13
	ldc1 $f0,1720($sp)            	# [0]  .gra_spill_b007
.BB37.jacobi_: 	 # 0xb34
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:37 frequency = 12.20955 (heuristic)
 #<freq>
	div.d $f0,$f12,$f0            	# [3]  
	ldc1 $f1,%gp_rel(.lit8-30704)($gp)	# [17]  
	mul.d $f0,$f0,$f1             	# [20]  
	b .L.1.70.temp                	# [21]  
	sdc1 $f0,1728($sp)            	# [21]  .gra_spill_b008
.L.1.71.temp: 	 # 0xb48
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:38 frequency = 12.20955 (heuristic)
 #<freq>
	ldc1 $f1,%gp_rel(.lit8-30720)($gp)	# [0]  
	sdc1 $f1,1728($sp)            	# [2]  .gra_spill_b008
.L.1.70.temp: 	 # 0xb50
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:39 frequency = 24.41909 (heuristic)
 #<freq> BB:39 => BB:105 probability = 0.05970
 #<freq> BB:39 => BB:40 probability = 0.94030
 #<freq>
	ld $3,1904($sp)               	# [0]  .gra_spill_b030
	.loc	1 82 13
	beq $3,$0,.-1168              	# [3]  .L.1.73.temp+4
	ld $2,1920($sp)               	# [0]  .gra_spill_b032
.BB40.jacobi_: 	 # 0xb5c
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:40 frequency = 22.96124 (heuristic)
 #<freq>
	sd $0,2064($sp)               	# [0]  .gra_spill_b050
	.loc	1 85 10
	addiu $3,$0,8                 	# [1]  
	sd $3,2072($sp)               	# [1]  .gra_spill_b051
	addiu $3,$0,1                 	# [2]  
	sd $3,2040($sp)               	# [2]  .gra_spill_b047
	addiu $3,$0,2                 	# [3]  
	sd $3,2112($sp)               	# [3]  .gra_spill_b056
	ld $2,2224($sp)               	# [4]  .gra_spill_b070
	sd $2,2008($sp)               	# [5]  .gra_spill_b043
	addiu $2,$0,1                 	# [6]  
	sd $2,2000($sp)               	# [6]  .gra_spill_b042
	addiu $4,$0,8                 	# [7]  
	sd $4,2080($sp)               	# [7]  .gra_spill_b052
	ld $4,1896($sp)               	# [8]  .gra_spill_b029
	sd $4,2088($sp)               	# [9]  .gra_spill_b053
	ld $4,1872($sp)               	# [10]  .gra_spill_b026
	ld $1,1960($sp)               	# [11]  .gra_spill_b037
	sd $4,1984($sp)               	# [12]  .gra_spill_b040
	addiu $1,$1,8                 	# [13]  
	sd $1,2144($sp)               	# [13]  .gra_spill_b060
	addiu $1,$0,16                	# [14]  
	sd $1,2016($sp)               	# [14]  .gra_spill_b044
	ld $1,1928($sp)               	# [15]  .gra_spill_b033
	addiu $2,$0,1                 	# [16]  
	sd $2,1992($sp)               	# [16]  .gra_spill_b041
	addiu $4,$0,4                 	# [16]  
	slt $4,$4,$1                  	# [17]  
	b .L.1.76.temp                	# [17]  
	sd $4,2184($sp)               	# [17]  .gra_spill_b065
.L.1.142.temp: 	 # 0xbd0
.L.1.77.temp: 	 # 0xbd0
 #<loop> Part of loop body line 85, head labeled .L.1.76.temp
 #<freq>
 #<freq> BB:103 frequency = 2294.76978 (heuristic)
 #<freq> BB:103 => BB:105 probability = 0.01000
 #<freq> BB:103 => BB:43 probability = 0.99000
 #<freq>
	ld $3,2008($sp)               	# [0]  .gra_spill_b043
	ld $4,2224($sp)               	# [1]  .gra_spill_b070
	addu $3,$4,$3                 	# [3]  
	ld $4,1984($sp)               	# [3]  .gra_spill_b040
	sd $3,2008($sp)               	# [4]  .gra_spill_b043
	ld $3,2088($sp)               	# [5]  .gra_spill_b053
	addiu $4,$4,-1                	# [6]  
	sd $4,1984($sp)               	# [6]  .gra_spill_b040
	ld $4,1936($sp)               	# [7]  .gra_spill_b034
	addiu $3,$3,8                 	# [8]  
	sd $3,2088($sp)               	# [8]  .gra_spill_b053
	ld $3,2072($sp)               	# [9]  .gra_spill_b051
	addu $3,$3,$4                 	# [11]  
	sd $3,2072($sp)               	# [11]  .gra_spill_b051
	ld $2,2040($sp)               	# [12]  .gra_spill_b047
	ld $3,1992($sp)               	# [13]  .gra_spill_b041
	addiu $2,$2,1                 	# [14]  
	sd $2,2040($sp)               	# [14]  .gra_spill_b047
	ld $1,2000($sp)               	# [15]  .gra_spill_b042
	ld $2,2144($sp)               	# [16]  .gra_spill_b060
	addiu $1,$1,1                 	# [17]  
	sd $1,2000($sp)               	# [17]  .gra_spill_b042
	ld $1,2112($sp)               	# [18]  .gra_spill_b056
	addiu $2,$2,8                 	# [19]  
	sd $2,2144($sp)               	# [19]  .gra_spill_b060
	addiu $1,$1,1                 	# [20]  
	sd $1,2112($sp)               	# [20]  .gra_spill_b056
	ld $1,2064($sp)               	# [21]  .gra_spill_b050
	ld $2,1944($sp)               	# [22]  .gra_spill_b035
	addiu $1,$1,1                 	# [23]  
	sd $1,2064($sp)               	# [23]  .gra_spill_b050
	ld $4,2080($sp)               	# [24]  .gra_spill_b052
	ld $1,2016($sp)               	# [25]  .gra_spill_b044
	addu $4,$4,$2                 	# [26]  
	ld $2,1952($sp)               	# [26]  .gra_spill_b036
	addiu $1,$1,8                 	# [27]  
	sd $1,2016($sp)               	# [27]  .gra_spill_b044
	sd $4,2080($sp)               	# [28]  .gra_spill_b052
	addiu $3,$3,1                 	# [29]  
	beq $1,$2,.L.1.73.temp        	# [29]  
	sd $3,1992($sp)               	# [29]  .gra_spill_b041
.L.1.76.temp: 	 # 0xc74
 #<loop> Loop body line 85, nesting depth: 2, estimated iterations: 100
 #<sched> 
 #<sched> Loop schedule length: 53 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    49 mem refs     ( 92% of peak)
 #<sched>    46 integer ops  ( 43% of peak)
 #<sched>    95 instructions ( 44% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:43 frequency = 2294.78320 (heuristic)
 #<freq>
	.loc	1 86 13
	ld $2,1992($sp)               	# [0]  .gra_spill_b041
	ld $3,2112($sp)               	# [1]  .gra_spill_b056
	ld $22,2000($sp)              	# [2]  .gra_spill_b042
	ld $30,2224($sp)              	# [3]  .gra_spill_b070
	ld $21,1960($sp)              	# [4]  .gra_spill_b037
	subu $1,$3,$2                 	# [5]  
	multu $30,$22                 	# [5]  
	ld $22,2016($sp)              	# [5]  .gra_spill_b044
	addiu $1,$1,-1                	# [6]  
	sd $1,2272($sp)               	# [6]  .gra_spill_b076
	addiu $23,$sp,0               	# [6]  Z
	addu $21,$22,$21              	# [7]  
	addu $22,$22,$23              	# [7]  
	ld $23,2128($sp)              	# [7]  .gra_spill_b058
	slti $1,$2,2                  	# [8]  
	ld $4,2008($sp)               	# [8]  .gra_spill_b043
	xori $1,$1,1                  	# [9]  
	subu $23,$23,$3               	# [9]  
	sd $23,2280($sp)              	# [9]  .gra_spill_b077
	or $20,$3,$0                  	# [10]  
	addu $4,$2,$4                 	# [10]  
	ld $23,2200($sp)              	# [10]  .gra_spill_b067
	sll $4,$4,3                   	# [11]  
	addiu $19,$3,-1               	# [11]  
	sd $19,2192($sp)              	# [11]  .gra_spill_b066
	sd $4,2032($sp)               	# [12]  .gra_spill_b046
	mflo $19                      	# [12]  
	nop                           	# [0]  
	nop                           	# [0]  
	multu $30,$3                  	# [12]  
	addiu $4,$3,0                 	# [13]  
	addu $23,$23,$19              	# [13]  
	sd $3,2248($sp)               	# [14]  .gra_spill_b073
	sll $23,$23,3                 	# [14]  
	addiu $30,$19,1               	# [14]  
	sll $30,$30,3                 	# [15]  
	addu $3,$3,$19                	# [15]  
	addu $4,$2,$19                	# [16]  
	sll $3,$3,3                   	# [16]  
	sd $3,2232($sp)               	# [16]  .gra_spill_b071
	sd $1,2056($sp)               	# [17]  .gra_spill_b049
	sll $4,$4,3                   	# [17]  
	addiu $3,$19,1                	# [17]  
	sll $3,$3,3                   	# [18]  
	sd $3,2288($sp)               	# [18]  .gra_spill_b078
	ld $1,2136($sp)               	# [19]  .gra_spill_b059
	addu $19,$2,$19               	# [19]  
	mflo $3                       	# [19]  
	sd $4,2296($sp)               	# [20]  .gra_spill_b079
	sll $19,$19,3                 	# [20]  
	addu $2,$2,$3                 	# [20]  
	sd $3,2240($sp)               	# [21]  .gra_spill_b072
	sll $2,$2,3                   	# [21]  
	addu $19,$19,$1               	# [22]  
	b .L.1.79.temp                	# [22]  
	sd $2,2216($sp)               	# [22]  .gra_spill_b069
	nop                           	# [22]  
	nop                           	# [22]  
	nop                           	# [22]  
.BB76.jacobi_: 	 # 0xd60
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:76 frequency = 156359.50000 (heuristic)
 #<freq>
	.loc	1 91 19
	sdc1 $f2,-8($19)              	# [2]  
.L.1.115.temp: 	 # 0xd64
.L.1.114.temp: 	 # 0xd64
.L.1.112.temp: 	 # 0xd64
.L.1.80.temp: 	 # 0xd64
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:102 frequency = 229476.96875 (heuristic)
 #<freq> BB:102 => BB:103 probability = 0.01000
 #<freq> BB:102 => BB:46 probability = 0.99000
 #<freq>
	.loc	1 86 13
	ld $1,2296($sp)               	# [0]  .gra_spill_b079
	ld $2,2168($sp)               	# [1]  .gra_spill_b063
	ld $4,2160($sp)               	# [2]  .gra_spill_b062
	ld $3,2288($sp)               	# [3]  .gra_spill_b078
	addu $19,$4,$19               	# [4]  
	ld $4,2152($sp)               	# [4]  .gra_spill_b061
	addu $3,$3,$2                 	# [5]  
	sd $3,2288($sp)               	# [5]  .gra_spill_b078
	ld $3,2232($sp)               	# [6]  .gra_spill_b071
	addu $1,$1,$2                 	# [7]  
	ld $2,2176($sp)               	# [7]  .gra_spill_b064
	addu $3,$3,$4                 	# [8]  
	sd $3,2232($sp)               	# [8]  .gra_spill_b071
	ld $3,2208($sp)               	# [9]  .gra_spill_b068
	addu $30,$30,$2               	# [10]  
	addu $23,$23,$2               	# [10]  
	ld $2,2216($sp)               	# [10]  .gra_spill_b069
	addu $2,$2,$3                 	# [12]  
	sd $2,2216($sp)               	# [12]  .gra_spill_b069
	sd $1,2296($sp)               	# [13]  .gra_spill_b079
	ld $1,2272($sp)               	# [14]  .gra_spill_b076
	ld $2,2280($sp)               	# [15]  .gra_spill_b077
	addiu $1,$1,1                 	# [16]  
	sd $1,2272($sp)               	# [16]  .gra_spill_b076
	ld $4,2192($sp)               	# [17]  .gra_spill_b066
	ld $1,2224($sp)               	# [18]  .gra_spill_b070
	addiu $4,$4,1                 	# [19]  
	sd $4,2192($sp)               	# [19]  .gra_spill_b066
	ld $4,2240($sp)               	# [20]  .gra_spill_b072
	ld $3,2248($sp)               	# [21]  .gra_spill_b073
	addu $4,$1,$4                 	# [22]  
	ld $1,2200($sp)               	# [22]  .gra_spill_b067
	addiu $22,$22,8               	# [23]  
	addiu $20,$20,1               	# [23]  
	sd $4,2240($sp)               	# [23]  .gra_spill_b072
	addiu $21,$21,8               	# [24]  
	addiu $3,$3,1                 	# [24]  
	sd $3,2248($sp)               	# [24]  .gra_spill_b073
	addiu $2,$2,-1                	# [25]  
	beq $20,$1,.L.1.142.temp      	# [25]  
	sd $2,2280($sp)               	# [25]  .gra_spill_b077
.L.1.79.temp: 	 # 0xe08
 #<loop> Loop body line 86, nesting depth: 3, estimated iterations: 100
 #<sched> 
 #<sched> Loop schedule length: 79 cycles (ignoring nested loops)
 #<sched> 
 #<sched>    18 flops        ( 11% of peak) (madds count as 2)
 #<sched>    12 flops        (  7% of peak) (madds count as 1)
 #<sched>     6 madds        (  7% of peak)
 #<sched>    47 mem refs     ( 59% of peak)
 #<sched>    27 integer ops  ( 17% of peak)
 #<sched>    93 instructions ( 29% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:46 frequency = 229476.96875 (heuristic)
 #<freq> BB:46 => BB:47 probability = 0.16000
 #<freq> BB:46 => BB:75 probability = 0.84000
 #<freq>
	.loc	1 109 19
	pref 1,1592($19)              	# [0]  
	.loc	1 108 19
	pref 1,248($21)               	# [1]  
	.loc	1 106 19
	pref 1,248($22)               	# [2]  
	.loc	1 109 19
	pref 1,1592($19)              	# [3]  
	ldc1 $f5,-8($19)              	# [4]  
	ldc1 $f20,%gp_rel(.lit8-30688)($gp)	# [12]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [13]  
	ldc1 $f31,1728($sp)           	# [14]  .gra_spill_b008
	andi $1,$20,31                	# [15]  
	.loc	1 88 16
	ld $4,2184($sp)               	# [15]  .gra_spill_b065
	.loc	1 109 19
	abs.d $f4,$f5                 	# [15]  
	.loc	1 88 16
	addiu $3,$0,1                 	# [16]  
	ldc1 $f1,%gp_rel(.lit8-30720)($gp)	# [16]  
	sltu $4,$0,$4                 	# [17]  
	.loc	1 91 19
	c.lt.d $fcc2,$f31,$f4         	# [17]  
	.loc	1 109 19
	beq $1,$17,.BB47.jacobi_      	# [17]  
	mul.d $f3,$f4,$f22            	# [17]  
.L.1.81.temp: 	 # 0xe4c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:75 frequency = 192760.65625 (heuristic)
 #<freq> BB:75 => BB:76 probability = 0.81116
 #<freq> BB:75 => BB:77 probability = 0.18884
 #<freq>
	.loc	1 88 16
	c.eq.d $fcc1,$f3,$f20         	# [0]  
	movf $3,$0,$fcc1              	# [2]  
	sltu $2,$0,$3                 	# [3]  
	sltu $3,$0,$3                 	# [4]  
	and $2,$2,$4                  	# [4]  
	and $2,$2,$3                  	# [5]  
	ldc1 $f31,%gp_rel(.lit8-30680)($gp)	# [7]  
	bne $2,$0,.BB76.jacobi_       	# [7]  
	mov.d $f6,$f3                 	# [7]  
.L.1.113.temp: 	 # 0xe70
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:77 frequency = 36401.15234 (heuristic)
 #<freq> BB:77 => BB:102 probability = 0.50000
 #<freq> BB:77 => BB:78 probability = 0.50000
 #<freq>
	.loc	1 109 19
	ld $12,2288($sp)              	# [0]  .gra_spill_b078
	ld $14,2064($sp)              	# [1]  .gra_spill_b050
	.loc	1 93 19
	ld $1,2144($sp)               	# [2]  .gra_spill_b060
	c.eq.d $fcc3,$f6,$f20         	# [3]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [3]  
	.loc	1 91 19
	bc1f $fcc2,.L.1.115.temp      	# [3]  
	andi $4,$14,1                 	# [3]  
.BB78.jacobi_: 	 # 0xe8c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:78 frequency = 18200.57617 (heuristic)
 #<freq> BB:78 => BB:80 probability = 0.50000
 #<freq> BB:78 => BB:79 probability = 0.50000
 #<freq>
	.loc	1 93 19
	ldc1 $f4,-8($21)              	# [0]  
	ldc1 $f7,-8($1)               	# [1]  
	.loc	1 105 19
	ld $2,2088($sp)               	# [2]  .gra_spill_b053
	.loc	1 107 19
	ld $3,2144($sp)               	# [3]  .gra_spill_b060
	.loc	1 109 19
	ld $1,2056($sp)               	# [4]  .gra_spill_b049
	.loc	1 93 19
	bc1f $fcc3,.L.1.117.temp      	# [4]  
	sub.d $f4,$f4,$f7             	# [4]  
.BB79.jacobi_: 	 # 0xea8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:79 frequency = 9100.28809 (heuristic)
 #<freq>
	.loc	1 95 22
	b .L.1.119.temp               	# [0]  
	div.d $f3,$f5,$f4             	# [0]  
.BB47.jacobi_: 	 # 0xeb0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:47 frequency = 36716.31641 (heuristic)
 #<freq> BB:47 => BB:49 probability = 0.18884
 #<freq> BB:47 => BB:48 probability = 0.81116
 #<freq>
	ldc1 $f20,%gp_rel(.lit8-30688)($gp)	# [0]  
	.loc	1 88 16
	c.eq.d $fcc0,$f3,$f20         	# [3]  
	ld $4,2184($sp)               	# [4]  .gra_spill_b065
	addiu $3,$0,1                 	# [4]  
	movf $3,$0,$fcc0              	# [5]  
	sltu $4,$0,$4                 	# [6]  
	sltu $2,$0,$3                 	# [6]  
	sltu $3,$0,$3                 	# [7]  
	and $2,$2,$4                  	# [7]  
	and $2,$2,$3                  	# [8]  
	ldc1 $f31,%gp_rel(.lit8-30720)($gp)	# [9]  
	ldc1 $f2,%gp_rel(.lit8-30712)($gp)	# [10]  
	beq $2,$0,.L.1.83.temp        	# [10]  
	mov.d $f6,$f3                 	# [10]  
.BB48.jacobi_: 	 # 0xee8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:48 frequency = 29782.76367 (heuristic)
 #<freq>
	.loc	1 91 19
	b .L.1.115.temp               	# [0]  
	sdc1 $f31,-8($19)             	# [0]  
.L.1.117.temp: 	 # 0xef0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:80 frequency = 9100.28809 (heuristic)
 #<freq>
	.loc	1 97 22
	div.d $f1,$f4,$f5             	# [0]  
	mul.d $f1,$f1,$f31            	# [17]  
	ldc1 $f3,%gp_rel(.lit8-30712)($gp)	# [18]  
	madd.d $f3,$f3,$f1,$f1        	# [19]  
	.loc	1 98 22
	sqrt.d $f3,$f3                	# [23]  
	abs.d $f0,$f1                 	# [51]  
	add.d $f0,$f0,$f3             	# [53]  
	recip.d $f0,$f0               	# [55]  
	c.lt.d $fcc1,$f1,$f2          	# [71]  
	.loc	1 99 39
	neg.d $f3,$f0                 	# [72]  
	movf.d $f3,$f0,$fcc1          	# [74]  
.L.1.119.temp: 	 # 0xf1c
.L.1.118.temp: 	 # 0xf1c
.L.1.116.temp: 	 # 0xf1c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:82 frequency = 18200.57617 (heuristic)
 #<freq> BB:82 => BB:87 probability = 0.07201
 #<freq> BB:82 => BB:83 probability = 0.92799
 #<freq>
	.loc	1 104 19
	mul.d $f1,$f5,$f3             	# [0]  
	.loc	1 105 19
	ldc1 $f0,-8($2)               	# [1]  
	.loc	1 107 19
	sub.d $f2,$f7,$f1             	# [2]  
	sdc1 $f2,-8($3)               	# [3]  
	.loc	1 108 19
	ldc1 $f2,-8($21)              	# [4]  
	.loc	1 105 19
	sub.d $f0,$f0,$f1             	# [4]  
	sdc1 $f0,-8($2)               	# [5]  
	.loc	1 106 19
	ldc1 $f0,-8($22)              	# [6]  
	ldc1 $f31,%gp_rel(.lit8-30720)($gp)	# [14]  
	ldc1 $f18,%gp_rel(.lit8-30712)($gp)	# [15]  
	.loc	1 109 19
	sdc1 $f31,-8($19)             	# [16]  
	.loc	1 108 19
	add.d $f2,$f2,$f1             	# [16]  
	sdc1 $f2,-8($21)              	# [17]  
	.loc	1 106 19
	add.d $f0,$f0,$f1             	# [17]  
	madd.d $f19,$f18,$f3,$f3      	# [18]  
	.loc	1 109 19
	beq $1,$0,.L.1.121.temp       	# [18]  
	.loc	1 106 19
	sdc1 $f0,-8($22)              	# [18]  
.L.1.123.temp: 	 # 0xf60
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:83 frequency = 16889.89648 (heuristic)
 #<freq> BB:83 => BB:259 probability = 0.50000
 #<freq> BB:83 => BB:85 probability = 0.50000
 #<freq>
	ldc1 $f18,%gp_rel(.lit8-30712)($gp)	# [0]  
	madd.d $f19,$f18,$f3,$f3      	# [1]  
	.loc	1 109 19
	sqrt.d $f19,$f19              	# [5]  
	recip.d $f19,$f19             	# [35]  
	add.d $f18,$f19,$f18          	# [52]  
	recip.d $f18,$f18             	# [54]  
	ld $13,2296($sp)              	# [66]  .gra_spill_b079
	ld $1,2136($sp)               	# [67]  .gra_spill_b059
	ld $10,2072($sp)              	# [68]  .gra_spill_b051
	sra $24,$14,1                 	# [69]  
	mul.d $f19,$f19,$f3           	# [69]  
	addu $10,$10,$1               	# [70]  
	addu $13,$13,$1               	# [70]  
	addu $12,$12,$1               	# [71]  
	beq $4,$0,.BB259.jacobi_      	# [71]  
	mul.d $f18,$f19,$f18          	# [71]  
.L.1.124.temp: 	 # 0xfa0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:85 frequency = 8444.94824 (heuristic)
 #<freq>
	.loc	1 113 22
	ldc1 $f0,-8($12)              	# [0]  
	.loc	1 111 22
	ldc1 $f31,-8($10)             	# [1]  
	.loc	1 114 22
	nmsub.d $f2,$f31,$f0,$f18     	# [3]  
	.loc	1 113 22
	madd.d $f1,$f0,$f31,$f18      	# [4]  
	.loc	1 114 22
	madd.d $f0,$f0,$f2,$f19       	# [7]  
	.loc	1 113 22
	nmsub.d $f31,$f31,$f1,$f19    	# [8]  
	.loc	1 110 19
	addiu $10,$10,8               	# [10]  
	.loc	1 114 22
	sdc1 $f0,-8($12)              	# [10]  
	.loc	1 110 19
	addiu $12,$12,8               	# [11]  
	.loc	1 113 22
	sdc1 $f31,-16($10)            	# [11]  
.BB259.jacobi_: 	 # 0xfc8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:259 frequency = 16889.89648 (heuristic)
 #<freq> BB:259 => BB:257 probability = 0.02000
 #<freq> BB:259 => BB:262 probability = 0.98000
 #<freq>
	or $5,$12,$0                  	# [0]  
	mov.d $f8,$f19                	# [0]  
	slti $1,$24,3                 	# [0]  
	mov.d $f7,$f18                	# [1]  
	beq $24,$0,.BB257.jacobi_     	# [1]  
	or $6,$10,$0                  	# [1]  
.BB262.jacobi_: 	 # 0xfe0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:262 frequency = 16552.09961 (heuristic)
 #<freq> BB:262 => BB:268 probability = 0.00000
 #<freq> BB:262 => BB:267 probability = 1.00000
 #<freq>
	bne $1,$0,.BB268.jacobi_      	# [0]  
	or $4,$6,$0                   	# [0]  
.BB267.jacobi_: 	 # 0xfe8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:267 frequency = 16552.09961 (heuristic)
 #<freq>
	ldc1 $f0,-8($5)               	# [0]  
	.loc	1 111 22
	ldc1 $f10,0($6)               	# [1]  
	ldc1 $f5,-8($6)               	# [2]  
	.loc	1 113 22
	ldc1 $f11,0($5)               	# [3]  
	.loc	1 114 22
	nmsub.d $f2,$f5,$f0,$f18      	# [3]  
	.loc	1 113 22
	madd.d $f1,$f11,$f10,$f18     	# [4]  
	madd.d $f6,$f0,$f5,$f18       	# [5]  
	.loc	1 114 22
	nmsub.d $f31,$f10,$f11,$f18   	# [6]  
	.loc	1 110 19
	addiu $7,$5,16                	# [7]  
	.loc	1 114 22
	madd.d $f0,$f0,$f2,$f19       	# [7]  
	.loc	1 110 19
	addiu $8,$6,16                	# [8]  
	.loc	1 113 22
	ldc1 $f4,-8($7)               	# [8]  
	nmsub.d $f10,$f10,$f1,$f19    	# [8]  
	addiu $1,$13,-32              	# [9]  
	.loc	1 110 19
	addiu $2,$8,16                	# [9]  
	.loc	1 113 22
	ldc1 $f9,0($7)                	# [9]  
	nmsub.d $f5,$f5,$f6,$f19      	# [9]  
	.loc	1 110 19
	addiu $3,$7,16                	# [10]  
	or $6,$8,$0                   	# [10]  
	.loc	1 111 22
	ldc1 $f6,0($8)                	# [10]  
	.loc	1 114 22
	madd.d $f11,$f11,$f31,$f19    	# [10]  
	nop                           	# [10]  
.BB264.jacobi_: 	 # 0x1040
 #<loop> Loop body line 109, nesting depth: 4, estimated iterations: 16
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 109 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>     8 cycles per 2 iterations
 #<swps>    16 flops        (100% of peak) (madds count as 2)
 #<swps>     8 flops        ( 50% of peak) (madds count as 1)
 #<swps>     8 madds        (100% of peak)
 #<swps>     8 mem refs     (100% of peak)
 #<swps>     3 integer ops  ( 18% of peak)
 #<swps>    19 instructions ( 59% of peak)
 #<swps>     2 short trip threshold
 #<swps>     7 integer registers used.
 #<swps>    13 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 109 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:264 frequency = 287015.65625 (heuristic)
 #<freq> BB:264 => BB:273 probability = 0.01922
 #<freq> BB:264 => BB:265 probability = 0.98078
 #<freq>
	nmsub.d $f12,$f6,$f9,$f7      	# [0]  
	.loc	1 111 22
	ldc1 $f3,-8($6)               	# [0]  
	.loc	1 113 22
	madd.d $f2,$f9,$f6,$f7        	# [1]  
	.loc	1 114 22
	sdc1 $f0,-8($5)               	# [1]  
	nmsub.d $f0,$f3,$f4,$f7       	# [2]  
	.loc	1 113 22
	sdc1 $f5,-8($4)               	# [2]  
	madd.d $f1,$f4,$f3,$f7        	# [3]  
	sdc1 $f10,0($4)               	# [3]  
	.loc	1 114 22
	sdc1 $f11,0($5)               	# [4]  
	madd.d $f11,$f9,$f12,$f8      	# [4]  
	.loc	1 113 22
	nmsub.d $f10,$f6,$f2,$f8      	# [5]  
	.loc	1 110 19
	addiu $5,$3,16                	# [5]  
	.loc	1 113 22
	ldc1 $f9,0($3)                	# [5]  
	.loc	1 114 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 111 22
	ldc1 $f6,0($2)                	# [6]  
	.loc	1 113 22
	nmsub.d $f5,$f3,$f1,$f8       	# [7]  
	.loc	1 110 19
	addiu $4,$2,16                	# [7]  
	beq $7,$1,.BB273.jacobi_      	# [7]  
	.loc	1 113 22
	ldc1 $f4,-8($3)               	# [7]  
.BB265.jacobi_: 	 # 0x108c
 #<loop> Part of loop body line 109, head labeled .BB264.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 109 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:265 frequency = 281498.28125 (heuristic)
 #<freq> BB:265 => BB:272 probability = 0.01960
 #<freq> BB:265 => BB:266 probability = 0.98040
 #<freq>
	.loc	1 114 22
	nmsub.d $f12,$f6,$f9,$f7      	# [0]  
	.loc	1 111 22
	ldc1 $f3,-8($2)               	# [0]  
	.loc	1 113 22
	madd.d $f2,$f9,$f6,$f7        	# [1]  
	.loc	1 114 22
	sdc1 $f0,-8($7)               	# [1]  
	nmsub.d $f0,$f3,$f4,$f7       	# [2]  
	.loc	1 113 22
	sdc1 $f5,-8($6)               	# [2]  
	madd.d $f1,$f4,$f3,$f7        	# [3]  
	sdc1 $f10,0($6)               	# [3]  
	.loc	1 114 22
	sdc1 $f11,0($7)               	# [4]  
	madd.d $f11,$f9,$f12,$f8      	# [4]  
	.loc	1 113 22
	nmsub.d $f10,$f6,$f2,$f8      	# [5]  
	.loc	1 110 19
	addiu $7,$5,16                	# [5]  
	.loc	1 113 22
	ldc1 $f9,0($5)                	# [5]  
	.loc	1 114 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 111 22
	ldc1 $f6,0($4)                	# [6]  
	.loc	1 113 22
	nmsub.d $f5,$f3,$f1,$f8       	# [7]  
	.loc	1 110 19
	addiu $6,$4,16                	# [7]  
	beq $3,$1,.BB272.jacobi_      	# [7]  
	.loc	1 113 22
	ldc1 $f4,-8($5)               	# [7]  
.BB266.jacobi_: 	 # 0x10d8
 #<loop> Part of loop body line 109, head labeled .BB264.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 109 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:266 frequency = 275980.90625 (heuristic)
 #<freq> BB:266 => BB:264 probability = 0.98001
 #<freq> BB:266 => BB:271 probability = 0.01999
 #<freq>
	.loc	1 114 22
	nmsub.d $f3,$f6,$f9,$f7       	# [0]  
	.loc	1 111 22
	ldc1 $f2,-8($4)               	# [0]  
	.loc	1 113 22
	madd.d $f1,$f9,$f6,$f7        	# [1]  
	.loc	1 114 22
	sdc1 $f0,-8($3)               	# [1]  
	nmsub.d $f0,$f2,$f4,$f7       	# [2]  
	.loc	1 113 22
	sdc1 $f5,-8($2)               	# [2]  
	madd.d $f5,$f4,$f2,$f7        	# [3]  
	sdc1 $f10,0($2)               	# [3]  
	.loc	1 114 22
	sdc1 $f11,0($3)               	# [4]  
	madd.d $f11,$f9,$f3,$f8       	# [4]  
	.loc	1 113 22
	nmsub.d $f10,$f6,$f1,$f8      	# [5]  
	.loc	1 110 19
	addiu $3,$7,16                	# [5]  
	.loc	1 113 22
	ldc1 $f9,0($7)                	# [5]  
	.loc	1 114 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 111 22
	ldc1 $f6,0($6)                	# [6]  
	.loc	1 113 22
	nmsub.d $f5,$f2,$f5,$f8       	# [7]  
	.loc	1 110 19
	addiu $2,$6,16                	# [7]  
	bne $5,$1,.BB264.jacobi_      	# [7]  
	.loc	1 113 22
	ldc1 $f4,-8($7)               	# [7]  
.BB271.jacobi_: 	 # 0x1124
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:271 frequency = 5517.36670 (heuristic)
 #<freq>
	or $10,$7,$0                  	# [0]  
	or $12,$5,$0                  	# [0]  
	or $13,$6,$0                  	# [1]  
	or $14,$4,$0                  	# [1]  
	mov.d $f7,$f0                 	# [1]  
.BB270.jacobi_: 	 # 0x1138
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:270 frequency = 16552.09961 (heuristic)
 #<freq>
	.loc	1 111 22
	ldc1 $f1,-8($13)              	# [0]  
	.loc	1 114 22
	nmsub.d $f2,$f1,$f4,$f18      	# [1]  
	.loc	1 113 22
	madd.d $f0,$f9,$f6,$f18       	# [2]  
	madd.d $f3,$f4,$f1,$f18       	# [3]  
	.loc	1 114 22
	nmsub.d $f31,$f6,$f9,$f18     	# [4]  
	sdc1 $f7,-8($12)              	# [4]  
	.loc	1 113 22
	sdc1 $f10,0($14)              	# [5]  
	.loc	1 114 22
	madd.d $f2,$f4,$f2,$f19       	# [5]  
	.loc	1 113 22
	sdc1 $f5,-8($14)              	# [6]  
	nmsub.d $f0,$f6,$f0,$f19      	# [6]  
	.loc	1 114 22
	sdc1 $f11,0($12)              	# [7]  
	.loc	1 113 22
	nmsub.d $f1,$f1,$f3,$f19      	# [7]  
	.loc	1 114 22
	madd.d $f31,$f9,$f31,$f19     	# [8]  
	sdc1 $f2,-8($10)              	# [8]  
	.loc	1 113 22
	sdc1 $f0,0($13)               	# [9]  
	sdc1 $f1,-8($13)              	# [10]  
	.loc	1 114 22
	sdc1 $f31,0($10)              	# [11]  
.BB257.jacobi_: 	 # 0x117c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:257 frequency = 16889.89648 (heuristic)
 #<freq>
.L.1.120.temp: 	 # 0x117c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:88 frequency = 18200.57617 (heuristic)
 #<freq> BB:88 => BB:93 probability = 0.28947
 #<freq> BB:88 => BB:89 probability = 0.71053
 #<freq>
	ld $1,2112($sp)               	# [0]  .gra_spill_b056
	.loc	1 110 19
	ld $6,2272($sp)               	# [1]  .gra_spill_b076
	slt $1,$1,$20                 	# [2]  
	sra $24,$6,1                  	# [3]  
	ld $5,2040($sp)               	# [4]  .gra_spill_b047
	beq $1,$0,.L.1.127.temp       	# [4]  
	andi $2,$6,1                  	# [4]  
.L.1.129.temp: 	 # 0x1198
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:89 frequency = 12931.98828 (heuristic)
 #<freq> BB:89 => BB:276 probability = 0.50000
 #<freq> BB:89 => BB:91 probability = 0.50000
 #<freq>
	ld $1,2136($sp)               	# [0]  .gra_spill_b059
	ld $13,2032($sp)              	# [1]  .gra_spill_b046
	ld $12,2232($sp)              	# [2]  .gra_spill_b071
	addu $13,$13,$1               	# [3]  
	beq $2,$0,.BB276.jacobi_      	# [4]  
	addu $12,$12,$1               	# [4]  
.L.1.130.temp: 	 # 0x11b0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:91 frequency = 6465.99414 (heuristic)
 #<freq>
	.loc	1 117 22
	ldc1 $f0,-8($13)              	# [0]  
	.loc	1 119 22
	ldc1 $f31,-8($12)             	# [1]  
	madd.d $f2,$f31,$f0,$f18      	# [3]  
	.loc	1 120 22
	nmsub.d $f1,$f0,$f31,$f18     	# [4]  
	.loc	1 119 22
	nmsub.d $f0,$f0,$f2,$f19      	# [7]  
	.loc	1 120 22
	madd.d $f31,$f31,$f1,$f19     	# [8]  
	.loc	1 116 19
	ld $1,2096($sp)               	# [9]  .gra_spill_b054
	addiu $12,$12,8               	# [10]  
	.loc	1 119 22
	sdc1 $f0,-8($13)              	# [10]  
	.loc	1 116 19
	addiu $5,$5,1                 	# [11]  
	addu $13,$1,$13               	# [11]  
	.loc	1 120 22
	sdc1 $f31,-16($12)            	# [11]  
.BB276.jacobi_: 	 # 0x11e0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:276 frequency = 12931.98828 (heuristic)
 #<freq> BB:276 => BB:274 probability = 0.02000
 #<freq> BB:276 => BB:279 probability = 0.98000
 #<freq>
	or $11,$12,$0                 	# [0]  
	.loc	1 116 19
	ld $15,2096($sp)              	# [0]  .gra_spill_b054
	or $14,$5,$0                  	# [0]  
	ld $5,2192($sp)               	# [1]  .gra_spill_b066
	beq $24,$0,.BB274.jacobi_     	# [1]  
	or $7,$13,$0                  	# [1]  
.BB279.jacobi_: 	 # 0x11f8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:279 frequency = 12673.34863 (heuristic)
 #<freq> BB:279 => BB:285 probability = 0.00000
 #<freq> BB:279 => BB:284 probability = 1.00000
 #<freq>
	slti $2,$24,3                 	# [0]  
	bne $2,$0,.BB285.jacobi_      	# [2]  
	or $6,$14,$0                  	# [0]  
.BB284.jacobi_: 	 # 0x1204
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:284 frequency = 12673.34863 (heuristic)
 #<freq>
	.loc	1 119 22
	ldc1 $f4,-8($11)              	# [0]  
	ldc1 $f5,0($11)               	# [1]  
	mov.d $f8,$f19                	# [2]  
	.loc	1 116 19
	addu $6,$15,$7                	# [2]  
	.loc	1 117 22
	ldc1 $f10,-8($7)              	# [2]  
	ldc1 $f6,-8($6)               	# [3]  
	.loc	1 120 22
	nmsub.d $f7,$f10,$f4,$f18     	# [3]  
	nmsub.d $f3,$f6,$f5,$f18      	# [4]  
	.loc	1 119 22
	madd.d $f1,$f4,$f10,$f18      	# [5]  
	.loc	1 116 19
	addiu $8,$11,16               	# [6]  
	.loc	1 119 22
	madd.d $f0,$f5,$f6,$f18       	# [6]  
	addiu $4,$14,4                	# [7]  
	ldc1 $f11,-8($8)              	# [7]  
	.loc	1 116 19
	addu $1,$15,$6                	# [7]  
	.loc	1 120 22
	madd.d $f4,$f4,$f7,$f19       	# [7]  
	.loc	1 116 19
	addiu $10,$8,16               	# [8]  
	.loc	1 117 22
	ldc1 $f13,-8($1)              	# [8]  
	.loc	1 116 19
	addu $9,$15,$1                	# [8]  
	mov.d $f7,$f18                	# [8]  
.BB281.jacobi_: 	 # 0x1250
 #<loop> Loop body line 110, nesting depth: 4, estimated iterations: 16
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 110 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>     8 cycles per 2 iterations
 #<swps>    16 flops        (100% of peak) (madds count as 2)
 #<swps>     8 flops        ( 50% of peak) (madds count as 1)
 #<swps>     8 madds        (100% of peak)
 #<swps>     8 mem refs     (100% of peak)
 #<swps>     5 integer ops  ( 31% of peak)
 #<swps>    21 instructions ( 65% of peak)
 #<swps>     2 short trip threshold
 #<swps>    12 integer registers used.
 #<swps>    18 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 110 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:281 frequency = 219757.60938 (heuristic)
 #<freq> BB:281 => BB:290 probability = 0.01922
 #<freq> BB:281 => BB:282 probability = 0.98078
 #<freq>
	.loc	1 120 22
	nmsub.d $f9,$f13,$f11,$f7     	# [0]  
	sdc1 $f4,-8($11)              	# [0]  
	.loc	1 119 22
	nmsub.d $f1,$f10,$f1,$f8      	# [1]  
	ldc1 $f12,-8($10)             	# [1]  
	nmsub.d $f0,$f6,$f0,$f8       	# [2]  
	.loc	1 117 22
	ldc1 $f6,-8($9)               	# [2]  
	.loc	1 120 22
	madd.d $f2,$f5,$f3,$f8        	# [3]  
	.loc	1 119 22
	ldc1 $f5,0($8)                	# [3]  
	.loc	1 120 22
	madd.d $f4,$f11,$f9,$f8       	# [4]  
	.loc	1 119 22
	sdc1 $f1,-8($7)               	# [4]  
	madd.d $f1,$f11,$f13,$f7      	# [5]  
	sdc1 $f0,-8($6)               	# [5]  
	.loc	1 116 19
	addiu $4,$4,2                 	# [5]  
	.loc	1 119 22
	madd.d $f0,$f5,$f6,$f7        	# [6]  
	.loc	1 120 22
	sdc1 $f2,0($11)               	# [6]  
	.loc	1 116 19
	addiu $11,$10,16              	# [6]  
	addu $3,$15,$9                	# [6]  
	.loc	1 120 22
	nmsub.d $f3,$f6,$f5,$f7       	# [7]  
	.loc	1 116 19
	addu $2,$15,$3                	# [7]  
	beq $4,$5,.BB290.jacobi_      	# [7]  
	.loc	1 117 22
	ldc1 $f11,-8($3)              	# [7]  
.BB282.jacobi_: 	 # 0x12a4
 #<loop> Part of loop body line 110, head labeled .BB281.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 110 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:282 frequency = 215533.14062 (heuristic)
 #<freq> BB:282 => BB:289 probability = 0.01960
 #<freq> BB:282 => BB:283 probability = 0.98040
 #<freq>
	.loc	1 120 22
	nmsub.d $f10,$f11,$f12,$f7    	# [0]  
	sdc1 $f4,-8($8)               	# [0]  
	.loc	1 119 22
	nmsub.d $f1,$f13,$f1,$f8      	# [1]  
	ldc1 $f9,-8($11)              	# [1]  
	nmsub.d $f0,$f6,$f0,$f8       	# [2]  
	.loc	1 117 22
	ldc1 $f6,-8($2)               	# [2]  
	.loc	1 120 22
	madd.d $f2,$f5,$f3,$f8        	# [3]  
	.loc	1 119 22
	ldc1 $f5,0($10)               	# [3]  
	.loc	1 120 22
	madd.d $f4,$f12,$f10,$f8      	# [4]  
	.loc	1 119 22
	sdc1 $f1,-8($1)               	# [4]  
	madd.d $f1,$f12,$f11,$f7      	# [5]  
	sdc1 $f0,-8($9)               	# [5]  
	.loc	1 116 19
	addiu $4,$4,2                 	# [5]  
	.loc	1 119 22
	madd.d $f0,$f5,$f6,$f7        	# [6]  
	.loc	1 120 22
	sdc1 $f2,0($8)                	# [6]  
	.loc	1 116 19
	addiu $8,$11,16               	# [6]  
	addu $7,$15,$2                	# [6]  
	.loc	1 120 22
	nmsub.d $f3,$f6,$f5,$f7       	# [7]  
	.loc	1 116 19
	addu $6,$15,$7                	# [7]  
	beq $4,$5,.BB289.jacobi_      	# [7]  
	.loc	1 117 22
	ldc1 $f10,-8($7)              	# [7]  
.BB283.jacobi_: 	 # 0x12f8
 #<loop> Part of loop body line 110, head labeled .BB281.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 110 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:283 frequency = 211308.70312 (heuristic)
 #<freq> BB:283 => BB:281 probability = 0.98001
 #<freq> BB:283 => BB:288 probability = 0.01999
 #<freq>
	.loc	1 120 22
	nmsub.d $f2,$f10,$f9,$f7      	# [0]  
	sdc1 $f4,-8($10)              	# [0]  
	.loc	1 119 22
	nmsub.d $f1,$f11,$f1,$f8      	# [1]  
	ldc1 $f11,-8($8)              	# [1]  
	nmsub.d $f0,$f6,$f0,$f8       	# [2]  
	.loc	1 117 22
	ldc1 $f6,-8($6)               	# [2]  
	.loc	1 120 22
	madd.d $f3,$f5,$f3,$f8        	# [3]  
	.loc	1 119 22
	ldc1 $f5,0($11)               	# [3]  
	.loc	1 120 22
	madd.d $f4,$f9,$f2,$f8        	# [4]  
	.loc	1 119 22
	sdc1 $f1,-8($3)               	# [4]  
	madd.d $f1,$f9,$f10,$f7       	# [5]  
	sdc1 $f0,-8($2)               	# [5]  
	.loc	1 116 19
	addiu $4,$4,2                 	# [5]  
	.loc	1 119 22
	madd.d $f0,$f5,$f6,$f7        	# [6]  
	.loc	1 120 22
	sdc1 $f3,0($10)               	# [6]  
	.loc	1 116 19
	addiu $10,$8,16               	# [6]  
	addu $1,$15,$6                	# [6]  
	.loc	1 120 22
	nmsub.d $f3,$f6,$f5,$f7       	# [7]  
	.loc	1 116 19
	addu $9,$15,$1                	# [7]  
	bne $4,$5,.BB281.jacobi_      	# [7]  
	.loc	1 117 22
	ldc1 $f13,-8($1)              	# [7]  
.BB288.jacobi_: 	 # 0x134c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:288 frequency = 4224.44971 (heuristic)
 #<freq>
	or $12,$1,$0                  	# [0]  
	or $13,$7,$0                  	# [1]  
	or $16,$4,$0                  	# [1]  
	or $14,$8,$0                  	# [2]  
	or $25,$11,$0                 	# [2]  
	mov.d $f15,$f0                	# [2]  
	or $24,$9,$0                  	# [3]  
	or $31,$6,$0                  	# [3]  
	mov.d $f14,$f1                	# [3]  
.BB287.jacobi_: 	 # 0x1370
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:287 frequency = 12673.34863 (heuristic)
 #<freq>
	.loc	1 120 22
	madd.d $f0,$f5,$f3,$f19       	# [0]  
	.loc	1 119 22
	nmsub.d $f2,$f6,$f15,$f19     	# [1]  
	.loc	1 120 22
	sdc1 $f4,-8($25)              	# [1]  
	.loc	1 119 22
	madd.d $f12,$f11,$f13,$f18    	# [2]  
	.loc	1 117 22
	ldc1 $f9,-8($24)              	# [2]  
	.loc	1 120 22
	nmsub.d $f16,$f13,$f11,$f18   	# [3]  
	.loc	1 119 22
	ldc1 $f8,0($14)               	# [3]  
	nmsub.d $f7,$f10,$f14,$f19    	# [4]  
	madd.d $f1,$f8,$f9,$f18       	# [5]  
	.loc	1 120 22
	nmsub.d $f31,$f9,$f8,$f18     	# [6]  
	.loc	1 119 22
	sdc1 $f7,-8($13)              	# [7]  
	.loc	1 120 22
	madd.d $f16,$f11,$f16,$f19    	# [7]  
	.loc	1 119 22
	nmsub.d $f12,$f13,$f12,$f19   	# [8]  
	sdc1 $f2,-8($31)              	# [8]  
	.loc	1 120 22
	sdc1 $f0,0($25)               	# [9]  
	.loc	1 119 22
	nmsub.d $f9,$f9,$f1,$f19      	# [9]  
	.loc	1 120 22
	madd.d $f8,$f8,$f31,$f19      	# [10]  
	sdc1 $f16,-8($14)             	# [10]  
	.loc	1 119 22
	sdc1 $f12,-8($12)             	# [11]  
	sdc1 $f9,-8($24)              	# [12]  
	.loc	1 120 22
	sdc1 $f8,0($14)               	# [13]  
.BB274.jacobi_: 	 # 0x13c4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:274 frequency = 12931.98828 (heuristic)
 #<freq>
.L.1.127.temp: 	 # 0x13c4
.L.1.126.temp: 	 # 0x13c4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:93 frequency = 18200.57617 (heuristic)
 #<freq> BB:93 => BB:98 probability = 0.28947
 #<freq> BB:93 => BB:94 probability = 0.71053
 #<freq>
	.loc	1 116 19
	ld $1,2136($sp)               	# [0]  .gra_spill_b059
	ld $3,2128($sp)               	# [1]  .gra_spill_b058
	ld $14,2280($sp)              	# [2]  .gra_spill_b077
	ld $13,2240($sp)              	# [3]  .gra_spill_b072
	slt $3,$20,$3                 	# [3]  
	ld $12,2216($sp)              	# [4]  .gra_spill_b069
	andi $4,$14,1                 	# [4]  
	ld $18,2248($sp)              	# [5]  .gra_spill_b073
	addu $13,$20,$13              	# [5]  
	beq $3,$0,.L.1.133.temp       	# [5]  
	sll $13,$13,3                 	# [6]  
.L.1.135.temp: 	 # 0x13f0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:94 frequency = 12931.98828 (heuristic)
 #<freq> BB:94 => BB:293 probability = 0.50000
 #<freq> BB:94 => BB:96 probability = 0.50000
 #<freq>
	addu $12,$12,$1               	# [0]  
	sra $24,$14,1                 	# [0]  
	beq $4,$0,.BB293.jacobi_      	# [1]  
	addu $13,$13,$1               	# [1]  
.L.1.136.temp: 	 # 0x1400
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:96 frequency = 6465.99414 (heuristic)
 #<freq>
	.loc	1 122 19
	ld $2,2104($sp)               	# [6]  .gra_spill_b055
	.loc	1 125 22
	ldc1 $f0,-8($13)              	# [0]  
	.loc	1 123 22
	ldc1 $f31,-8($12)             	# [1]  
	.loc	1 126 22
	nmsub.d $f2,$f31,$f0,$f18     	# [11]  
	.loc	1 125 22
	madd.d $f1,$f0,$f31,$f18      	# [12]  
	.loc	1 126 22
	madd.d $f0,$f0,$f2,$f19       	# [15]  
	.loc	1 125 22
	nmsub.d $f31,$f31,$f1,$f19    	# [16]  
	.loc	1 122 19
	ld $1,2208($sp)               	# [17]  .gra_spill_b068
	addiu $18,$18,1               	# [18]  
	.loc	1 126 22
	sdc1 $f0,-8($13)              	# [18]  
	.loc	1 122 19
	addu $13,$2,$13               	# [19]  
	.loc	1 125 22
	sdc1 $f31,-8($12)             	# [19]  
	.loc	1 122 19
	addu $12,$1,$12               	# [19]  
.BB293.jacobi_: 	 # 0x1434
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:293 frequency = 12931.98828 (heuristic)
 #<freq> BB:293 => BB:291 probability = 0.02000
 #<freq> BB:293 => BB:296 probability = 0.98000
 #<freq>
	or $31,$18,$0                 	# [0]  
	or $16,$13,$0                 	# [0]  
	ld $8,2208($sp)               	# [0]  .gra_spill_b068
	ld $11,2104($sp)              	# [1]  .gra_spill_b055
	beq $24,$0,.BB291.jacobi_     	# [1]  
	or $25,$12,$0                 	# [1]  
.BB296.jacobi_: 	 # 0x144c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 short trip count test (<= 4)
 #<swp> 
 #<freq>
 #<freq> BB:296 frequency = 12673.34863 (heuristic)
 #<freq> BB:296 => BB:303 probability = 0.00000
 #<freq> BB:296 => BB:302 probability = 1.00000
 #<freq>
	slti $3,$24,5                 	# [1]  
	bne $3,$0,.BB303.jacobi_      	# [2]  
	or $5,$31,$0                  	# [0]  
.BB302.jacobi_: 	 # 0x1458
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:302 frequency = 12673.34863 (heuristic)
 #<freq>
	.loc	1 125 22
	ldc1 $f4,-8($16)              	# [0]  
	.loc	1 122 19
	addu $15,$8,$25               	# [1]  
	.loc	1 123 22
	ldc1 $f9,-8($25)              	# [1]  
	.loc	1 122 19
	addu $12,$11,$16              	# [2]  
	.loc	1 123 22
	ldc1 $f17,-8($15)             	# [2]  
	.loc	1 125 22
	ldc1 $f6,-8($12)              	# [3]  
	ld $9,2024($sp)               	# [10]  .gra_spill_b045
	mov.d $f8,$f19                	# [10]  
	.loc	1 122 19
	addu $5,$8,$15                	# [10]  
	.loc	1 123 22
	ldc1 $f5,-8($5)               	# [11]  
	.loc	1 122 19
	addu $6,$11,$12               	# [11]  
	.loc	1 126 22
	nmsub.d $f7,$f9,$f4,$f18      	# [11]  
	.loc	1 125 22
	ldc1 $f10,-8($6)              	# [12]  
	.loc	1 122 19
	addu $4,$8,$5                 	# [12]  
	addu $2,$11,$6                	# [12]  
	.loc	1 125 22
	madd.d $f2,$f4,$f9,$f18       	# [12]  
	.loc	1 123 22
	ldc1 $f15,-8($4)              	# [13]  
	.loc	1 122 19
	addu $1,$11,$2                	# [13]  
	.loc	1 125 22
	madd.d $f0,$f6,$f17,$f18      	# [13]  
	ldc1 $f16,-8($2)              	# [14]  
	.loc	1 122 19
	addu $24,$11,$1               	# [14]  
	.loc	1 126 22
	nmsub.d $f3,$f17,$f6,$f18     	# [14]  
	.loc	1 122 19
	addu $17,$8,$4                	# [15]  
	.loc	1 125 22
	ldc1 $f13,-8($1)              	# [15]  
	.loc	1 122 19
	addu $13,$11,$24              	# [15]  
	.loc	1 126 22
	madd.d $f4,$f4,$f7,$f19       	# [15]  
	addiu $3,$31,8                	# [16]  
	.loc	1 122 19
	addu $31,$8,$17               	# [16]  
	.loc	1 125 22
	ldc1 $f12,-8($13)             	# [16]  
	mov.d $f7,$f18                	# [16]  
.BB298.jacobi_: 	 # 0x14d0
 #<loop> Loop body line 116, nesting depth: 4, estimated iterations: 12
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 116 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>     8 cycles per 2 iterations
 #<swps>    16 flops        (100% of peak) (madds count as 2)
 #<swps>     8 flops        ( 50% of peak) (madds count as 1)
 #<swps>     8 madds        (100% of peak)
 #<swps>     8 mem refs     (100% of peak)
 #<swps>     6 integer ops  ( 37% of peak)
 #<swps>    22 instructions ( 68% of peak)
 #<swps>     4 short trip threshold
 #<swps>    20 integer registers used.
 #<swps>    20 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 116 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:298 frequency = 166402.35938 (heuristic)
 #<freq> BB:298 => BB:309 probability = 0.01904
 #<freq> BB:298 => BB:299 probability = 0.98096
 #<freq>
	nmsub.d $f1,$f9,$f2,$f8       	# [0]  
	.loc	1 123 22
	ldc1 $f9,-8($17)              	# [0]  
	.loc	1 126 22
	nmsub.d $f11,$f5,$f10,$f7     	# [1]  
	sdc1 $f4,-8($16)              	# [1]  
	.loc	1 125 22
	nmsub.d $f0,$f17,$f0,$f8      	# [2]  
	.loc	1 123 22
	ldc1 $f17,-8($31)             	# [2]  
	.loc	1 126 22
	madd.d $f2,$f6,$f3,$f8        	# [3]  
	.loc	1 125 22
	sdc1 $f1,-8($25)              	# [3]  
	madd.d $f1,$f10,$f5,$f7       	# [4]  
	ldc1 $f6,-8($24)              	# [4]  
	.loc	1 126 22
	madd.d $f4,$f10,$f11,$f8      	# [5]  
	.loc	1 125 22
	sdc1 $f0,-8($15)              	# [5]  
	.loc	1 122 19
	addu $14,$11,$13              	# [5]  
	addiu $3,$3,2                 	# [5]  
	.loc	1 125 22
	madd.d $f0,$f16,$f15,$f7      	# [6]  
	.loc	1 126 22
	sdc1 $f2,-8($12)              	# [6]  
	.loc	1 122 19
	addu $10,$8,$31               	# [6]  
	addu $16,$11,$14              	# [6]  
	.loc	1 126 22
	nmsub.d $f3,$f15,$f16,$f7     	# [7]  
	.loc	1 122 19
	addu $7,$8,$10                	# [7]  
	beq $3,$9,.BB309.jacobi_      	# [7]  
	.loc	1 125 22
	ldc1 $f11,-8($16)             	# [7]  
.BB299.jacobi_: 	 # 0x1528
 #<loop> Part of loop body line 116, head labeled .BB298.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 116 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:299 frequency = 163234.01562 (heuristic)
 #<freq> BB:299 => BB:308 probability = 0.01941
 #<freq> BB:299 => BB:300 probability = 0.98059
 #<freq>
	nmsub.d $f1,$f5,$f1,$f8       	# [0]  
	.loc	1 123 22
	ldc1 $f14,-8($10)             	# [0]  
	.loc	1 126 22
	nmsub.d $f5,$f9,$f13,$f7      	# [1]  
	sdc1 $f4,-8($6)               	# [1]  
	.loc	1 125 22
	nmsub.d $f0,$f15,$f0,$f8      	# [2]  
	.loc	1 123 22
	ldc1 $f15,-8($7)              	# [2]  
	.loc	1 126 22
	madd.d $f2,$f16,$f3,$f8       	# [3]  
	.loc	1 125 22
	sdc1 $f1,-8($5)               	# [3]  
	madd.d $f1,$f13,$f9,$f7       	# [4]  
	ldc1 $f16,-8($14)             	# [4]  
	.loc	1 126 22
	madd.d $f4,$f13,$f5,$f8       	# [5]  
	.loc	1 125 22
	sdc1 $f0,-8($4)               	# [5]  
	.loc	1 122 19
	addu $12,$11,$16              	# [5]  
	addiu $3,$3,2                 	# [5]  
	.loc	1 125 22
	madd.d $f0,$f6,$f17,$f7       	# [6]  
	.loc	1 126 22
	sdc1 $f2,-8($2)               	# [6]  
	.loc	1 122 19
	addu $25,$8,$7                	# [6]  
	addu $6,$11,$12               	# [6]  
	.loc	1 126 22
	nmsub.d $f3,$f17,$f6,$f7      	# [7]  
	.loc	1 122 19
	addu $15,$8,$25               	# [7]  
	beq $3,$9,.BB308.jacobi_      	# [7]  
	.loc	1 125 22
	ldc1 $f10,-8($6)              	# [7]  
.BB300.jacobi_: 	 # 0x1580
 #<loop> Part of loop body line 116, head labeled .BB298.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 116 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:300 frequency = 160065.68750 (heuristic)
 #<freq> BB:300 => BB:307 probability = 0.01979
 #<freq> BB:300 => BB:301 probability = 0.98021
 #<freq>
	nmsub.d $f1,$f9,$f1,$f8       	# [0]  
	.loc	1 123 22
	ldc1 $f9,-8($25)              	# [0]  
	.loc	1 126 22
	nmsub.d $f5,$f14,$f12,$f7     	# [1]  
	sdc1 $f4,-8($1)               	# [1]  
	.loc	1 125 22
	nmsub.d $f0,$f17,$f0,$f8      	# [2]  
	.loc	1 123 22
	ldc1 $f17,-8($15)             	# [2]  
	.loc	1 126 22
	madd.d $f2,$f6,$f3,$f8        	# [3]  
	.loc	1 125 22
	sdc1 $f1,-8($17)              	# [3]  
	madd.d $f1,$f12,$f14,$f7      	# [4]  
	ldc1 $f6,-8($12)              	# [4]  
	.loc	1 126 22
	madd.d $f4,$f12,$f5,$f8       	# [5]  
	.loc	1 125 22
	sdc1 $f0,-8($31)              	# [5]  
	.loc	1 122 19
	addu $2,$11,$6                	# [5]  
	addiu $3,$3,2                 	# [5]  
	.loc	1 125 22
	madd.d $f0,$f16,$f15,$f7      	# [6]  
	.loc	1 126 22
	sdc1 $f2,-8($24)              	# [6]  
	.loc	1 122 19
	addu $5,$8,$15                	# [6]  
	addu $1,$11,$2                	# [6]  
	.loc	1 126 22
	nmsub.d $f3,$f15,$f16,$f7     	# [7]  
	.loc	1 122 19
	addu $4,$8,$5                 	# [7]  
	beq $3,$9,.BB307.jacobi_      	# [7]  
	.loc	1 125 22
	ldc1 $f13,-8($1)              	# [7]  
.BB301.jacobi_: 	 # 0x15d8
 #<loop> Part of loop body line 116, head labeled .BB298.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 116 replication 3
 #<swp> 
 #<freq>
 #<freq> BB:301 frequency = 156897.34375 (heuristic)
 #<freq> BB:301 => BB:298 probability = 0.97981
 #<freq> BB:301 => BB:306 probability = 0.02019
 #<freq>
	nmsub.d $f2,$f14,$f1,$f8      	# [0]  
	.loc	1 123 22
	ldc1 $f5,-8($5)               	# [0]  
	.loc	1 126 22
	nmsub.d $f1,$f9,$f11,$f7      	# [1]  
	sdc1 $f4,-8($13)              	# [1]  
	.loc	1 125 22
	nmsub.d $f0,$f15,$f0,$f8      	# [2]  
	.loc	1 123 22
	ldc1 $f15,-8($4)              	# [2]  
	.loc	1 126 22
	madd.d $f3,$f16,$f3,$f8       	# [3]  
	.loc	1 125 22
	sdc1 $f2,-8($10)              	# [3]  
	madd.d $f2,$f11,$f9,$f7       	# [4]  
	ldc1 $f16,-8($2)              	# [4]  
	.loc	1 126 22
	madd.d $f4,$f11,$f1,$f8       	# [5]  
	.loc	1 125 22
	sdc1 $f0,-8($7)               	# [5]  
	.loc	1 122 19
	addu $24,$11,$1               	# [5]  
	addiu $3,$3,2                 	# [5]  
	.loc	1 125 22
	madd.d $f0,$f6,$f17,$f7       	# [6]  
	.loc	1 126 22
	sdc1 $f3,-8($14)              	# [6]  
	.loc	1 122 19
	addu $17,$8,$4                	# [6]  
	addu $13,$11,$24              	# [6]  
	.loc	1 126 22
	nmsub.d $f3,$f17,$f6,$f7      	# [7]  
	.loc	1 122 19
	addu $31,$8,$17               	# [7]  
	bne $3,$9,.BB298.jacobi_      	# [7]  
	.loc	1 125 22
	ldc1 $f12,-8($13)             	# [7]  
.BB306.jacobi_: 	 # 0x1630
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 3
 #<swp> 
 #<freq>
 #<freq> BB:306 frequency = 3168.33716 (heuristic)
 #<freq>
	or $10,$31,$0                 	# [0]  
	or $31,$4,$0                  	# [1]  
	or $11,$13,$0                 	# [1]  
	or $13,$6,$0                  	# [2]  
	or $6,$16,$0                  	# [2]  
	mov.d $f21,$f0                	# [3]  
	or $18,$24,$0                 	# [3]  
	or $8,$5,$0                   	# [3]  
	mov.d $f14,$f5                	# [4]  
	or $5,$12,$0                  	# [4]  
	or $12,$15,$0                 	# [4]  
	mov.d $f11,$f12               	# [5]  
	or $7,$1,$0                   	# [5]  
	or $14,$3,$0                  	# [5]  
	sd $14,2264($sp)              	# [5]  .gra_spill_b075
	or $9,$25,$0                  	# [6]  
	or $14,$2,$0                  	# [6]  
	mov.d $f8,$f2                 	# [6]  
	mov.d $f12,$f10               	# [7]  
	or $15,$10,$0                 	# [7]  
	or $24,$9,$0                  	# [7]  
	or $25,$8,$0                  	# [8]  
	or $16,$7,$0                  	# [8]  
	mov.d $f10,$f8                	# [8]  
.BB305.jacobi_: 	 # 0x1690
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:305 frequency = 12673.34863 (heuristic)
 #<freq>
	.loc	1 123 22
	ldc1 $f27,-8($17)             	# [0]  
	.loc	1 125 22
	nmsub.d $f0,$f9,$f10,$f19     	# [2]  
	.loc	1 126 22
	sdc1 $f4,-8($6)               	# [2]  
	.loc	1 123 22
	ldc1 $f25,-8($15)             	# [3]  
	.loc	1 125 22
	nmsub.d $f31,$f17,$f21,$f19   	# [4]  
	.loc	1 126 22
	nmsub.d $f29,$f14,$f12,$f18   	# [5]  
	.loc	1 125 22
	sdc1 $f0,-8($24)              	# [5]  
	.loc	1 126 22
	madd.d $f30,$f6,$f3,$f19      	# [6]  
	.loc	1 125 22
	ldc1 $f23,-8($18)             	# [6]  
	.loc	1 122 19
	ld $1,2208($sp)               	# [7]  .gra_spill_b068
	.loc	1 125 22
	madd.d $f28,$f12,$f14,$f18    	# [8]  
	sdc1 $f31,-8($12)             	# [8]  
	.loc	1 122 19
	addu $2,$1,$15                	# [9]  
	.loc	1 126 22
	madd.d $f29,$f12,$f29,$f19    	# [9]  
	sdc1 $f30,-8($5)              	# [9]  
	.loc	1 125 22
	madd.d $f31,$f16,$f15,$f18    	# [10]  
	.loc	1 123 22
	ldc1 $f5,-8($2)               	# [10]  
	.loc	1 122 19
	ld $4,2104($sp)               	# [11]  .gra_spill_b055
	.loc	1 126 22
	nmsub.d $f30,$f15,$f16,$f18   	# [11]  
	.loc	1 122 19
	addu $1,$1,$2                 	# [12]  
	.loc	1 125 22
	nmsub.d $f28,$f14,$f28,$f19   	# [12]  
	.loc	1 126 22
	sdc1 $f29,-8($13)             	# [12]  
	.loc	1 123 22
	ldc1 $f2,-8($1)               	# [13]  
	.loc	1 125 22
	madd.d $f0,$f13,$f27,$f18     	# [14]  
	.loc	1 122 19
	addu $4,$4,$11                	# [15]  
	.loc	1 125 22
	nmsub.d $f31,$f15,$f31,$f19   	# [15]  
	sdc1 $f28,-8($25)             	# [15]  
	.loc	1 126 22
	madd.d $f30,$f16,$f30,$f19    	# [16]  
	.loc	1 125 22
	ldc1 $f1,-8($4)               	# [16]  
	.loc	1 126 22
	nmsub.d $f28,$f27,$f13,$f18   	# [17]  
	.loc	1 125 22
	nmsub.d $f27,$f27,$f0,$f19    	# [18]  
	madd.d $f26,$f23,$f25,$f18    	# [19]  
	.loc	1 126 22
	nmsub.d $f29,$f25,$f23,$f18   	# [20]  
	madd.d $f28,$f13,$f28,$f19    	# [21]  
	nmsub.d $f7,$f5,$f11,$f18     	# [22]  
	.loc	1 125 22
	nmsub.d $f25,$f25,$f26,$f19   	# [23]  
	.loc	1 126 22
	madd.d $f23,$f23,$f29,$f19    	# [24]  
	.loc	1 125 22
	sdc1 $f31,-8($31)             	# [25]  
	madd.d $f26,$f11,$f5,$f18     	# [25]  
	.loc	1 126 22
	sdc1 $f30,-8($14)             	# [26]  
	.loc	1 125 22
	madd.d $f24,$f1,$f2,$f18      	# [26]  
	.loc	1 126 22
	sdc1 $f28,-8($16)             	# [27]  
	nmsub.d $f8,$f2,$f1,$f18      	# [27]  
	.loc	1 125 22
	sdc1 $f27,-8($17)             	# [28]  
	.loc	1 126 22
	madd.d $f7,$f11,$f7,$f19      	# [28]  
	.loc	1 125 22
	sdc1 $f25,-8($15)             	# [29]  
	nmsub.d $f5,$f5,$f26,$f19     	# [29]  
	.loc	1 126 22
	sdc1 $f23,-8($18)             	# [30]  
	.loc	1 125 22
	nmsub.d $f2,$f2,$f24,$f19     	# [30]  
	.loc	1 126 22
	sdc1 $f7,-8($11)              	# [31]  
	madd.d $f1,$f1,$f8,$f19       	# [31]  
	.loc	1 125 22
	sdc1 $f5,-8($2)               	# [32]  
	sdc1 $f2,-8($1)               	# [33]  
	addiu $17,$0,16               	# [34]  
	.loc	1 126 22
	sdc1 $f1,-8($4)               	# [34]  
.BB291.jacobi_: 	 # 0x176c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:291 frequency = 12931.98828 (heuristic)
 #<freq>
.L.1.133.temp: 	 # 0x176c
.L.1.132.temp: 	 # 0x176c
.L.1.139.temp: 	 # 0x176c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:98 frequency = 18200.57617 (heuristic)
 #<freq> BB:98 => BB:312 probability = 0.50000
 #<freq> BB:98 => BB:100 probability = 0.50000
 #<freq>
	.loc	1 122 19
	ld $10,2048($sp)              	# [0]  .gra_spill_b048
	ld $14,2128($sp)              	# [1]  .gra_spill_b058
	ld $12,2080($sp)              	# [2]  .gra_spill_b052
	sra $24,$14,1                 	# [3]  
	andi $2,$14,1                 	# [3]  
	addu $12,$12,$10              	# [4]  
	addu $13,$23,$10              	# [4]  
	beq $2,$0,.BB312.jacobi_      	# [5]  
	addu $10,$30,$10              	# [5]  
.L.1.140.temp: 	 # 0x1790
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<loop> Unrolling remainder loop (at most 1 iteration)
 #<freq>
 #<freq> BB:100 frequency = 9100.28809 (heuristic)
 #<freq>
	.loc	1 131 22
	ldc1 $f2,-8($10)              	# [0]  
	.loc	1 129 22
	ldc1 $f1,-8($12)              	# [1]  
	.loc	1 132 22
	nmsub.d $f0,$f1,$f2,$f18      	# [3]  
	.loc	1 131 22
	madd.d $f31,$f2,$f1,$f18      	# [4]  
	.loc	1 132 22
	madd.d $f2,$f2,$f0,$f19       	# [7]  
	.loc	1 131 22
	nmsub.d $f1,$f1,$f31,$f19     	# [8]  
	.loc	1 128 19
	addiu $12,$12,8               	# [10]  
	.loc	1 132 22
	sdc1 $f2,-8($10)              	# [10]  
	.loc	1 128 19
	addiu $10,$10,8               	# [11]  
	.loc	1 131 22
	sdc1 $f1,-16($12)             	# [11]  
.BB312.jacobi_: 	 # 0x17b8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:312 frequency = 18200.57617 (heuristic)
 #<freq> BB:312 => BB:310 probability = 0.02000
 #<freq> BB:312 => BB:315 probability = 0.98000
 #<freq>
	or $5,$10,$0                  	# [0]  
	mov.d $f8,$f19                	# [0]  
	slti $1,$24,3                 	# [0]  
	mov.d $f7,$f18                	# [1]  
	beq $24,$0,.BB310.jacobi_     	# [1]  
	or $6,$12,$0                  	# [1]  
.BB315.jacobi_: 	 # 0x17d0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:315 frequency = 17836.56445 (heuristic)
 #<freq> BB:315 => BB:321 probability = 0.00000
 #<freq> BB:315 => BB:320 probability = 1.00000
 #<freq>
	bne $1,$0,.BB321.jacobi_      	# [0]  
	or $4,$6,$0                   	# [0]  
.BB320.jacobi_: 	 # 0x17d8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:320 frequency = 17836.56445 (heuristic)
 #<freq>
	ldc1 $f0,-8($5)               	# [0]  
	.loc	1 129 22
	ldc1 $f10,0($6)               	# [1]  
	ldc1 $f5,-8($6)               	# [2]  
	.loc	1 131 22
	ldc1 $f11,0($5)               	# [3]  
	.loc	1 132 22
	nmsub.d $f2,$f5,$f0,$f18      	# [3]  
	.loc	1 131 22
	madd.d $f1,$f11,$f10,$f18     	# [4]  
	madd.d $f6,$f0,$f5,$f18       	# [5]  
	.loc	1 132 22
	nmsub.d $f31,$f10,$f11,$f18   	# [6]  
	.loc	1 128 19
	addiu $7,$5,16                	# [7]  
	.loc	1 132 22
	madd.d $f0,$f0,$f2,$f19       	# [7]  
	.loc	1 128 19
	addiu $8,$6,16                	# [8]  
	.loc	1 131 22
	ldc1 $f4,-8($7)               	# [8]  
	nmsub.d $f10,$f10,$f1,$f19    	# [8]  
	addiu $1,$13,-32              	# [9]  
	.loc	1 128 19
	addiu $2,$8,16                	# [9]  
	.loc	1 131 22
	ldc1 $f9,0($7)                	# [9]  
	nmsub.d $f5,$f5,$f6,$f19      	# [9]  
	.loc	1 128 19
	addiu $3,$7,16                	# [10]  
	or $6,$8,$0                   	# [10]  
	.loc	1 129 22
	ldc1 $f6,0($8)                	# [10]  
	.loc	1 132 22
	madd.d $f11,$f11,$f31,$f19    	# [10]  
	nop                           	# [10]  
.BB317.jacobi_: 	 # 0x1830
 #<loop> Loop body line 122, nesting depth: 4, estimated iterations: 16
 #<loop> Unrolled 2 times
 #<swps> 
 #<swps> Pipelined loop line 122 steady state
 #<swps> 
 #<swps>    50 estimated iterations before pipelining
 #<swps>     2 unrollings before pipelining
 #<swps>     8 cycles per 2 iterations
 #<swps>    16 flops        (100% of peak) (madds count as 2)
 #<swps>     8 flops        ( 50% of peak) (madds count as 1)
 #<swps>     8 madds        (100% of peak)
 #<swps>     8 mem refs     (100% of peak)
 #<swps>     3 integer ops  ( 18% of peak)
 #<swps>    19 instructions ( 59% of peak)
 #<swps>     2 short trip threshold
 #<swps>     7 integer registers used.
 #<swps>    13 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 122 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:317 frequency = 309288.46875 (heuristic)
 #<freq> BB:317 => BB:326 probability = 0.01922
 #<freq> BB:317 => BB:318 probability = 0.98078
 #<freq>
	nmsub.d $f12,$f6,$f9,$f7      	# [0]  
	.loc	1 129 22
	ldc1 $f3,-8($6)               	# [0]  
	.loc	1 131 22
	madd.d $f2,$f9,$f6,$f7        	# [1]  
	.loc	1 132 22
	sdc1 $f0,-8($5)               	# [1]  
	nmsub.d $f0,$f3,$f4,$f7       	# [2]  
	.loc	1 131 22
	sdc1 $f5,-8($4)               	# [2]  
	madd.d $f1,$f4,$f3,$f7        	# [3]  
	sdc1 $f10,0($4)               	# [3]  
	.loc	1 132 22
	sdc1 $f11,0($5)               	# [4]  
	madd.d $f11,$f9,$f12,$f8      	# [4]  
	.loc	1 131 22
	nmsub.d $f10,$f6,$f2,$f8      	# [5]  
	.loc	1 128 19
	addiu $5,$3,16                	# [5]  
	.loc	1 131 22
	ldc1 $f9,0($3)                	# [5]  
	.loc	1 132 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 129 22
	ldc1 $f6,0($2)                	# [6]  
	.loc	1 131 22
	nmsub.d $f5,$f3,$f1,$f8       	# [7]  
	.loc	1 128 19
	addiu $4,$2,16                	# [7]  
	beq $7,$1,.BB326.jacobi_      	# [7]  
	.loc	1 131 22
	ldc1 $f4,-8($3)               	# [7]  
.BB318.jacobi_: 	 # 0x187c
 #<loop> Part of loop body line 122, head labeled .BB317.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 122 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:318 frequency = 303342.93750 (heuristic)
 #<freq> BB:318 => BB:325 probability = 0.01960
 #<freq> BB:318 => BB:319 probability = 0.98040
 #<freq>
	.loc	1 132 22
	nmsub.d $f12,$f6,$f9,$f7      	# [0]  
	.loc	1 129 22
	ldc1 $f3,-8($2)               	# [0]  
	.loc	1 131 22
	madd.d $f2,$f9,$f6,$f7        	# [1]  
	.loc	1 132 22
	sdc1 $f0,-8($7)               	# [1]  
	nmsub.d $f0,$f3,$f4,$f7       	# [2]  
	.loc	1 131 22
	sdc1 $f5,-8($6)               	# [2]  
	madd.d $f1,$f4,$f3,$f7        	# [3]  
	sdc1 $f10,0($6)               	# [3]  
	.loc	1 132 22
	sdc1 $f11,0($7)               	# [4]  
	madd.d $f11,$f9,$f12,$f8      	# [4]  
	.loc	1 131 22
	nmsub.d $f10,$f6,$f2,$f8      	# [5]  
	.loc	1 128 19
	addiu $7,$5,16                	# [5]  
	.loc	1 131 22
	ldc1 $f9,0($5)                	# [5]  
	.loc	1 132 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 129 22
	ldc1 $f6,0($4)                	# [6]  
	.loc	1 131 22
	nmsub.d $f5,$f3,$f1,$f8       	# [7]  
	.loc	1 128 19
	addiu $6,$4,16                	# [7]  
	beq $3,$1,.BB325.jacobi_      	# [7]  
	.loc	1 131 22
	ldc1 $f4,-8($5)               	# [7]  
.BB319.jacobi_: 	 # 0x18c8
 #<loop> Part of loop body line 122, head labeled .BB317.jacobi_
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 122 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:319 frequency = 297397.40625 (heuristic)
 #<freq> BB:319 => BB:317 probability = 0.98001
 #<freq> BB:319 => BB:324 probability = 0.01999
 #<freq>
	.loc	1 132 22
	nmsub.d $f3,$f6,$f9,$f7       	# [0]  
	.loc	1 129 22
	ldc1 $f2,-8($4)               	# [0]  
	.loc	1 131 22
	madd.d $f1,$f9,$f6,$f7        	# [1]  
	.loc	1 132 22
	sdc1 $f0,-8($3)               	# [1]  
	nmsub.d $f0,$f2,$f4,$f7       	# [2]  
	.loc	1 131 22
	sdc1 $f5,-8($2)               	# [2]  
	madd.d $f5,$f4,$f2,$f7        	# [3]  
	sdc1 $f10,0($2)               	# [3]  
	.loc	1 132 22
	sdc1 $f11,0($3)               	# [4]  
	madd.d $f11,$f9,$f3,$f8       	# [4]  
	.loc	1 131 22
	nmsub.d $f10,$f6,$f1,$f8      	# [5]  
	.loc	1 128 19
	addiu $3,$7,16                	# [5]  
	.loc	1 131 22
	ldc1 $f9,0($7)                	# [5]  
	.loc	1 132 22
	madd.d $f0,$f4,$f0,$f8        	# [6]  
	.loc	1 129 22
	ldc1 $f6,0($6)                	# [6]  
	.loc	1 131 22
	nmsub.d $f5,$f2,$f5,$f8       	# [7]  
	.loc	1 128 19
	addiu $2,$6,16                	# [7]  
	bne $5,$1,.BB317.jacobi_      	# [7]  
	.loc	1 131 22
	ldc1 $f4,-8($7)               	# [7]  
.BB324.jacobi_: 	 # 0x1914
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:324 frequency = 5945.52148 (heuristic)
 #<freq>
	or $13,$7,$0                  	# [0]  
	or $14,$5,$0                  	# [0]  
	or $12,$6,$0                  	# [1]  
	or $10,$4,$0                  	# [1]  
	mov.d $f7,$f0                 	# [1]  
.BB323.jacobi_: 	 # 0x1928
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:323 frequency = 17836.56445 (heuristic)
 #<freq>
	.loc	1 129 22
	ldc1 $f1,-8($12)              	# [0]  
	.loc	1 132 22
	nmsub.d $f2,$f1,$f4,$f18      	# [1]  
	.loc	1 131 22
	madd.d $f0,$f9,$f6,$f18       	# [2]  
	madd.d $f3,$f4,$f1,$f18       	# [3]  
	.loc	1 132 22
	nmsub.d $f31,$f6,$f9,$f18     	# [4]  
	sdc1 $f7,-8($14)              	# [4]  
	.loc	1 131 22
	sdc1 $f10,0($10)              	# [5]  
	.loc	1 132 22
	madd.d $f2,$f4,$f2,$f19       	# [5]  
	.loc	1 131 22
	sdc1 $f5,-8($10)              	# [6]  
	nmsub.d $f0,$f6,$f0,$f19      	# [6]  
	.loc	1 132 22
	sdc1 $f11,0($14)              	# [7]  
	.loc	1 131 22
	nmsub.d $f1,$f1,$f3,$f19      	# [7]  
	.loc	1 132 22
	madd.d $f31,$f9,$f31,$f19     	# [8]  
	sdc1 $f2,-8($13)              	# [8]  
	.loc	1 131 22
	sdc1 $f0,0($12)               	# [9]  
	sdc1 $f1,-8($12)              	# [10]  
	.loc	1 132 22
	sdc1 $f31,0($13)              	# [11]  
.BB310.jacobi_: 	 # 0x196c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:310 frequency = 18200.57617 (heuristic)
 #<freq>
	ld $1,2120($sp)               	# [0]  .gra_spill_b057
	.loc	1 134 19
	addiu $1,$1,1                 	# [2]  
	b .L.1.115.temp               	# [2]  
	sd $1,2120($sp)               	# [2]  .gra_spill_b057
.L.1.83.temp: 	 # 0x197c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:49 frequency = 6933.55322 (heuristic)
 #<freq> BB:49 => BB:102 probability = 0.50000
 #<freq> BB:49 => BB:50 probability = 0.50000
 #<freq>
	ldc1 $f31,1728($sp)           	# [0]  .gra_spill_b008
	.loc	1 105 19
	ld $4,2088($sp)               	# [1]  .gra_spill_b053
	.loc	1 109 19
	ld $3,2056($sp)               	# [2]  .gra_spill_b049
	ldc1 $f24,%gp_rel(.lit8-30712)($gp)	# [3]  
	.loc	1 91 19
	c.lt.d $fcc2,$f31,$f4         	# [3]  
	.loc	1 109 19
	ld $14,2064($sp)              	# [4]  .gra_spill_b050
	ld $10,2072($sp)              	# [5]  .gra_spill_b051
	.loc	1 93 19
	ld $2,2144($sp)               	# [6]  .gra_spill_b060
	c.eq.d $fcc3,$f6,$f20         	# [6]  
	andi $5,$14,3                 	# [6]  
	.loc	1 91 19
	bc1f $fcc2,.L.1.115.temp      	# [6]  
	sra $24,$14,2                 	# [7]  
.BB50.jacobi_: 	 # 0x19ac
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:50 frequency = 3466.77661 (heuristic)
 #<freq> BB:50 => BB:52 probability = 0.50000
 #<freq> BB:50 => BB:51 probability = 0.50000
 #<freq>
	.loc	1 93 19
	ldc1 $f7,-8($2)               	# [0]  
	ldc1 $f4,-8($21)              	# [1]  
	.loc	1 107 19
	ld $1,2144($sp)               	# [12]  .gra_spill_b060
	.loc	1 93 19
	bc1f $fcc3,.L.1.87.temp       	# [12]  
	sub.d $f4,$f4,$f7             	# [12]  
.BB51.jacobi_: 	 # 0x19c0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:51 frequency = 1733.38831 (heuristic)
 #<freq>
	.loc	1 95 22
	b .L.1.89.temp                	# [0]  
	div.d $f3,$f5,$f4             	# [0]  
.BB325.jacobi_: 	 # 0x19c8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:325 frequency = 5945.52148 (heuristic)
 #<freq>
	or $14,$3,$0                  	# [0]  
	or $13,$5,$0                  	# [1]  
	or $10,$2,$0                  	# [1]  
	or $12,$4,$0                  	# [2]  
	b .BB323.jacobi_              	# [2]  
	mov.d $f7,$f0                 	# [2]  
.BB326.jacobi_: 	 # 0x19e0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:326 frequency = 5945.52148 (heuristic)
 #<freq>
	or $13,$3,$0                  	# [0]  
	or $14,$7,$0                  	# [1]  
	or $12,$2,$0                  	# [1]  
	or $10,$6,$0                  	# [2]  
	b .BB323.jacobi_              	# [2]  
	mov.d $f7,$f0                 	# [2]  
.BB272.jacobi_: 	 # 0x19f8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:272 frequency = 5517.36670 (heuristic)
 #<freq>
	or $12,$3,$0                  	# [0]  
	or $10,$5,$0                  	# [1]  
	or $14,$2,$0                  	# [1]  
	or $13,$4,$0                  	# [2]  
	b .BB270.jacobi_              	# [2]  
	mov.d $f7,$f0                 	# [2]  
.BB273.jacobi_: 	 # 0x1a10
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:273 frequency = 5517.36670 (heuristic)
 #<freq>
	or $10,$3,$0                  	# [0]  
	or $12,$7,$0                  	# [1]  
	or $13,$2,$0                  	# [1]  
	or $14,$6,$0                  	# [2]  
	b .BB270.jacobi_              	# [2]  
	mov.d $f7,$f0                 	# [2]  
.BB289.jacobi_: 	 # 0x1a28
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:289 frequency = 4224.44971 (heuristic)
 #<freq>
	mov.d $f15,$f0                	# [0]  
	mov.d $f14,$f1                	# [1]  
	or $12,$7,$0                  	# [2]  
	or $13,$3,$0                  	# [2]  
	mov.d $f13,$f10               	# [2]  
	or $16,$4,$0                  	# [3]  
	or $25,$10,$0                 	# [3]  
	mov.d $f7,$f9                 	# [3]  
	or $14,$11,$0                 	# [4]  
	or $24,$6,$0                  	# [4]  
	mov.d $f10,$f11               	# [4]  
	or $31,$2,$0                  	# [5]  
	b .BB287.jacobi_              	# [5]  
	mov.d $f11,$f7                	# [5]  
.BB290.jacobi_: 	 # 0x1a60
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:290 frequency = 4224.44971 (heuristic)
 #<freq>
	mov.d $f15,$f0                	# [0]  
	mov.d $f14,$f1                	# [1]  
	or $13,$1,$0                  	# [2]  
	or $12,$3,$0                  	# [2]  
	mov.d $f10,$f13               	# [2]  
	or $16,$4,$0                  	# [3]  
	or $14,$10,$0                 	# [3]  
	mov.d $f8,$f12                	# [3]  
	or $25,$8,$0                  	# [4]  
	or $31,$9,$0                  	# [4]  
	mov.d $f13,$f11               	# [4]  
	or $24,$2,$0                  	# [5]  
	b .BB287.jacobi_              	# [5]  
	mov.d $f11,$f8                	# [5]  
.L.1.87.temp: 	 # 0x1a98
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:52 frequency = 1733.38831 (heuristic)
 #<freq>
	ldc1 $f3,%gp_rel(.lit8-30680)($gp)	# [7]  
	.loc	1 97 22
	div.d $f0,$f4,$f5             	# [0]  
	mul.d $f0,$f0,$f3             	# [17]  
	madd.d $f2,$f2,$f0,$f0        	# [19]  
	.loc	1 98 22
	sqrt.d $f2,$f2                	# [23]  
	abs.d $f31,$f0                	# [51]  
	add.d $f31,$f31,$f2           	# [53]  
	recip.d $f31,$f31             	# [55]  
	c.lt.d $fcc0,$f0,$f1          	# [71]  
	.loc	1 99 39
	neg.d $f3,$f31                	# [72]  
	movf.d $f3,$f31,$fcc0         	# [74]  
.L.1.89.temp: 	 # 0x1ac4
.L.1.88.temp: 	 # 0x1ac4
.L.1.86.temp: 	 # 0x1ac4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:54 frequency = 3466.77661 (heuristic)
 #<freq> BB:54 => BB:59 probability = 0.07201
 #<freq> BB:54 => BB:55 probability = 0.92799
 #<freq>
	.loc	1 105 19
	ldc1 $f31,-8($4)              	# [0]  
	.loc	1 104 19
	mul.d $f0,$f5,$f3             	# [7]  
	.loc	1 107 19
	sub.d $f1,$f7,$f0             	# [9]  
	sdc1 $f1,-8($1)               	# [10]  
	.loc	1 108 19
	ldc1 $f1,-8($21)              	# [11]  
	.loc	1 105 19
	sub.d $f31,$f31,$f0           	# [11]  
	sdc1 $f31,-8($4)              	# [12]  
	.loc	1 106 19
	ldc1 $f31,-8($22)             	# [13]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [20]  
	.loc	1 109 19
	sdc1 $f2,-8($19)              	# [22]  
	ld $1,2136($sp)               	# [23]  .gra_spill_b059
	.loc	1 108 19
	add.d $f1,$f1,$f0             	# [23]  
	sdc1 $f1,-8($21)              	# [24]  
	.loc	1 106 19
	add.d $f31,$f31,$f0           	# [24]  
	madd.d $f26,$f24,$f3,$f3      	# [25]  
	.loc	1 109 19
	addu $10,$10,$1               	# [25]  
	beq $3,$0,.L.1.91.temp        	# [25]  
	.loc	1 106 19
	sdc1 $f31,-8($22)             	# [25]  
.L.1.93.temp: 	 # 0x1b0c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:55 frequency = 3217.12329 (heuristic)
 #<freq> BB:55 => BB:193 probability = 0.25000
 #<freq> BB:55 => BB:57 probability = 0.75000
 #<freq>
	.loc	1 109 19
	sqrt.d $f26,$f26              	# [0]  
	recip.d $f26,$f26             	# [30]  
	add.d $f24,$f26,$f24          	# [47]  
	recip.d $f24,$f24             	# [49]  
	ld $13,2296($sp)              	# [63]  .gra_spill_b079
	ld $12,2288($sp)              	# [64]  .gra_spill_b078
	mul.d $f26,$f26,$f3           	# [64]  
	addu $13,$13,$1               	# [65]  
	addu $12,$12,$1               	# [66]  
	beq $5,$0,.BB193.jacobi_      	# [66]  
	mul.d $f24,$f26,$f24          	# [66]  
.L.1.94.temp: 	 # 0x1b38
 #<loop> Loop body line 109, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 3 iterations)
 #<sched> 
 #<sched> Loop schedule length: 21 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     8 flops        ( 19% of peak) (madds count as 2)
 #<sched>     4 flops        (  9% of peak) (madds count as 1)
 #<sched>     4 madds        ( 19% of peak)
 #<sched>     5 mem refs     ( 23% of peak)
 #<sched>     4 integer ops  (  9% of peak)
 #<sched>    13 instructions ( 15% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:57 frequency = 4825.68506 (heuristic)
 #<freq> BB:57 => BB:57 probability = 0.50000
 #<freq> BB:57 => BB:193 probability = 0.50000
 #<freq>
	.loc	1 114 22
	pref 1,248($12)               	# [0]  
	.loc	1 113 22
	ldc1 $f0,-8($12)              	# [1]  
	.loc	1 111 22
	ldc1 $f31,-8($10)             	# [2]  
	.loc	1 114 22
	nmsub.d $f2,$f31,$f0,$f24     	# [12]  
	.loc	1 113 22
	madd.d $f1,$f0,$f31,$f24      	# [13]  
	.loc	1 114 22
	madd.d $f0,$f0,$f2,$f26       	# [16]  
	.loc	1 113 22
	nmsub.d $f31,$f31,$f1,$f26    	# [17]  
	addi $5,$5,-1                 	# [18]  
	.loc	1 110 19
	addiu $10,$10,8               	# [19]  
	.loc	1 114 22
	sdc1 $f0,-8($12)              	# [19]  
	.loc	1 110 19
	addiu $12,$12,8               	# [20]  
	bne $5,$0,.L.1.94.temp        	# [20]  
	.loc	1 113 22
	sdc1 $f31,-16($10)            	# [20]  
.BB193.jacobi_: 	 # 0x1b6c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:193 frequency = 3217.12329 (heuristic)
 #<freq> BB:193 => BB:191 probability = 0.04000
 #<freq> BB:193 => BB:196 probability = 0.96000
 #<freq>
	or $6,$10,$0                  	# [0]  
	addiu $7,$13,-64              	# [0]  
	beq $24,$0,.BB191.jacobi_     	# [1]  
	or $5,$12,$0                  	# [1]  
.BB196.jacobi_: 	 # 0x1b7c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:196 frequency = 3088.43823 (heuristic)
 #<freq> BB:196 => BB:202 probability = 0.00000
 #<freq> BB:196 => BB:201 probability = 1.00000
 #<freq>
	slti $1,$24,3                 	# [0]  
	bne $1,$0,.BB202.jacobi_      	# [2]  
	or $10,$6,$0                  	# [0]  
.BB201.jacobi_: 	 # 0x1b88
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:201 frequency = 3088.43823 (heuristic)
 #<freq>
	.loc	1 111 22
	ldc1 $f0,-8($6)               	# [0]  
	.loc	1 114 22
	pref 1,248($5)                	# [1]  
	.loc	1 113 22
	ldc1 $f2,0($5)                	# [2]  
	ldc1 $f1,-8($5)               	# [3]  
	.loc	1 111 22
	ldc1 $f4,0($6)                	# [4]  
	.loc	1 114 22
	nmsub.d $f3,$f4,$f2,$f24      	# [13]  
	.loc	1 113 22
	madd.d $f8,$f1,$f0,$f24       	# [14]  
	.loc	1 114 22
	nmsub.d $f7,$f0,$f1,$f24      	# [15]  
	.loc	1 113 22
	ldc1 $f10,8($5)               	# [16]  
	madd.d $f5,$f2,$f4,$f24       	# [16]  
	ldc1 $f6,16($5)               	# [17]  
	.loc	1 114 22
	madd.d $f2,$f2,$f3,$f26       	# [17]  
	.loc	1 111 22
	ldc1 $f12,8($6)               	# [18]  
	.loc	1 113 22
	nmsub.d $f0,$f0,$f8,$f26      	# [18]  
	.loc	1 111 22
	ldc1 $f9,16($6)               	# [19]  
	.loc	1 110 19
	addiu $3,$5,32                	# [19]  
	mov.d $f8,$f26                	# [19]  
	addiu $8,$6,32                	# [20]  
	.loc	1 113 22
	ldc1 $f13,-8($3)              	# [20]  
	.loc	1 114 22
	madd.d $f1,$f1,$f7,$f26       	# [20]  
	or $4,$6,$0                   	# [21]  
	.loc	1 111 22
	ldc1 $f11,0($8)               	# [21]  
	.loc	1 110 19
	addiu $1,$8,32                	# [21]  
	.loc	1 113 22
	nmsub.d $f4,$f4,$f5,$f26      	# [21]  
	.loc	1 110 19
	addiu $2,$3,32                	# [22]  
	or $6,$8,$0                   	# [22]  
	.loc	1 113 22
	ldc1 $f5,0($3)                	# [22]  
	mov.d $f7,$f24                	# [22]  
	nop                           	# [22]  
	nop                           	# [22]  
.BB198.jacobi_: 	 # 0x1c00
 #<loop> Loop body line 109, nesting depth: 4, estimated iterations: 8
 #<loop> Unrolled 4 times
 #<swps> 
 #<swps> Pipelined loop line 109 steady state
 #<swps> 
 #<swps>    25 estimated iterations before pipelining
 #<swps>     4 unrollings before pipelining
 #<swps>    17 cycles per 4 iterations
 #<swps>    32 flops        ( 94% of peak) (madds count as 2)
 #<swps>    16 flops        ( 47% of peak) (madds count as 1)
 #<swps>    16 madds        ( 94% of peak)
 #<swps>    16 mem refs     ( 94% of peak)
 #<swps>     3 integer ops  (  8% of peak)
 #<swps>    35 instructions ( 51% of peak)
 #<swps>     2 short trip threshold
 #<swps>     7 integer registers used.
 #<swps>    18 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 109 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:198 frequency = 27838.84180 (heuristic)
 #<freq> BB:198 => BB:207 probability = 0.03698
 #<freq> BB:198 => BB:199 probability = 0.96302
 #<freq>
	.loc	1 111 22
	ldc1 $f15,-8($6)              	# [0]  
	.loc	1 114 22
	nmsub.d $f14,$f9,$f6,$f7      	# [1]  
	sdc1 $f1,-8($5)               	# [1]  
	.loc	1 113 22
	madd.d $f3,$f6,$f9,$f7        	# [2]  
	sdc1 $f0,-8($4)               	# [2]  
	.loc	1 114 22
	nmsub.d $f1,$f12,$f10,$f7     	# [3]  
	.loc	1 113 22
	sdc1 $f4,0($4)                	# [3]  
	madd.d $f0,$f10,$f12,$f7      	# [4]  
	.loc	1 114 22
	sdc1 $f2,0($5)                	# [4]  
	madd.d $f6,$f6,$f14,$f8       	# [5]  
	.loc	1 113 22
	nmsub.d $f4,$f9,$f3,$f8       	# [6]  
	ldc1 $f14,16($3)              	# [6]  
	.loc	1 114 22
	madd.d $f1,$f10,$f1,$f8       	# [7]  
	.loc	1 111 22
	ldc1 $f9,16($6)               	# [7]  
	.loc	1 113 22
	nmsub.d $f0,$f12,$f0,$f8      	# [8]  
	ldc1 $f10,8($3)               	# [8]  
	.loc	1 114 22
	nmsub.d $f3,$f11,$f5,$f7      	# [9]  
	.loc	1 111 22
	ldc1 $f12,8($6)               	# [9]  
	.loc	1 113 22
	madd.d $f2,$f5,$f11,$f7       	# [10]  
	.loc	1 114 22
	sdc1 $f1,8($5)                	# [10]  
	nmsub.d $f1,$f15,$f13,$f7     	# [11]  
	.loc	1 113 22
	sdc1 $f0,8($4)                	# [11]  
	madd.d $f0,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($4)               	# [12]  
	.loc	1 114 22
	madd.d $f5,$f5,$f3,$f8        	# [13]  
	sdc1 $f6,16($5)               	# [13]  
	.loc	1 113 22
	nmsub.d $f4,$f11,$f2,$f8      	# [14]  
	.loc	1 110 19
	addiu $5,$2,32                	# [14]  
	.loc	1 113 22
	ldc1 $f16,0($2)               	# [14]  
	.loc	1 114 22
	madd.d $f1,$f13,$f1,$f8       	# [15]  
	.loc	1 111 22
	ldc1 $f11,0($1)               	# [15]  
	.loc	1 113 22
	nmsub.d $f0,$f15,$f0,$f8      	# [16]  
	.loc	1 110 19
	addiu $4,$1,32                	# [16]  
	beq $3,$7,.BB207.jacobi_      	# [16]  
	.loc	1 113 22
	ldc1 $f13,-8($2)              	# [16]  
.BB199.jacobi_: 	 # 0x1c8c
 #<loop> Part of loop body line 109, head labeled .BB198.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 109 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:199 frequency = 26809.36133 (heuristic)
 #<freq> BB:199 => BB:206 probability = 0.03840
 #<freq> BB:199 => BB:200 probability = 0.96160
 #<freq>
	.loc	1 111 22
	ldc1 $f15,-8($1)              	# [0]  
	.loc	1 114 22
	nmsub.d $f3,$f9,$f14,$f7      	# [1]  
	sdc1 $f1,-8($3)               	# [1]  
	.loc	1 113 22
	madd.d $f2,$f14,$f9,$f7       	# [2]  
	sdc1 $f0,-8($6)               	# [2]  
	.loc	1 114 22
	nmsub.d $f1,$f12,$f10,$f7     	# [3]  
	.loc	1 113 22
	sdc1 $f4,0($6)                	# [3]  
	madd.d $f0,$f10,$f12,$f7      	# [4]  
	.loc	1 114 22
	sdc1 $f5,0($3)                	# [4]  
	madd.d $f6,$f14,$f3,$f8       	# [5]  
	.loc	1 113 22
	nmsub.d $f4,$f9,$f2,$f8       	# [6]  
	ldc1 $f14,16($2)              	# [6]  
	.loc	1 114 22
	madd.d $f1,$f10,$f1,$f8       	# [7]  
	.loc	1 111 22
	ldc1 $f9,16($1)               	# [7]  
	.loc	1 113 22
	nmsub.d $f0,$f12,$f0,$f8      	# [8]  
	ldc1 $f10,8($2)               	# [8]  
	.loc	1 114 22
	nmsub.d $f3,$f11,$f16,$f7     	# [9]  
	.loc	1 111 22
	ldc1 $f12,8($1)               	# [9]  
	.loc	1 113 22
	madd.d $f2,$f16,$f11,$f7      	# [10]  
	.loc	1 114 22
	sdc1 $f1,8($3)                	# [10]  
	nmsub.d $f1,$f15,$f13,$f7     	# [11]  
	.loc	1 113 22
	sdc1 $f0,8($6)                	# [11]  
	madd.d $f0,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($6)               	# [12]  
	.loc	1 114 22
	madd.d $f5,$f16,$f3,$f8       	# [13]  
	sdc1 $f6,16($3)               	# [13]  
	.loc	1 113 22
	nmsub.d $f4,$f11,$f2,$f8      	# [14]  
	.loc	1 110 19
	addiu $3,$5,32                	# [14]  
	.loc	1 113 22
	ldc1 $f16,0($5)               	# [14]  
	.loc	1 114 22
	madd.d $f1,$f13,$f1,$f8       	# [15]  
	.loc	1 111 22
	ldc1 $f11,0($4)               	# [15]  
	.loc	1 113 22
	nmsub.d $f0,$f15,$f0,$f8      	# [16]  
	.loc	1 110 19
	addiu $6,$4,32                	# [16]  
	beq $2,$7,.BB206.jacobi_      	# [16]  
	.loc	1 113 22
	ldc1 $f13,-8($5)              	# [16]  
.BB200.jacobi_: 	 # 0x1d18
 #<loop> Part of loop body line 109, head labeled .BB198.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 109 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:200 frequency = 25779.88281 (heuristic)
 #<freq> BB:200 => BB:198 probability = 0.96007
 #<freq> BB:200 => BB:205 probability = 0.03993
 #<freq>
	.loc	1 111 22
	ldc1 $f15,-8($4)              	# [0]  
	.loc	1 114 22
	nmsub.d $f3,$f9,$f14,$f7      	# [1]  
	sdc1 $f1,-8($2)               	# [1]  
	.loc	1 113 22
	madd.d $f2,$f14,$f9,$f7       	# [2]  
	sdc1 $f0,-8($1)               	# [2]  
	.loc	1 114 22
	nmsub.d $f0,$f12,$f10,$f7     	# [3]  
	.loc	1 113 22
	sdc1 $f4,0($1)                	# [3]  
	madd.d $f1,$f10,$f12,$f7      	# [4]  
	.loc	1 114 22
	sdc1 $f5,0($2)                	# [4]  
	madd.d $f5,$f14,$f3,$f8       	# [5]  
	pref 1,248($3)                	# [5]  
	.loc	1 113 22
	nmsub.d $f4,$f9,$f2,$f8       	# [6]  
	ldc1 $f6,16($5)               	# [6]  
	.loc	1 114 22
	madd.d $f0,$f10,$f0,$f8       	# [7]  
	.loc	1 111 22
	ldc1 $f9,16($4)               	# [7]  
	.loc	1 113 22
	nmsub.d $f3,$f12,$f1,$f8      	# [8]  
	ldc1 $f10,8($5)               	# [8]  
	.loc	1 114 22
	nmsub.d $f2,$f11,$f16,$f7     	# [9]  
	.loc	1 111 22
	ldc1 $f12,8($4)               	# [9]  
	.loc	1 113 22
	madd.d $f1,$f16,$f11,$f7      	# [10]  
	.loc	1 114 22
	sdc1 $f0,8($2)                	# [10]  
	nmsub.d $f0,$f15,$f13,$f7     	# [11]  
	.loc	1 113 22
	sdc1 $f3,8($1)                	# [11]  
	madd.d $f3,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($1)               	# [12]  
	.loc	1 114 22
	madd.d $f2,$f16,$f2,$f8       	# [13]  
	sdc1 $f5,16($2)               	# [13]  
	.loc	1 113 22
	nmsub.d $f4,$f11,$f1,$f8      	# [14]  
	.loc	1 110 19
	addiu $2,$3,32                	# [14]  
	.loc	1 113 22
	ldc1 $f5,0($3)                	# [14]  
	.loc	1 114 22
	madd.d $f1,$f13,$f0,$f8       	# [15]  
	.loc	1 111 22
	ldc1 $f11,0($6)               	# [15]  
	.loc	1 113 22
	nmsub.d $f0,$f15,$f3,$f8      	# [16]  
	.loc	1 110 19
	addiu $1,$6,32                	# [16]  
	bne $5,$7,.BB198.jacobi_      	# [16]  
	.loc	1 113 22
	ldc1 $f13,-8($3)              	# [16]  
.BB205.jacobi_: 	 # 0x1da8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:205 frequency = 1029.47937 (heuristic)
 #<freq>
	mov.d $f14,$f6                	# [0]  
	mov.d $f15,$f1                	# [1]  
	mov.d $f17,$f0                	# [2]  
	mov.d $f31,$f2                	# [3]  
	or $10,$3,$0                  	# [4]  
	or $12,$5,$0                  	# [4]  
	mov.d $f16,$f5                	# [4]  
	or $13,$6,$0                  	# [5]  
	or $14,$4,$0                  	# [5]  
	mov.d $f5,$f31                	# [5]  
.BB204.jacobi_: 	 # 0x1dd0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:204 frequency = 3088.43823 (heuristic)
 #<freq>
	.loc	1 114 22
	nmsub.d $f7,$f11,$f16,$f24    	# [0]  
	.loc	1 111 22
	ldc1 $f21,-8($13)             	# [0]  
	.loc	1 113 22
	madd.d $f18,$f16,$f11,$f24    	# [1]  
	.loc	1 114 22
	sdc1 $f15,-8($12)             	# [2]  
	nmsub.d $f27,$f9,$f14,$f24    	# [3]  
	.loc	1 113 22
	sdc1 $f4,0($14)               	# [3]  
	.loc	1 114 22
	madd.d $f7,$f16,$f7,$f26      	# [4]  
	.loc	1 113 22
	sdc1 $f17,-8($14)             	# [4]  
	nmsub.d $f18,$f11,$f18,$f26   	# [5]  
	.loc	1 114 22
	sdc1 $f5,0($12)               	# [5]  
	.loc	1 113 22
	madd.d $f30,$f10,$f12,$f24    	# [6]  
	ldc1 $f3,8($10)               	# [6]  
	.loc	1 114 22
	madd.d $f27,$f14,$f27,$f26    	# [7]  
	.loc	1 111 22
	ldc1 $f1,16($13)              	# [7]  
	.loc	1 113 22
	madd.d $f28,$f14,$f9,$f24     	# [8]  
	.loc	1 111 22
	ldc1 $f2,8($13)               	# [8]  
	.loc	1 114 22
	nmsub.d $f31,$f12,$f10,$f24   	# [9]  
	.loc	1 113 22
	ldc1 $f0,16($10)              	# [9]  
	nmsub.d $f30,$f12,$f30,$f26   	# [10]  
	.loc	1 114 22
	nmsub.d $f25,$f21,$f13,$f24   	# [11]  
	.loc	1 113 22
	madd.d $f29,$f13,$f21,$f24    	# [12]  
	.loc	1 114 22
	madd.d $f31,$f10,$f31,$f26    	# [13]  
	.loc	1 113 22
	nmsub.d $f28,$f9,$f28,$f26    	# [14]  
	.loc	1 114 22
	madd.d $f25,$f13,$f25,$f26    	# [15]  
	sdc1 $f31,8($12)              	# [16]  
	.loc	1 113 22
	nmsub.d $f21,$f21,$f29,$f26   	# [16]  
	sdc1 $f28,16($14)             	# [17]  
	.loc	1 114 22
	nmsub.d $f23,$f2,$f3,$f24     	# [17]  
	.loc	1 113 22
	sdc1 $f30,8($14)              	# [18]  
	madd.d $f8,$f0,$f1,$f24       	# [18]  
	.loc	1 114 22
	sdc1 $f27,16($12)             	# [19]  
	.loc	1 113 22
	madd.d $f19,$f3,$f2,$f24      	# [19]  
	.loc	1 114 22
	sdc1 $f25,-8($10)             	# [20]  
	nmsub.d $f6,$f1,$f0,$f24      	# [20]  
	.loc	1 113 22
	sdc1 $f18,0($13)              	# [21]  
	.loc	1 114 22
	madd.d $f3,$f3,$f23,$f26      	# [21]  
	.loc	1 113 22
	sdc1 $f21,-8($13)             	# [22]  
	nmsub.d $f1,$f1,$f8,$f26      	# [22]  
	.loc	1 114 22
	sdc1 $f7,0($10)               	# [23]  
	.loc	1 113 22
	nmsub.d $f2,$f2,$f19,$f26     	# [23]  
	.loc	1 114 22
	madd.d $f0,$f0,$f6,$f26       	# [24]  
	sdc1 $f3,8($10)               	# [24]  
	.loc	1 113 22
	sdc1 $f1,16($13)              	# [25]  
	sdc1 $f2,8($13)               	# [26]  
	.loc	1 114 22
	sdc1 $f0,16($10)              	# [27]  
.BB191.jacobi_: 	 # 0x1e84
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:191 frequency = 3217.12329 (heuristic)
 #<freq>
.L.1.90.temp: 	 # 0x1e84
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:60 frequency = 3466.77686 (heuristic)
 #<freq> BB:60 => BB:65 probability = 0.28947
 #<freq> BB:60 => BB:61 probability = 0.71053
 #<freq>
	ld $1,2112($sp)               	# [0]  .gra_spill_b056
	.loc	1 110 19
	ld $12,2232($sp)              	# [2]  .gra_spill_b071
	slt $1,$1,$20                 	# [2]  
	ld $5,2040($sp)               	# [3]  .gra_spill_b047
	beq $1,$0,.L.1.97.temp        	# [4]  
	ld $10,2272($sp)              	# [4]  .gra_spill_b076
.L.1.99.temp: 	 # 0x1e9c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:61 frequency = 2463.23608 (heuristic)
 #<freq> BB:61 => BB:210 probability = 0.25000
 #<freq> BB:61 => BB:63 probability = 0.75000
 #<freq>
	ld $1,2136($sp)               	# [0]  .gra_spill_b059
	ld $13,2032($sp)              	# [1]  .gra_spill_b046
	andi $6,$10,3                 	# [2]  
	sra $14,$10,2                 	# [3]  
	addu $13,$13,$1               	# [3]  
	beq $6,$0,.BB210.jacobi_      	# [4]  
	addu $12,$12,$1               	# [4]  
.L.1.100.temp: 	 # 0x1eb8
 #<loop> Loop body line 110, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 3 iterations)
 #<sched> 
 #<sched> Loop schedule length: 21 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     8 flops        ( 19% of peak) (madds count as 2)
 #<sched>     4 flops        (  9% of peak) (madds count as 1)
 #<sched>     4 madds        ( 19% of peak)
 #<sched>     6 mem refs     ( 28% of peak)
 #<sched>     5 integer ops  ( 11% of peak)
 #<sched>    15 instructions ( 17% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:63 frequency = 3694.85400 (heuristic)
 #<freq> BB:63 => BB:63 probability = 0.50000
 #<freq> BB:63 => BB:210 probability = 0.50000
 #<freq>
	.loc	1 117 22
	ldc1 $f1,-8($13)              	# [0]  
	.loc	1 120 22
	pref 1,248($12)               	# [1]  
	.loc	1 119 22
	ldc1 $f0,-8($12)              	# [2]  
	madd.d $f31,$f0,$f1,$f24      	# [12]  
	.loc	1 120 22
	nmsub.d $f2,$f1,$f0,$f24      	# [13]  
	.loc	1 119 22
	nmsub.d $f1,$f1,$f31,$f26     	# [16]  
	.loc	1 120 22
	madd.d $f0,$f0,$f2,$f26       	# [17]  
	addi $6,$6,-1                 	# [18]  
	.loc	1 116 19
	ld $1,2096($sp)               	# [18]  .gra_spill_b054
	addiu $5,$5,1                 	# [19]  
	addiu $12,$12,8               	# [19]  
	.loc	1 119 22
	sdc1 $f1,-8($13)              	# [19]  
	.loc	1 116 19
	addu $13,$1,$13               	# [20]  
	bne $6,$0,.L.1.100.temp       	# [20]  
	.loc	1 120 22
	sdc1 $f0,-16($12)             	# [20]  
.BB210.jacobi_: 	 # 0x1ef4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:210 frequency = 2463.23608 (heuristic)
 #<freq> BB:210 => BB:208 probability = 0.04000
 #<freq> BB:210 => BB:213 probability = 0.96000
 #<freq>
	or $6,$5,$0                   	# [0]  
	or $8,$13,$0                  	# [0]  
	beq $14,$0,.BB208.jacobi_     	# [1]  
	or $9,$12,$0                  	# [1]  
.BB213.jacobi_: 	 # 0x1f04
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 short trip count test (<= 3)
 #<swp> 
 #<freq>
 #<freq> BB:213 frequency = 2364.70654 (heuristic)
 #<freq> BB:213 => BB:219 probability = 0.00000
 #<freq> BB:213 => BB:218 probability = 1.00000
 #<freq>
	slti $2,$14,4                 	# [0]  
	bne $2,$0,.BB219.jacobi_      	# [2]  
	or $10,$6,$0                  	# [0]  
.BB218.jacobi_: 	 # 0x1f10
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:218 frequency = 2364.70654 (heuristic)
 #<freq>
	pref 1,248($9)                	# [0]  
	.loc	1 119 22
	ldc1 $f17,-8($9)              	# [1]  
	.loc	1 116 19
	ld $15,2096($sp)              	# [2]  .gra_spill_b054
	.loc	1 119 22
	ldc1 $f13,0($9)               	# [3]  
	.loc	1 117 22
	ldc1 $f9,-8($8)               	# [4]  
	.loc	1 116 19
	addu $7,$15,$8                	# [4]  
	.loc	1 117 22
	ldc1 $f14,-8($7)              	# [5]  
	.loc	1 119 22
	ldc1 $f5,16($9)               	# [6]  
	.loc	1 116 19
	addu $10,$15,$7               	# [6]  
	.loc	1 119 22
	ldc1 $f12,8($9)               	# [7]  
	.loc	1 116 19
	addu $11,$15,$10              	# [7]  
	.loc	1 117 22
	ldc1 $f27,-8($11)             	# [8]  
	ldc1 $f4,-8($10)              	# [9]  
	.loc	1 119 22
	madd.d $f15,$f17,$f9,$f24     	# [15]  
	.loc	1 120 22
	nmsub.d $f6,$f14,$f13,$f24    	# [16]  
	.loc	1 119 22
	madd.d $f19,$f13,$f14,$f24    	# [17]  
	.loc	1 120 22
	nmsub.d $f29,$f4,$f12,$f24    	# [18]  
	ld $5,2192($sp)               	# [19]  .gra_spill_b066
	.loc	1 116 19
	addiu $4,$9,32                	# [19]  
	.loc	1 120 22
	nmsub.d $f8,$f27,$f5,$f24     	# [19]  
	.loc	1 119 22
	ldc1 $f23,16($4)              	# [20]  
	.loc	1 116 19
	addu $3,$15,$11               	# [20]  
	.loc	1 119 22
	madd.d $f2,$f5,$f27,$f24      	# [20]  
	ldc1 $f21,8($4)               	# [21]  
	.loc	1 116 19
	addu $2,$15,$3                	# [21]  
	.loc	1 119 22
	madd.d $f7,$f12,$f4,$f24      	# [21]  
	ldc1 $f25,0($4)               	# [22]  
	.loc	1 116 19
	addu $13,$15,$2               	# [22]  
	.loc	1 120 22
	madd.d $f12,$f12,$f29,$f26    	# [22]  
	.loc	1 119 22
	ldc1 $f18,-8($4)              	# [23]  
	.loc	1 116 19
	addu $12,$15,$13              	# [23]  
	.loc	1 120 22
	madd.d $f5,$f5,$f8,$f26       	# [23]  
	.loc	1 117 22
	ldc1 $f11,-8($3)              	# [24]  
	.loc	1 116 19
	addu $31,$15,$12              	# [24]  
	mov.d $f8,$f26                	# [24]  
	addiu $1,$6,12                	# [25]  
	.loc	1 117 22
	ldc1 $f10,-8($31)             	# [25]  
	.loc	1 119 22
	nmsub.d $f4,$f4,$f7,$f26      	# [25]  
	.loc	1 116 19
	addiu $6,$4,32                	# [26]  
	addu $24,$15,$31              	# [26]  
	.loc	1 117 22
	ldc1 $f29,-8($2)              	# [26]  
	mov.d $f7,$f24                	# [26]  
	nop                           	# [26]  
	nop                           	# [26]  
.BB215.jacobi_: 	 # 0x1fc0
 #<loop> Loop body line 110, nesting depth: 4, estimated iterations: 8
 #<loop> Unrolled 4 times
 #<swps> 
 #<swps> Pipelined loop line 110 steady state
 #<swps> 
 #<swps>    25 estimated iterations before pipelining
 #<swps>     4 unrollings before pipelining
 #<swps>    17 cycles per 4 iterations
 #<swps>    32 flops        ( 94% of peak) (madds count as 2)
 #<swps>    16 flops        ( 47% of peak) (madds count as 1)
 #<swps>    16 madds        ( 94% of peak)
 #<swps>    16 mem refs     ( 94% of peak)
 #<swps>     7 integer ops  ( 20% of peak)
 #<swps>    39 instructions ( 57% of peak)
 #<swps>     3 short trip threshold
 #<swps>    18 integer registers used.
 #<swps>    31 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 110 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:215 frequency = 21315.20312 (heuristic)
 #<freq> BB:215 => BB:224 probability = 0.03698
 #<freq> BB:215 => BB:216 probability = 0.96302
 #<freq>
	.loc	1 119 22
	nmsub.d $f1,$f27,$f2,$f8      	# [0]  
	.loc	1 116 19
	addu $25,$15,$24              	# [0]  
	.loc	1 120 22
	madd.d $f3,$f13,$f6,$f8       	# [1]  
	.loc	1 116 19
	addu $14,$15,$25              	# [1]  
	.loc	1 117 22
	ldc1 $f13,-8($13)             	# [1]  
	.loc	1 119 22
	nmsub.d $f2,$f14,$f19,$f8     	# [2]  
	.loc	1 117 22
	ldc1 $f27,-8($12)             	# [2]  
	.loc	1 120 22
	nmsub.d $f0,$f9,$f17,$f7      	# [3]  
	.loc	1 119 22
	sdc1 $f1,-8($11)              	# [3]  
	madd.d $f14,$f18,$f11,$f7     	# [4]  
	sdc1 $f4,-8($10)              	# [4]  
	nmsub.d $f1,$f9,$f15,$f8      	# [5]  
	.loc	1 120 22
	sdc1 $f5,16($9)               	# [5]  
	sdc1 $f12,8($9)               	# [6]  
	madd.d $f0,$f17,$f0,$f8       	# [7]  
	sdc1 $f3,0($9)                	# [7]  
	.loc	1 119 22
	madd.d $f19,$f25,$f29,$f7     	# [8]  
	sdc1 $f1,-8($8)               	# [8]  
	.loc	1 120 22
	nmsub.d $f6,$f29,$f25,$f7     	# [9]  
	.loc	1 119 22
	sdc1 $f2,-8($7)               	# [9]  
	.loc	1 120 22
	nmsub.d $f3,$f13,$f21,$f7     	# [10]  
	sdc1 $f0,-8($9)               	# [10]  
	nmsub.d $f2,$f27,$f23,$f7     	# [11]  
	.loc	1 119 22
	ldc1 $f12,-8($6)              	# [11]  
	madd.d $f1,$f21,$f13,$f7      	# [12]  
	.loc	1 117 22
	ldc1 $f15,-8($24)             	# [12]  
	.loc	1 119 22
	madd.d $f0,$f23,$f27,$f7      	# [13]  
	ldc1 $f16,0($6)               	# [13]  
	.loc	1 120 22
	madd.d $f17,$f21,$f3,$f8      	# [14]  
	.loc	1 116 19
	addiu $1,$1,4                 	# [14]  
	.loc	1 119 22
	ldc1 $f21,8($6)               	# [14]  
	.loc	1 120 22
	madd.d $f5,$f23,$f2,$f8       	# [15]  
	.loc	1 116 19
	addiu $9,$6,32                	# [15]  
	addu $8,$15,$14               	# [15]  
	.loc	1 119 22
	ldc1 $f23,16($6)              	# [15]  
	nmsub.d $f4,$f13,$f1,$f8      	# [16]  
	.loc	1 116 19
	addu $7,$15,$8                	# [16]  
	beq $1,$5,.BB224.jacobi_      	# [16]  
	.loc	1 117 22
	ldc1 $f9,-8($8)               	# [16]  
.BB216.jacobi_: 	 # 0x205c
 #<loop> Part of loop body line 110, head labeled .BB215.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 110 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:216 frequency = 20526.96680 (heuristic)
 #<freq> BB:216 => BB:223 probability = 0.03840
 #<freq> BB:216 => BB:217 probability = 0.96160
 #<freq>
	.loc	1 119 22
	nmsub.d $f1,$f27,$f0,$f8      	# [0]  
	.loc	1 116 19
	addu $10,$15,$7               	# [0]  
	.loc	1 120 22
	madd.d $f3,$f25,$f6,$f8       	# [1]  
	.loc	1 116 19
	addu $11,$15,$10              	# [1]  
	.loc	1 117 22
	ldc1 $f25,-8($25)             	# [1]  
	.loc	1 119 22
	nmsub.d $f2,$f29,$f19,$f8     	# [2]  
	.loc	1 117 22
	ldc1 $f27,-8($14)             	# [2]  
	.loc	1 120 22
	nmsub.d $f0,$f11,$f18,$f7     	# [3]  
	.loc	1 119 22
	sdc1 $f1,-8($12)              	# [3]  
	madd.d $f19,$f12,$f10,$f7     	# [4]  
	sdc1 $f4,-8($13)              	# [4]  
	nmsub.d $f1,$f11,$f14,$f8     	# [5]  
	.loc	1 120 22
	sdc1 $f5,16($4)               	# [5]  
	sdc1 $f17,8($4)               	# [6]  
	madd.d $f0,$f18,$f0,$f8       	# [7]  
	sdc1 $f3,0($4)                	# [7]  
	.loc	1 119 22
	madd.d $f18,$f16,$f15,$f7     	# [8]  
	sdc1 $f1,-8($3)               	# [8]  
	.loc	1 120 22
	nmsub.d $f6,$f15,$f16,$f7     	# [9]  
	.loc	1 119 22
	sdc1 $f2,-8($2)               	# [9]  
	.loc	1 120 22
	nmsub.d $f3,$f25,$f21,$f7     	# [10]  
	sdc1 $f0,-8($4)               	# [10]  
	nmsub.d $f2,$f27,$f23,$f7     	# [11]  
	.loc	1 119 22
	ldc1 $f17,-8($9)              	# [11]  
	madd.d $f1,$f21,$f25,$f7      	# [12]  
	.loc	1 117 22
	ldc1 $f14,-8($7)              	# [12]  
	.loc	1 119 22
	madd.d $f0,$f23,$f27,$f7      	# [13]  
	ldc1 $f13,0($9)               	# [13]  
	.loc	1 120 22
	madd.d $f29,$f21,$f3,$f8      	# [14]  
	.loc	1 116 19
	addiu $1,$1,4                 	# [14]  
	.loc	1 119 22
	ldc1 $f21,8($9)               	# [14]  
	.loc	1 120 22
	madd.d $f5,$f23,$f2,$f8       	# [15]  
	.loc	1 116 19
	addiu $4,$9,32                	# [15]  
	addu $3,$15,$11               	# [15]  
	.loc	1 119 22
	ldc1 $f23,16($9)              	# [15]  
	nmsub.d $f4,$f25,$f1,$f8      	# [16]  
	.loc	1 116 19
	addu $2,$15,$3                	# [16]  
	beq $1,$5,.BB223.jacobi_      	# [16]  
	.loc	1 117 22
	ldc1 $f11,-8($3)              	# [16]  
.BB217.jacobi_: 	 # 0x20f8
 #<loop> Part of loop body line 110, head labeled .BB215.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 110 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:217 frequency = 19738.73242 (heuristic)
 #<freq> BB:217 => BB:215 probability = 0.96007
 #<freq> BB:217 => BB:222 probability = 0.03993
 #<freq>
	.loc	1 119 22
	nmsub.d $f1,$f27,$f0,$f8      	# [0]  
	.loc	1 120 22
	pref 1,248($4)                	# [0]  
	.loc	1 116 19
	addu $13,$15,$2               	# [0]  
	.loc	1 120 22
	madd.d $f3,$f16,$f6,$f8       	# [1]  
	.loc	1 116 19
	addu $12,$15,$13              	# [1]  
	.loc	1 117 22
	ldc1 $f16,-8($10)             	# [1]  
	.loc	1 119 22
	nmsub.d $f2,$f15,$f18,$f8     	# [2]  
	.loc	1 117 22
	ldc1 $f27,-8($11)             	# [2]  
	.loc	1 120 22
	nmsub.d $f0,$f10,$f12,$f7     	# [3]  
	.loc	1 119 22
	sdc1 $f1,-8($14)              	# [3]  
	madd.d $f15,$f17,$f9,$f7      	# [4]  
	sdc1 $f4,-8($25)              	# [4]  
	nmsub.d $f1,$f10,$f19,$f8     	# [5]  
	.loc	1 120 22
	sdc1 $f5,16($6)               	# [5]  
	sdc1 $f29,8($6)               	# [6]  
	madd.d $f0,$f12,$f0,$f8       	# [7]  
	sdc1 $f3,0($6)                	# [7]  
	.loc	1 119 22
	madd.d $f19,$f13,$f14,$f7     	# [8]  
	sdc1 $f1,-8($31)              	# [8]  
	.loc	1 120 22
	nmsub.d $f6,$f14,$f13,$f7     	# [9]  
	.loc	1 119 22
	sdc1 $f2,-8($24)              	# [9]  
	.loc	1 120 22
	nmsub.d $f1,$f16,$f21,$f7     	# [10]  
	sdc1 $f0,-8($6)               	# [10]  
	nmsub.d $f0,$f27,$f23,$f7     	# [11]  
	.loc	1 119 22
	ldc1 $f18,-8($4)              	# [11]  
	madd.d $f3,$f21,$f16,$f7      	# [12]  
	.loc	1 117 22
	ldc1 $f29,-8($2)              	# [12]  
	.loc	1 119 22
	madd.d $f2,$f23,$f27,$f7      	# [13]  
	ldc1 $f25,0($4)               	# [13]  
	.loc	1 120 22
	madd.d $f12,$f21,$f1,$f8      	# [14]  
	.loc	1 116 19
	addiu $1,$1,4                 	# [14]  
	.loc	1 119 22
	ldc1 $f21,8($4)               	# [14]  
	.loc	1 120 22
	madd.d $f5,$f23,$f0,$f8       	# [15]  
	.loc	1 116 19
	addiu $6,$4,32                	# [15]  
	addu $31,$15,$12              	# [15]  
	.loc	1 119 22
	ldc1 $f23,16($4)              	# [15]  
	nmsub.d $f4,$f16,$f3,$f8      	# [16]  
	.loc	1 116 19
	addu $24,$15,$31              	# [16]  
	bne $1,$5,.BB215.jacobi_      	# [16]  
	.loc	1 117 22
	ldc1 $f10,-8($31)             	# [16]  
.BB222.jacobi_: 	 # 0x2198
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:222 frequency = 788.23553 (heuristic)
 #<freq>
	mov.d $f16,$f13               	# [0]  
	mov.d $f0,$f18                	# [1]  
	mov.d $f18,$f17               	# [2]  
	or $5,$31,$0                  	# [2]  
	or $31,$3,$0                  	# [3]  
	or $18,$9,$0                  	# [3]  
	mov.d $f1,$f10                	# [3]  
	or $15,$13,$0                 	# [4]  
	or $13,$8,$0                  	# [4]  
	mov.d $f10,$f11               	# [4]  
	or $16,$10,$0                 	# [5]  
	mov.d $f11,$f9                	# [5]  
	or $17,$11,$0                 	# [5]  
	or $11,$7,$0                  	# [6]  
	or $25,$2,$0                  	# [6]  
	mov.d $f31,$f2                	# [6]  
	or $7,$25,$0                  	# [7]  
	or $14,$1,$0                  	# [7]  
	sd $14,2256($sp)              	# [7]  .gra_spill_b074
	mov.d $f9,$f1                 	# [7]  
	sdc1 $f24,1744($sp)           	# [8]  .gra_spill_b010
	or $10,$15,$0                 	# [8]  
	or $14,$4,$0                  	# [8]  
	mov.d $f17,$f0                	# [8]  
	sdc1 $f26,1736($sp)           	# [9]  .gra_spill_b009
	or $8,$5,$0                   	# [9]  
	mov.d $f13,$f31               	# [9]  
	or $9,$14,$0                  	# [9]  
.BB221.jacobi_: 	 # 0x2208
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:221 frequency = 2364.70654 (heuristic)
 #<freq>
	ldc1 $f20,1736($sp)           	# [0]  .gra_spill_b009
	ldc1 $f24,-8($12)             	# [2]  
	.loc	1 120 22
	ldc1 $f1,1744($sp)            	# [3]  .gra_spill_b010
	.loc	1 119 22
	nmsub.d $f30,$f27,$f13,$f20   	# [3]  
	.loc	1 117 22
	ldc1 $f28,-8($10)             	# [4]  
	.loc	1 120 22
	madd.d $f0,$f16,$f6,$f20      	# [5]  
	nmsub.d $f26,$f11,$f18,$f1    	# [6]  
	.loc	1 119 22
	sdc1 $f30,-8($17)             	# [6]  
	sdc1 $f4,-8($16)              	# [7]  
	nmsub.d $f31,$f11,$f15,$f20   	# [8]  
	.loc	1 120 22
	sdc1 $f0,0($18)               	# [8]  
	.loc	1 119 22
	nmsub.d $f30,$f14,$f19,$f20   	# [9]  
	.loc	1 120 22
	sdc1 $f12,8($18)              	# [9]  
	madd.d $f26,$f18,$f26,$f20    	# [10]  
	sdc1 $f5,16($18)              	# [10]  
	.loc	1 119 22
	sdc1 $f31,-8($13)             	# [11]  
	sdc1 $f30,-8($11)             	# [12]  
	.loc	1 120 22
	sdc1 $f26,-8($18)             	# [13]  
	.loc	1 119 22
	ldc1 $f2,-8($6)               	# [14]  
	.loc	1 117 22
	ldc1 $f3,-8($24)              	# [16]  
	.loc	1 119 22
	ldc1 $f8,0($6)                	# [18]  
	.loc	1 116 19
	ld $3,2096($sp)               	# [20]  .gra_spill_b054
	.loc	1 119 22
	ldc1 $f30,8($6)               	# [21]  
	.loc	1 116 19
	addu $2,$3,$24                	# [22]  
	.loc	1 117 22
	ldc1 $f31,-8($2)              	# [23]  
	.loc	1 120 22
	nmsub.d $f22,$f9,$f2,$f1      	# [25]  
	.loc	1 119 22
	madd.d $f26,$f8,$f3,$f1       	# [27]  
	madd.d $f7,$f2,$f9,$f1        	# [28]  
	.loc	1 120 22
	madd.d $f2,$f2,$f22,$f20      	# [29]  
	nmsub.d $f22,$f3,$f8,$f1      	# [30]  
	.loc	1 119 22
	nmsub.d $f3,$f3,$f26,$f20     	# [31]  
	.loc	1 120 22
	nmsub.d $f26,$f31,$f30,$f1    	# [32]  
	.loc	1 119 22
	madd.d $f0,$f30,$f31,$f1      	# [35]  
	.loc	1 120 22
	madd.d $f30,$f30,$f26,$f20    	# [36]  
	.loc	1 119 22
	madd.d $f26,$f23,$f24,$f1     	# [37]  
	.loc	1 116 19
	addu $3,$3,$2                 	# [40]  
	.loc	1 119 22
	nmsub.d $f31,$f31,$f0,$f20    	# [40]  
	.loc	1 117 22
	ldc1 $f0,-8($3)               	# [41]  
	.loc	1 119 22
	nmsub.d $f26,$f24,$f26,$f20   	# [41]  
	.loc	1 120 22
	madd.d $f8,$f8,$f22,$f20      	# [42]  
	.loc	1 119 22
	ldc1 $f22,16($6)              	# [42]  
	sdc1 $f26,-8($12)             	# [44]  
	madd.d $f26,$f21,$f28,$f1     	# [44]  
	.loc	1 120 22
	nmsub.d $f24,$f24,$f23,$f1    	# [47]  
	.loc	1 119 22
	nmsub.d $f26,$f28,$f26,$f20   	# [48]  
	.loc	1 120 22
	nmsub.d $f28,$f28,$f21,$f1    	# [49]  
	madd.d $f24,$f23,$f24,$f20    	# [52]  
	madd.d $f28,$f21,$f28,$f20    	# [53]  
	.loc	1 119 22
	sdc1 $f26,-8($10)             	# [54]  
	.loc	1 120 22
	nmsub.d $f26,$f29,$f25,$f1    	# [54]  
	sdc1 $f24,16($9)              	# [55]  
	.loc	1 119 22
	madd.d $f24,$f17,$f10,$f1     	# [55]  
	.loc	1 120 22
	sdc1 $f28,8($9)               	# [57]  
	nmsub.d $f28,$f0,$f22,$f1     	# [57]  
	madd.d $f26,$f25,$f26,$f20    	# [58]  
	.loc	1 119 22
	nmsub.d $f24,$f10,$f24,$f20   	# [59]  
	.loc	1 120 22
	madd.d $f28,$f22,$f28,$f20    	# [61]  
	sdc1 $f26,0($9)               	# [61]  
	.loc	1 119 22
	sdc1 $f24,-8($31)             	# [62]  
	madd.d $f24,$f25,$f29,$f1     	# [62]  
	madd.d $f22,$f22,$f0,$f1      	# [63]  
	.loc	1 120 22
	nmsub.d $f1,$f10,$f17,$f1     	# [64]  
	.loc	1 119 22
	nmsub.d $f7,$f9,$f7,$f20      	# [65]  
	ldc1 $f26,1736($sp)           	# [66]  .gra_spill_b009
	nmsub.d $f24,$f29,$f24,$f20   	# [66]  
	nmsub.d $f0,$f0,$f22,$f20     	# [67]  
	ldc1 $f22,%gp_rel(.lit8-30696)($gp)	# [67]  
	.loc	1 120 22
	madd.d $f1,$f17,$f1,$f20      	# [68]  
	ldc1 $f20,%gp_rel(.lit8-30688)($gp)	# [68]  
	.loc	1 119 22
	sdc1 $f24,-8($7)              	# [69]  
	ldc1 $f24,1744($sp)           	# [70]  .gra_spill_b010
	.loc	1 120 22
	sdc1 $f1,-8($9)               	# [71]  
	.loc	1 119 22
	sdc1 $f0,-8($3)               	# [72]  
	sdc1 $f31,-8($2)              	# [73]  
	.loc	1 120 22
	sdc1 $f8,0($6)                	# [74]  
	sdc1 $f28,16($6)              	# [75]  
	sdc1 $f30,8($6)               	# [76]  
	.loc	1 119 22
	sdc1 $f7,-8($8)               	# [77]  
	sdc1 $f3,-8($24)              	# [78]  
	addiu $17,$0,16               	# [79]  
	.loc	1 120 22
	sdc1 $f2,-8($6)               	# [79]  
.BB208.jacobi_: 	 # 0x234c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:208 frequency = 2463.23608 (heuristic)
 #<freq>
.L.1.97.temp: 	 # 0x234c
.L.1.96.temp: 	 # 0x234c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:65 frequency = 3466.77686 (heuristic)
 #<freq> BB:65 => BB:70 probability = 0.28947
 #<freq> BB:65 => BB:66 probability = 0.71053
 #<freq>
	ld $9,2024($sp)               	# [0]  .gra_spill_b045
	ld $4,2128($sp)               	# [1]  .gra_spill_b058
	.loc	1 116 19
	ld $2,2136($sp)               	# [2]  .gra_spill_b059
	ld $13,2240($sp)              	# [3]  .gra_spill_b072
	slt $4,$20,$4                 	# [3]  
	mov.d $f8,$f26                	# [4]  
	ld $18,2248($sp)              	# [4]  .gra_spill_b073
	mov.d $f7,$f24                	# [5]  
	.loc	1 122 19
	ld $8,2208($sp)               	# [5]  .gra_spill_b068
	.loc	1 116 19
	beq $4,$0,.L.1.103.temp       	# [5]  
	addu $13,$20,$13              	# [5]  
.L.1.105.temp: 	 # 0x2378
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 short trip count test (<= 5)
 #<swp> 
 #<freq>
 #<freq> BB:66 frequency = 2463.23608 (heuristic)
 #<freq> BB:66 => BB:68 probability = 0.00000
 #<freq> BB:66 => BB:231 probability = 1.00000
 #<freq>
	ld $1,2280($sp)               	# [0]  .gra_spill_b077
	sll $13,$13,3                 	# [2]  
	ld $12,2216($sp)              	# [2]  .gra_spill_b069
	slti $1,$1,6                  	# [2]  
	addu $13,$13,$2               	# [3]  
	bne $1,$0,.L.1.106.temp       	# [4]  
	addu $12,$12,$2               	# [4]  
.BB231.jacobi_: 	 # 0x2394
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:231 frequency = 2463.23608 (heuristic)
 #<freq>
	ld $11,2104($sp)              	# [0]  .gra_spill_b055
	.loc	1 123 22
	ldc1 $f0,-8($12)              	# [1]  
	.loc	1 126 22
	pref 1,1592($13)              	# [2]  
	.loc	1 122 19
	addu $7,$11,$13               	# [3]  
	.loc	1 125 22
	ldc1 $f1,-8($13)              	# [3]  
	.loc	1 126 22
	pref 1,1592($7)               	# [4]  
	.loc	1 125 22
	ldc1 $f16,-8($7)              	# [5]  
	.loc	1 122 19
	addu $6,$8,$12                	# [6]  
	.loc	1 123 22
	ldc1 $f17,-8($6)              	# [7]  
	.loc	1 122 19
	addu $4,$8,$6                 	# [11]  
	.loc	1 123 22
	ldc1 $f12,-8($4)              	# [12]  
	.loc	1 122 19
	addu $1,$8,$4                 	# [12]  
	.loc	1 123 22
	ldc1 $f6,-8($1)               	# [13]  
	.loc	1 122 19
	addu $5,$11,$7                	# [13]  
	.loc	1 125 22
	madd.d $f3,$f1,$f0,$f24       	# [13]  
	.loc	1 126 22
	pref 1,1592($5)               	# [14]  
	.loc	1 122 19
	addu $2,$11,$5                	# [14]  
	.loc	1 126 22
	nmsub.d $f2,$f0,$f1,$f24      	# [14]  
	pref 1,1592($2)               	# [15]  
	.loc	1 125 22
	ldc1 $f13,-8($5)              	# [16]  
	.loc	1 126 22
	nmsub.d $f4,$f17,$f16,$f24    	# [16]  
	.loc	1 125 22
	ldc1 $f9,-8($2)               	# [17]  
	.loc	1 122 19
	addu $14,$11,$2               	# [17]  
	.loc	1 125 22
	nmsub.d $f0,$f0,$f3,$f26      	# [17]  
	addiu $3,$18,5                	# [18]  
	.loc	1 122 19
	addu $10,$8,$1                	# [18]  
	.loc	1 126 22
	pref 1,1592($14)              	# [18]  
	madd.d $f1,$f1,$f2,$f26       	# [18]  
	nop                           	# [18]  
	nop                           	# [18]  
	nop                           	# [18]  
.BB226.jacobi_: 	 # 0x2410
 #<loop> Loop body line 116, nesting depth: 4, estimated iterations: 19
 #<swps> 
 #<swps> Pipelined loop line 116 steady state
 #<swps> 
 #<swps>   100 estimated iterations before pipelining
 #<swps>       Not unrolled before pipelining
 #<swps>     5 cycles per iteration
 #<swps>     8 flops        ( 80% of peak) (madds count as 2)
 #<swps>     4 flops        ( 40% of peak) (madds count as 1)
 #<swps>     4 madds        ( 80% of peak)
 #<swps>     5 mem refs     (100% of peak)
 #<swps>     4 integer ops  ( 40% of peak)
 #<swps>    13 instructions ( 65% of peak)
 #<swps>     5 short trip threshold
 #<swps>    14 integer registers used.
 #<swps>    18 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 116 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:226 frequency = 50250.01562 (heuristic)
 #<freq> BB:226 => BB:239 probability = 0.00980
 #<freq> BB:226 => BB:227 probability = 0.99020
 #<freq>
	.loc	1 125 22
	madd.d $f2,$f16,$f17,$f7      	# [0]  
	ldc1 $f15,-8($14)             	# [0]  
	.loc	1 126 22
	sdc1 $f1,-8($13)              	# [1]  
	nmsub.d $f14,$f12,$f13,$f7    	# [2]  
	.loc	1 125 22
	sdc1 $f0,-8($12)              	# [2]  
	.loc	1 122 19
	addiu $3,$3,1                 	# [2]  
	.loc	1 126 22
	madd.d $f1,$f16,$f4,$f8       	# [3]  
	.loc	1 122 19
	addu $13,$11,$14              	# [3]  
	.loc	1 123 22
	ldc1 $f11,-8($10)             	# [3]  
	.loc	1 125 22
	nmsub.d $f0,$f17,$f2,$f8      	# [4]  
	.loc	1 126 22
	pref 1,1592($13)              	# [4]  
	.loc	1 122 19
	beq $3,$9,.BB239.jacobi_      	# [4]  
	addu $12,$8,$10               	# [4]  
.BB227.jacobi_: 	 # 0x2444
 #<loop> Part of loop body line 116, head labeled .BB226.jacobi_
 #<swp> 
 #<swp> Pipelined loop line 116 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:227 frequency = 49757.36719 (heuristic)
 #<freq> BB:227 => BB:238 probability = 0.00990
 #<freq> BB:227 => BB:228 probability = 0.99010
 #<freq>
	.loc	1 125 22
	madd.d $f3,$f13,$f12,$f7      	# [0]  
	ldc1 $f10,-8($13)             	# [0]  
	.loc	1 126 22
	sdc1 $f1,-8($7)               	# [1]  
	nmsub.d $f2,$f6,$f9,$f7       	# [2]  
	.loc	1 125 22
	sdc1 $f0,-8($6)               	# [2]  
	.loc	1 122 19
	addiu $3,$3,1                 	# [2]  
	.loc	1 126 22
	madd.d $f1,$f13,$f14,$f8      	# [3]  
	.loc	1 122 19
	addu $7,$11,$13               	# [3]  
	.loc	1 123 22
	ldc1 $f5,-8($12)              	# [3]  
	.loc	1 125 22
	nmsub.d $f0,$f12,$f3,$f8      	# [4]  
	.loc	1 126 22
	pref 1,1592($7)               	# [4]  
	.loc	1 122 19
	beq $3,$9,.BB238.jacobi_      	# [4]  
	addu $6,$8,$12                	# [4]  
.BB228.jacobi_: 	 # 0x2478
 #<loop> Part of loop body line 116, head labeled .BB226.jacobi_
 #<swp> 
 #<swp> Pipelined loop line 116 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:228 frequency = 49264.72266 (heuristic)
 #<freq> BB:228 => BB:237 probability = 0.01000
 #<freq> BB:228 => BB:229 probability = 0.99000
 #<freq>
	.loc	1 125 22
	madd.d $f3,$f9,$f6,$f7        	# [0]  
	ldc1 $f16,-8($7)              	# [0]  
	.loc	1 126 22
	sdc1 $f1,-8($5)               	# [1]  
	nmsub.d $f4,$f11,$f15,$f7     	# [2]  
	.loc	1 125 22
	sdc1 $f0,-8($4)               	# [2]  
	.loc	1 122 19
	addiu $3,$3,1                 	# [2]  
	.loc	1 126 22
	madd.d $f1,$f9,$f2,$f8        	# [3]  
	.loc	1 122 19
	addu $5,$11,$7                	# [3]  
	.loc	1 123 22
	ldc1 $f17,-8($6)              	# [3]  
	.loc	1 125 22
	nmsub.d $f0,$f6,$f3,$f8       	# [4]  
	.loc	1 126 22
	pref 1,1592($5)               	# [4]  
	.loc	1 122 19
	beq $3,$9,.BB237.jacobi_      	# [4]  
	addu $4,$8,$6                 	# [4]  
.BB229.jacobi_: 	 # 0x24ac
 #<loop> Part of loop body line 116, head labeled .BB226.jacobi_
 #<swp> 
 #<swp> Pipelined loop line 116 replication 3
 #<swp> 
 #<freq>
 #<freq> BB:229 frequency = 48772.07422 (heuristic)
 #<freq> BB:229 => BB:236 probability = 0.01010
 #<freq> BB:229 => BB:230 probability = 0.98990
 #<freq>
	.loc	1 125 22
	madd.d $f3,$f15,$f11,$f7      	# [0]  
	ldc1 $f13,-8($5)              	# [0]  
	.loc	1 126 22
	sdc1 $f1,-8($2)               	# [1]  
	nmsub.d $f2,$f5,$f10,$f7      	# [2]  
	.loc	1 125 22
	sdc1 $f0,-8($1)               	# [2]  
	.loc	1 122 19
	addiu $3,$3,1                 	# [2]  
	.loc	1 126 22
	madd.d $f1,$f15,$f4,$f8       	# [3]  
	.loc	1 122 19
	addu $2,$11,$5                	# [3]  
	.loc	1 123 22
	ldc1 $f12,-8($4)              	# [3]  
	.loc	1 125 22
	nmsub.d $f0,$f11,$f3,$f8      	# [4]  
	.loc	1 126 22
	pref 1,1592($2)               	# [4]  
	.loc	1 122 19
	beq $3,$9,.BB236.jacobi_      	# [4]  
	addu $1,$8,$4                 	# [4]  
.BB230.jacobi_: 	 # 0x24e0
 #<loop> Part of loop body line 116, head labeled .BB226.jacobi_
 #<swp> 
 #<swp> Pipelined loop line 116 replication 4
 #<swp> 
 #<freq>
 #<freq> BB:230 frequency = 48279.42969 (heuristic)
 #<freq> BB:230 => BB:226 probability = 0.98980
 #<freq> BB:230 => BB:235 probability = 0.01020
 #<freq>
	.loc	1 125 22
	madd.d $f3,$f10,$f5,$f7       	# [0]  
	ldc1 $f9,-8($2)               	# [0]  
	.loc	1 126 22
	sdc1 $f1,-8($14)              	# [1]  
	nmsub.d $f4,$f17,$f16,$f7     	# [2]  
	.loc	1 125 22
	sdc1 $f0,-8($10)              	# [2]  
	.loc	1 122 19
	addiu $3,$3,1                 	# [2]  
	.loc	1 126 22
	madd.d $f1,$f10,$f2,$f8       	# [3]  
	.loc	1 122 19
	addu $14,$11,$2               	# [3]  
	.loc	1 123 22
	ldc1 $f6,-8($1)               	# [3]  
	.loc	1 125 22
	nmsub.d $f0,$f5,$f3,$f8       	# [4]  
	.loc	1 126 22
	pref 1,1592($14)              	# [4]  
	.loc	1 122 19
	bne $3,$9,.BB226.jacobi_      	# [4]  
	addu $10,$8,$1                	# [4]  
.BB235.jacobi_: 	 # 0x2514
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 4
 #<swp> 
 #<freq>
 #<freq> BB:235 frequency = 492.64722 (heuristic)
 #<freq>
	mov.d $f14,$f4                	# [0]  
	or $9,$10,$0                  	# [0]  
	or $10,$1,$0                  	# [1]  
	or $16,$3,$0                  	# [1]  
	mov.d $f8,$f0                 	# [1]  
	mov.d $f11,$f6                	# [2]  
	or $31,$14,$0                 	# [2]  
	or $14,$5,$0                  	# [2]  
	or $5,$13,$0                  	# [3]  
	or $25,$12,$0                 	# [3]  
	mov.d $f15,$f13               	# [3]  
	or $24,$6,$0                  	# [4]  
	or $11,$4,$0                  	# [4]  
	mov.d $f5,$f1                 	# [4]  
	mov.d $f13,$f9                	# [5]  
	or $8,$2,$0                   	# [5]  
	or $6,$11,$0                  	# [5]  
	or $12,$9,$0                  	# [6]  
	or $13,$8,$0                  	# [6]  
	mov.d $f9,$f5                 	# [6]  
	nop                           	# [6]  
	nop                           	# [6]  
	nop                           	# [6]  
.BB234.jacobi_: 	 # 0x2570
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:234 frequency = 2463.23608 (heuristic)
 #<freq>
	.loc	1 125 22
	ldc1 $f31,-8($31)             	# [0]  
	.loc	1 126 22
	sdc1 $f9,-8($5)               	# [2]  
	.loc	1 125 22
	sdc1 $f8,-8($25)              	# [3]  
	.loc	1 123 22
	ldc1 $f10,-8($12)             	# [4]  
	.loc	1 125 22
	madd.d $f0,$f13,$f11,$f24     	# [5]  
	.loc	1 126 22
	nmsub.d $f1,$f11,$f13,$f24    	# [6]  
	.loc	1 125 22
	madd.d $f3,$f15,$f12,$f24     	# [7]  
	.loc	1 126 22
	nmsub.d $f5,$f12,$f15,$f24    	# [8]  
	.loc	1 125 22
	madd.d $f6,$f16,$f17,$f24     	# [9]  
	.loc	1 126 22
	madd.d $f7,$f16,$f14,$f26     	# [10]  
	.loc	1 125 22
	nmsub.d $f3,$f12,$f3,$f26     	# [11]  
	.loc	1 126 22
	madd.d $f5,$f15,$f5,$f26      	# [12]  
	.loc	1 125 22
	nmsub.d $f6,$f17,$f6,$f26     	# [13]  
	.loc	1 126 22
	nmsub.d $f4,$f10,$f31,$f24    	# [14]  
	sdc1 $f7,-8($7)               	# [15]  
	.loc	1 125 22
	madd.d $f2,$f31,$f10,$f24     	# [15]  
	.loc	1 126 22
	madd.d $f1,$f13,$f1,$f26      	# [16]  
	.loc	1 125 22
	sdc1 $f6,-8($24)              	# [16]  
	nmsub.d $f0,$f11,$f0,$f26     	# [17]  
	.loc	1 126 22
	sdc1 $f5,-8($14)              	# [17]  
	.loc	1 125 22
	sdc1 $f3,-8($6)               	# [18]  
	.loc	1 126 22
	madd.d $f31,$f31,$f4,$f26     	# [18]  
	sdc1 $f1,-8($13)              	# [19]  
	.loc	1 125 22
	nmsub.d $f10,$f10,$f2,$f26    	# [19]  
	sdc1 $f0,-8($10)              	# [20]  
	.loc	1 126 22
	sdc1 $f31,-8($31)             	# [21]  
	.loc	1 125 22
	sdc1 $f10,-8($12)             	# [22]  
.BB225.jacobi_: 	 # 0x25dc
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:225 frequency = 2463.23608 (heuristic)
 #<freq>
.L.1.103.temp: 	 # 0x25dc
.L.1.102.temp: 	 # 0x25dc
.L.1.109.temp: 	 # 0x25dc
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:70 frequency = 3466.77686 (heuristic)
 #<freq> BB:70 => BB:242 probability = 0.25000
 #<freq> BB:70 => BB:72 probability = 0.75000
 #<freq>
	.loc	1 122 19
	ld $10,2048($sp)              	# [0]  .gra_spill_b048
	ld $14,2128($sp)              	# [1]  .gra_spill_b058
	ld $12,2080($sp)              	# [2]  .gra_spill_b052
	sra $24,$14,2                 	# [3]  
	andi $5,$14,3                 	# [3]  
	addu $12,$12,$10              	# [4]  
	addu $13,$23,$10              	# [4]  
	beq $5,$0,.BB242.jacobi_      	# [5]  
	addu $10,$30,$10              	# [5]  
.L.1.110.temp: 	 # 0x2600
 #<loop> Loop body line 122, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolling remainder loop (at most 3 iterations)
 #<sched> 
 #<sched> Loop schedule length: 21 cycles (ignoring nested loops)
 #<sched> 
 #<sched>     8 flops        ( 19% of peak) (madds count as 2)
 #<sched>     4 flops        (  9% of peak) (madds count as 1)
 #<sched>     4 madds        ( 19% of peak)
 #<sched>     5 mem refs     ( 23% of peak)
 #<sched>     4 integer ops  (  9% of peak)
 #<sched>    13 instructions ( 15% of peak)
 #<sched> 
 #<freq>
 #<freq> BB:72 frequency = 5200.16504 (heuristic)
 #<freq> BB:72 => BB:72 probability = 0.50000
 #<freq> BB:72 => BB:242 probability = 0.50000
 #<freq>
	.loc	1 132 22
	pref 1,248($10)               	# [0]  
	.loc	1 131 22
	ldc1 $f0,-8($10)              	# [1]  
	.loc	1 129 22
	ldc1 $f31,-8($12)             	# [2]  
	.loc	1 132 22
	nmsub.d $f2,$f31,$f0,$f24     	# [12]  
	.loc	1 131 22
	madd.d $f1,$f0,$f31,$f24      	# [13]  
	.loc	1 132 22
	madd.d $f0,$f0,$f2,$f26       	# [16]  
	.loc	1 131 22
	nmsub.d $f31,$f31,$f1,$f26    	# [17]  
	addi $5,$5,-1                 	# [18]  
	.loc	1 128 19
	addiu $12,$12,8               	# [19]  
	.loc	1 132 22
	sdc1 $f0,-8($10)              	# [19]  
	.loc	1 128 19
	addiu $10,$10,8               	# [20]  
	bne $5,$0,.L.1.110.temp       	# [20]  
	.loc	1 131 22
	sdc1 $f31,-16($12)            	# [20]  
.BB242.jacobi_: 	 # 0x2634
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:242 frequency = 3466.77686 (heuristic)
 #<freq> BB:242 => BB:240 probability = 0.04000
 #<freq> BB:242 => BB:245 probability = 0.96000
 #<freq>
	or $6,$12,$0                  	# [0]  
	addiu $7,$13,-64              	# [0]  
	beq $24,$0,.BB240.jacobi_     	# [1]  
	or $5,$10,$0                  	# [1]  
.BB245.jacobi_: 	 # 0x2644
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 short trip count test (<= 2)
 #<swp> 
 #<freq>
 #<freq> BB:245 frequency = 3328.10571 (heuristic)
 #<freq> BB:245 => BB:251 probability = 0.00000
 #<freq> BB:245 => BB:250 probability = 1.00000
 #<freq>
	slti $1,$24,3                 	# [1]  
	bne $1,$0,.BB251.jacobi_      	# [2]  
	or $10,$6,$0                  	# [0]  
.BB250.jacobi_: 	 # 0x2650
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 windup (fill)
 #<swp> 
 #<freq>
 #<freq> BB:250 frequency = 3328.10571 (heuristic)
 #<freq>
	.loc	1 129 22
	ldc1 $f0,-8($6)               	# [0]  
	.loc	1 132 22
	pref 1,248($5)                	# [1]  
	.loc	1 131 22
	ldc1 $f2,0($5)                	# [2]  
	ldc1 $f1,-8($5)               	# [3]  
	.loc	1 129 22
	ldc1 $f4,0($6)                	# [4]  
	.loc	1 132 22
	nmsub.d $f3,$f4,$f2,$f24      	# [13]  
	.loc	1 131 22
	madd.d $f8,$f1,$f0,$f24       	# [14]  
	.loc	1 132 22
	nmsub.d $f7,$f0,$f1,$f24      	# [15]  
	.loc	1 131 22
	ldc1 $f10,8($5)               	# [16]  
	madd.d $f5,$f2,$f4,$f24       	# [16]  
	ldc1 $f6,16($5)               	# [17]  
	.loc	1 132 22
	madd.d $f2,$f2,$f3,$f26       	# [17]  
	.loc	1 129 22
	ldc1 $f12,8($6)               	# [18]  
	.loc	1 131 22
	nmsub.d $f0,$f0,$f8,$f26      	# [18]  
	.loc	1 129 22
	ldc1 $f9,16($6)               	# [19]  
	.loc	1 128 19
	addiu $3,$5,32                	# [19]  
	mov.d $f8,$f26                	# [19]  
	addiu $8,$6,32                	# [20]  
	.loc	1 131 22
	ldc1 $f13,-8($3)              	# [20]  
	.loc	1 132 22
	madd.d $f1,$f1,$f7,$f26       	# [20]  
	or $4,$6,$0                   	# [21]  
	.loc	1 129 22
	ldc1 $f11,0($8)               	# [21]  
	.loc	1 128 19
	addiu $1,$8,32                	# [21]  
	.loc	1 131 22
	nmsub.d $f4,$f4,$f5,$f26      	# [21]  
	.loc	1 128 19
	addiu $2,$3,32                	# [22]  
	or $6,$8,$0                   	# [22]  
	.loc	1 131 22
	ldc1 $f5,0($3)                	# [22]  
	mov.d $f7,$f24                	# [22]  
.BB247.jacobi_: 	 # 0x26c0
 #<loop> Loop body line 122, nesting depth: 4, estimated iterations: 8
 #<loop> Unrolled 4 times
 #<swps> 
 #<swps> Pipelined loop line 122 steady state
 #<swps> 
 #<swps>    25 estimated iterations before pipelining
 #<swps>     4 unrollings before pipelining
 #<swps>    17 cycles per 4 iterations
 #<swps>    32 flops        ( 94% of peak) (madds count as 2)
 #<swps>    16 flops        ( 47% of peak) (madds count as 1)
 #<swps>    16 madds        ( 94% of peak)
 #<swps>    16 mem refs     ( 94% of peak)
 #<swps>     3 integer ops  (  8% of peak)
 #<swps>    35 instructions ( 51% of peak)
 #<swps>     2 short trip threshold
 #<swps>     7 integer registers used.
 #<swps>    18 float registers used.
 #<swps> 

 #<swp> 
 #<swp> Pipelined loop line 122 replication 0
 #<swp> 
 #<freq>
 #<freq> BB:247 frequency = 29999.17773 (heuristic)
 #<freq> BB:247 => BB:256 probability = 0.03698
 #<freq> BB:247 => BB:248 probability = 0.96302
 #<freq>
	.loc	1 129 22
	ldc1 $f15,-8($6)              	# [0]  
	.loc	1 132 22
	nmsub.d $f14,$f9,$f6,$f7      	# [1]  
	sdc1 $f1,-8($5)               	# [1]  
	.loc	1 131 22
	madd.d $f3,$f6,$f9,$f7        	# [2]  
	sdc1 $f0,-8($4)               	# [2]  
	.loc	1 132 22
	nmsub.d $f1,$f12,$f10,$f7     	# [3]  
	.loc	1 131 22
	sdc1 $f4,0($4)                	# [3]  
	madd.d $f0,$f10,$f12,$f7      	# [4]  
	.loc	1 132 22
	sdc1 $f2,0($5)                	# [4]  
	madd.d $f6,$f6,$f14,$f8       	# [5]  
	.loc	1 131 22
	nmsub.d $f4,$f9,$f3,$f8       	# [6]  
	ldc1 $f14,16($3)              	# [6]  
	.loc	1 132 22
	madd.d $f1,$f10,$f1,$f8       	# [7]  
	.loc	1 129 22
	ldc1 $f9,16($6)               	# [7]  
	.loc	1 131 22
	nmsub.d $f0,$f12,$f0,$f8      	# [8]  
	ldc1 $f10,8($3)               	# [8]  
	.loc	1 132 22
	nmsub.d $f3,$f11,$f5,$f7      	# [9]  
	.loc	1 129 22
	ldc1 $f12,8($6)               	# [9]  
	.loc	1 131 22
	madd.d $f2,$f5,$f11,$f7       	# [10]  
	.loc	1 132 22
	sdc1 $f1,8($5)                	# [10]  
	nmsub.d $f1,$f15,$f13,$f7     	# [11]  
	.loc	1 131 22
	sdc1 $f0,8($4)                	# [11]  
	madd.d $f0,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($4)               	# [12]  
	.loc	1 132 22
	madd.d $f5,$f5,$f3,$f8        	# [13]  
	sdc1 $f6,16($5)               	# [13]  
	.loc	1 131 22
	nmsub.d $f4,$f11,$f2,$f8      	# [14]  
	.loc	1 128 19
	addiu $5,$2,32                	# [14]  
	.loc	1 131 22
	ldc1 $f16,0($2)               	# [14]  
	.loc	1 132 22
	madd.d $f1,$f13,$f1,$f8       	# [15]  
	.loc	1 129 22
	ldc1 $f11,0($1)               	# [15]  
	.loc	1 131 22
	nmsub.d $f0,$f15,$f0,$f8      	# [16]  
	.loc	1 128 19
	addiu $4,$1,32                	# [16]  
	beq $3,$7,.BB256.jacobi_      	# [16]  
	.loc	1 131 22
	ldc1 $f13,-8($2)              	# [16]  
.BB248.jacobi_: 	 # 0x274c
 #<loop> Part of loop body line 122, head labeled .BB247.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 122 replication 1
 #<swp> 
 #<freq>
 #<freq> BB:248 frequency = 28889.80664 (heuristic)
 #<freq> BB:248 => BB:255 probability = 0.03840
 #<freq> BB:248 => BB:249 probability = 0.96160
 #<freq>
	.loc	1 129 22
	ldc1 $f15,-8($1)              	# [0]  
	.loc	1 132 22
	nmsub.d $f3,$f9,$f14,$f7      	# [1]  
	sdc1 $f1,-8($3)               	# [1]  
	.loc	1 131 22
	madd.d $f2,$f14,$f9,$f7       	# [2]  
	sdc1 $f0,-8($6)               	# [2]  
	.loc	1 132 22
	nmsub.d $f1,$f12,$f10,$f7     	# [3]  
	.loc	1 131 22
	sdc1 $f4,0($6)                	# [3]  
	madd.d $f0,$f10,$f12,$f7      	# [4]  
	.loc	1 132 22
	sdc1 $f5,0($3)                	# [4]  
	madd.d $f6,$f14,$f3,$f8       	# [5]  
	.loc	1 131 22
	nmsub.d $f4,$f9,$f2,$f8       	# [6]  
	ldc1 $f14,16($2)              	# [6]  
	.loc	1 132 22
	madd.d $f1,$f10,$f1,$f8       	# [7]  
	.loc	1 129 22
	ldc1 $f9,16($1)               	# [7]  
	.loc	1 131 22
	nmsub.d $f0,$f12,$f0,$f8      	# [8]  
	ldc1 $f10,8($2)               	# [8]  
	.loc	1 132 22
	nmsub.d $f3,$f11,$f16,$f7     	# [9]  
	.loc	1 129 22
	ldc1 $f12,8($1)               	# [9]  
	.loc	1 131 22
	madd.d $f2,$f16,$f11,$f7      	# [10]  
	.loc	1 132 22
	sdc1 $f1,8($3)                	# [10]  
	nmsub.d $f1,$f15,$f13,$f7     	# [11]  
	.loc	1 131 22
	sdc1 $f0,8($6)                	# [11]  
	madd.d $f0,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($6)               	# [12]  
	.loc	1 132 22
	madd.d $f5,$f16,$f3,$f8       	# [13]  
	sdc1 $f6,16($3)               	# [13]  
	.loc	1 131 22
	nmsub.d $f4,$f11,$f2,$f8      	# [14]  
	.loc	1 128 19
	addiu $3,$5,32                	# [14]  
	.loc	1 131 22
	ldc1 $f16,0($5)               	# [14]  
	.loc	1 132 22
	madd.d $f1,$f13,$f1,$f8       	# [15]  
	.loc	1 129 22
	ldc1 $f11,0($4)               	# [15]  
	.loc	1 131 22
	nmsub.d $f0,$f15,$f0,$f8      	# [16]  
	.loc	1 128 19
	addiu $6,$4,32                	# [16]  
	beq $2,$7,.BB255.jacobi_      	# [16]  
	.loc	1 131 22
	ldc1 $f13,-8($5)              	# [16]  
.BB249.jacobi_: 	 # 0x27d8
 #<loop> Part of loop body line 122, head labeled .BB247.jacobi_
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 122 replication 2
 #<swp> 
 #<freq>
 #<freq> BB:249 frequency = 27780.43945 (heuristic)
 #<freq> BB:249 => BB:247 probability = 0.96007
 #<freq> BB:249 => BB:254 probability = 0.03993
 #<freq>
	.loc	1 129 22
	ldc1 $f15,-8($4)              	# [0]  
	.loc	1 132 22
	nmsub.d $f3,$f9,$f14,$f7      	# [1]  
	sdc1 $f1,-8($2)               	# [1]  
	.loc	1 131 22
	madd.d $f2,$f14,$f9,$f7       	# [2]  
	sdc1 $f0,-8($1)               	# [2]  
	.loc	1 132 22
	nmsub.d $f0,$f12,$f10,$f7     	# [3]  
	.loc	1 131 22
	sdc1 $f4,0($1)                	# [3]  
	madd.d $f1,$f10,$f12,$f7      	# [4]  
	.loc	1 132 22
	sdc1 $f5,0($2)                	# [4]  
	madd.d $f5,$f14,$f3,$f8       	# [5]  
	pref 1,248($3)                	# [5]  
	.loc	1 131 22
	nmsub.d $f4,$f9,$f2,$f8       	# [6]  
	ldc1 $f6,16($5)               	# [6]  
	.loc	1 132 22
	madd.d $f0,$f10,$f0,$f8       	# [7]  
	.loc	1 129 22
	ldc1 $f9,16($4)               	# [7]  
	.loc	1 131 22
	nmsub.d $f3,$f12,$f1,$f8      	# [8]  
	ldc1 $f10,8($5)               	# [8]  
	.loc	1 132 22
	nmsub.d $f2,$f11,$f16,$f7     	# [9]  
	.loc	1 129 22
	ldc1 $f12,8($4)               	# [9]  
	.loc	1 131 22
	madd.d $f1,$f16,$f11,$f7      	# [10]  
	.loc	1 132 22
	sdc1 $f0,8($2)                	# [10]  
	nmsub.d $f0,$f15,$f13,$f7     	# [11]  
	.loc	1 131 22
	sdc1 $f3,8($1)                	# [11]  
	madd.d $f3,$f13,$f15,$f7      	# [12]  
	sdc1 $f4,16($1)               	# [12]  
	.loc	1 132 22
	madd.d $f2,$f16,$f2,$f8       	# [13]  
	sdc1 $f5,16($2)               	# [13]  
	.loc	1 131 22
	nmsub.d $f4,$f11,$f1,$f8      	# [14]  
	.loc	1 128 19
	addiu $2,$3,32                	# [14]  
	.loc	1 131 22
	ldc1 $f5,0($3)                	# [14]  
	.loc	1 132 22
	madd.d $f1,$f13,$f0,$f8       	# [15]  
	.loc	1 129 22
	ldc1 $f11,0($6)               	# [15]  
	.loc	1 131 22
	nmsub.d $f0,$f15,$f3,$f8      	# [16]  
	.loc	1 128 19
	addiu $1,$6,32                	# [16]  
	bne $5,$7,.BB247.jacobi_      	# [16]  
	.loc	1 131 22
	ldc1 $f13,-8($3)              	# [16]  
.BB254.jacobi_: 	 # 0x2868
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:254 frequency = 1109.36853 (heuristic)
 #<freq>
	mov.d $f14,$f6                	# [0]  
	mov.d $f15,$f1                	# [1]  
	mov.d $f17,$f0                	# [2]  
	mov.d $f31,$f2                	# [3]  
	or $14,$3,$0                  	# [4]  
	or $12,$5,$0                  	# [4]  
	mov.d $f16,$f5                	# [4]  
	or $13,$6,$0                  	# [5]  
	or $10,$4,$0                  	# [5]  
	mov.d $f5,$f31                	# [5]  
.BB253.jacobi_: 	 # 0x2890
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 winddown (drain)
 #<swp> 
 #<freq>
 #<freq> BB:253 frequency = 3328.10571 (heuristic)
 #<freq>
	.loc	1 132 22
	nmsub.d $f7,$f11,$f16,$f24    	# [0]  
	.loc	1 129 22
	ldc1 $f21,-8($13)             	# [0]  
	.loc	1 131 22
	madd.d $f18,$f16,$f11,$f24    	# [1]  
	.loc	1 132 22
	sdc1 $f15,-8($12)             	# [2]  
	nmsub.d $f27,$f9,$f14,$f24    	# [3]  
	.loc	1 131 22
	sdc1 $f4,0($10)               	# [3]  
	.loc	1 132 22
	madd.d $f7,$f16,$f7,$f26      	# [4]  
	.loc	1 131 22
	sdc1 $f17,-8($10)             	# [4]  
	nmsub.d $f18,$f11,$f18,$f26   	# [5]  
	.loc	1 132 22
	sdc1 $f5,0($12)               	# [5]  
	.loc	1 131 22
	madd.d $f30,$f10,$f12,$f24    	# [6]  
	ldc1 $f3,8($14)               	# [6]  
	.loc	1 132 22
	madd.d $f27,$f14,$f27,$f26    	# [7]  
	.loc	1 129 22
	ldc1 $f1,16($13)              	# [7]  
	.loc	1 131 22
	madd.d $f28,$f14,$f9,$f24     	# [8]  
	.loc	1 129 22
	ldc1 $f2,8($13)               	# [8]  
	.loc	1 132 22
	nmsub.d $f31,$f12,$f10,$f24   	# [9]  
	.loc	1 131 22
	ldc1 $f0,16($14)              	# [9]  
	nmsub.d $f30,$f12,$f30,$f26   	# [10]  
	.loc	1 132 22
	nmsub.d $f25,$f21,$f13,$f24   	# [11]  
	.loc	1 131 22
	madd.d $f29,$f13,$f21,$f24    	# [12]  
	.loc	1 132 22
	madd.d $f31,$f10,$f31,$f26    	# [13]  
	.loc	1 131 22
	nmsub.d $f28,$f9,$f28,$f26    	# [14]  
	.loc	1 132 22
	madd.d $f25,$f13,$f25,$f26    	# [15]  
	sdc1 $f31,8($12)              	# [16]  
	.loc	1 131 22
	nmsub.d $f21,$f21,$f29,$f26   	# [16]  
	sdc1 $f28,16($10)             	# [17]  
	.loc	1 132 22
	nmsub.d $f23,$f2,$f3,$f24     	# [17]  
	.loc	1 131 22
	sdc1 $f30,8($10)              	# [18]  
	madd.d $f8,$f0,$f1,$f24       	# [18]  
	.loc	1 132 22
	sdc1 $f27,16($12)             	# [19]  
	.loc	1 131 22
	madd.d $f19,$f3,$f2,$f24      	# [19]  
	.loc	1 132 22
	sdc1 $f25,-8($14)             	# [20]  
	nmsub.d $f6,$f1,$f0,$f24      	# [20]  
	.loc	1 131 22
	sdc1 $f18,0($13)              	# [21]  
	.loc	1 132 22
	madd.d $f3,$f3,$f23,$f26      	# [21]  
	.loc	1 131 22
	sdc1 $f21,-8($13)             	# [22]  
	nmsub.d $f1,$f1,$f8,$f26      	# [22]  
	.loc	1 132 22
	sdc1 $f7,0($14)               	# [23]  
	.loc	1 131 22
	nmsub.d $f2,$f2,$f19,$f26     	# [23]  
	.loc	1 132 22
	madd.d $f0,$f0,$f6,$f26       	# [24]  
	sdc1 $f3,8($14)               	# [24]  
	.loc	1 131 22
	sdc1 $f1,16($13)              	# [25]  
	sdc1 $f2,8($13)               	# [26]  
	.loc	1 132 22
	sdc1 $f0,16($14)              	# [27]  
.BB240.jacobi_: 	 # 0x2944
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:240 frequency = 3466.77686 (heuristic)
 #<freq>
	ld $1,2120($sp)               	# [0]  .gra_spill_b057
	.loc	1 134 19
	addiu $1,$1,1                 	# [2]  
	b .L.1.115.temp               	# [2]  
	sd $1,2120($sp)               	# [2]  .gra_spill_b057
.BB307.jacobi_: 	 # 0x2954
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:307 frequency = 3168.33716 (heuristic)
 #<freq>
	mov.d $f21,$f0                	# [0]  
	mov.d $f2,$f6                 	# [1]  
	mov.d $f6,$f16                	# [2]  
	mov.d $f16,$f9                	# [3]  
	mov.d $f9,$f14                	# [4]  
	mov.d $f12,$f11               	# [5]  
	or $11,$12,$0                 	# [6]  
	mov.d $f7,$f1                 	# [6]  
	or $12,$7,$0                  	# [7]  
	or $31,$15,$0                 	# [7]  
	mov.d $f5,$f17                	# [7]  
	or $17,$5,$0                  	# [8]  
	or $5,$14,$0                  	# [8]  
	mov.d $f17,$f15               	# [8]  
	or $14,$4,$0                  	# [9]  
	or $24,$1,$0                  	# [9]  
	mov.d $f15,$f13               	# [9]  
	mov.d $f13,$f10               	# [10]  
	or $8,$13,$0                  	# [10]  
	or $13,$16,$0                 	# [10]  
	or $16,$3,$0                  	# [11]  
	or $18,$10,$0                 	# [11]  
	sd $18,2360($sp)              	# [11]  .gra_spill_b087
	mov.d $f10,$f7                	# [11]  
	sd $16,2264($sp)              	# [12]  .gra_spill_b075
	or $9,$6,$0                   	# [12]  
	or $18,$2,$0                  	# [12]  
	mov.d $f11,$f15               	# [12]  
	or $16,$9,$0                  	# [13]  
	or $6,$8,$0                   	# [13]  
	mov.d $f15,$f5                	# [13]  
	sd $24,2336($sp)              	# [14]  .gra_spill_b084
	or $15,$14,$0                 	# [14]  
	or $14,$11,$0                 	# [14]  
	mov.d $f14,$f16               	# [14]  
	or $11,$24,$0                 	# [15]  
	mov.d $f16,$f2                	# [15]  
	b .BB305.jacobi_              	# [15]  
	ld $24,2360($sp)              	# [15]  .gra_spill_b087
.BB308.jacobi_: 	 # 0x29f0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:308 frequency = 3168.33716 (heuristic)
 #<freq>
	mov.d $f21,$f0                	# [0]  
	or $4,$17,$0                  	# [0]  
	or $17,$25,$0                 	# [0]  
	or $25,$10,$0                 	# [1]  
	mov.d $f13,$f11               	# [1]  
	or $18,$12,$0                 	# [1]  
	or $12,$31,$0                 	# [2]  
	or $31,$7,$0                  	# [2]  
	mov.d $f2,$f10                	# [2]  
	or $11,$6,$0                  	# [3]  
	or $5,$3,$0                   	# [3]  
	mov.d $f31,$f1                	# [3]  
	sd $24,2352($sp)              	# [3]  .gra_spill_b086
	sd $5,2264($sp)               	# [4]  .gra_spill_b075
	or $2,$1,$0                   	# [4]  
	or $24,$4,$0                  	# [4]  
	mov.d $f11,$f2                	# [4]  
	or $6,$2,$0                   	# [5]  
	mov.d $f10,$f31               	# [5]  
	b .BB305.jacobi_              	# [5]  
	ld $5,2352($sp)               	# [5]  .gra_spill_b086
.BB309.jacobi_: 	 # 0x2a44
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:309 frequency = 3168.33716 (heuristic)
 #<freq>
	mov.d $f21,$f0                	# [0]  
	mov.d $f10,$f1                	# [1]  
	mov.d $f7,$f16                	# [2]  
	mov.d $f16,$f6                	# [3]  
	mov.d $f8,$f15                	# [4]  
	mov.d $f15,$f17               	# [5]  
	or $8,$13,$0                  	# [6]  
	mov.d $f17,$f12               	# [6]  
	or $13,$1,$0                  	# [7]  
	mov.d $f12,$f13               	# [7]  
	or $25,$17,$0                 	# [7]  
	or $17,$10,$0                 	# [8]  
	or $9,$5,$0                   	# [8]  
	mov.d $f31,$f5                	# [8]  
	or $5,$2,$0                   	# [9]  
	or $18,$14,$0                 	# [9]  
	mov.d $f14,$f9                	# [9]  
	or $12,$4,$0                  	# [10]  
	or $15,$3,$0                  	# [10]  
	sd $15,2264($sp)              	# [10]  .gra_spill_b075
	mov.d $f9,$f31                	# [10]  
	or $11,$24,$0                 	# [11]  
	or $15,$7,$0                  	# [11]  
	sd $16,2336($sp)              	# [11]  .gra_spill_b084
	mov.d $f13,$f17               	# [11]  
	sd $12,2344($sp)              	# [12]  .gra_spill_b085
	or $24,$9,$0                  	# [12]  
	or $16,$8,$0                  	# [12]  
	mov.d $f17,$f8                	# [12]  
	or $14,$11,$0                 	# [13]  
	mov.d $f6,$f7                 	# [13]  
	b .BB305.jacobi_              	# [13]  
	ld $11,2336($sp)              	# [13]  .gra_spill_b084
.L.1.121.temp: 	 # 0x2ac8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:87 frequency = 1310.67981 (heuristic)
 #<freq>
	.loc	1 110 19
	sqrt.d $f19,$f19              	# [0]  
	recip.d $f19,$f19             	# [30]  
	add.d $f18,$f19,$f18          	# [47]  
	recip.d $f18,$f18             	# [49]  
	mul.d $f19,$f19,$f3           	# [64]  
	b .L.1.120.temp               	# [66]  
	mul.d $f18,$f19,$f18          	# [66]  
.BB255.jacobi_: 	 # 0x2ae4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:255 frequency = 1109.36853 (heuristic)
 #<freq>
	or $12,$2,$0                  	# [0]  
	or $14,$5,$0                  	# [1]  
	or $10,$1,$0                  	# [1]  
	mov.d $f15,$f1                	# [1]  
	or $13,$4,$0                  	# [2]  
	b .BB253.jacobi_              	# [2]  
	mov.d $f17,$f0                	# [2]  
.BB256.jacobi_: 	 # 0x2b00
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 122 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:256 frequency = 1109.36853 (heuristic)
 #<freq>
	or $14,$2,$0                  	# [0]  
	or $12,$3,$0                  	# [1]  
	or $13,$1,$0                  	# [1]  
	mov.d $f15,$f1                	# [1]  
	or $10,$6,$0                  	# [2]  
	b .BB253.jacobi_              	# [2]  
	mov.d $f17,$f0                	# [2]  
.BB206.jacobi_: 	 # 0x2b1c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:206 frequency = 1029.47937 (heuristic)
 #<freq>
	or $12,$2,$0                  	# [0]  
	or $10,$5,$0                  	# [1]  
	or $14,$1,$0                  	# [1]  
	mov.d $f15,$f1                	# [1]  
	or $13,$4,$0                  	# [2]  
	b .BB204.jacobi_              	# [2]  
	mov.d $f17,$f0                	# [2]  
.BB207.jacobi_: 	 # 0x2b38
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 109 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:207 frequency = 1029.47937 (heuristic)
 #<freq>
	or $10,$2,$0                  	# [0]  
	or $12,$3,$0                  	# [1]  
	or $13,$1,$0                  	# [1]  
	mov.d $f15,$f1                	# [1]  
	or $14,$6,$0                  	# [2]  
	b .BB204.jacobi_              	# [2]  
	mov.d $f17,$f0                	# [2]  
.BB223.jacobi_: 	 # 0x2b54
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:223 frequency = 788.23553 (heuristic)
 #<freq>
	mov.d $f25,$f13               	# [0]  
	mov.d $f2,$f18                	# [1]  
	mov.d $f18,$f12               	# [2]  
	mov.d $f1,$f29                	# [3]  
	mov.d $f29,$f14               	# [4]  
	mov.d $f14,$f15               	# [5]  
	mov.d $f15,$f19               	# [6]  
	mov.d $f3,$f10                	# [7]  
	sdc1 $f24,1744($sp)           	# [8]  .gra_spill_b010
	mov.d $f10,$f9                	# [8]  
	sdc1 $f26,1736($sp)           	# [9]  .gra_spill_b009
	mov.d $f9,$f11                	# [9]  
	or $18,$6,$0                  	# [9]  
	or $6,$4,$0                   	# [10]  
	or $17,$14,$0                 	# [10]  
	mov.d $f31,$f0                	# [10]  
	sd $11,2328($sp)              	# [10]  .gra_spill_b083
	or $16,$25,$0                 	# [11]  
	or $5,$3,$0                   	# [11]  
	sd $31,2320($sp)              	# [11]  .gra_spill_b082
	mov.d $f11,$f3                	# [11]  
	or $31,$8,$0                  	# [12]  
	or $8,$1,$0                   	# [12]  
	sd $8,2256($sp)               	# [12]  .gra_spill_b074
	mov.d $f19,$f2                	# [12]  
	or $11,$24,$0                 	# [13]  
	or $24,$2,$0                  	# [13]  
	mov.d $f12,$f1                	# [13]  
	ld $13,2320($sp)              	# [13]  .gra_spill_b082
	mov.d $f13,$f31               	# [14]  
	or $8,$5,$0                   	# [14]  
	b .BB221.jacobi_              	# [14]  
	ld $12,2328($sp)              	# [14]  .gra_spill_b083
.BB224.jacobi_: 	 # 0x2bd8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 110 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:224 frequency = 788.23553 (heuristic)
 #<freq>
	mov.d $f13,$f0                	# [0]  
	mov.d $f31,$f17               	# [1]  
	or $18,$4,$0                  	# [2]  
	mov.d $f17,$f12               	# [2]  
	or $17,$12,$0                 	# [2]  
	or $12,$14,$0                 	# [3]  
	or $16,$13,$0                 	# [3]  
	mov.d $f1,$f25                	# [3]  
	mov.d $f25,$f16               	# [4]  
	or $13,$24,$0                 	# [4]  
	or $24,$7,$0                  	# [4]  
	or $15,$2,$0                  	# [5]  
	or $5,$25,$0                  	# [5]  
	mov.d $f2,$f29                	# [5]  
	sdc1 $f24,1744($sp)           	# [6]  .gra_spill_b010
	mov.d $f29,$f15               	# [6]  
	or $10,$3,$0                  	# [6]  
	or $7,$13,$0                  	# [6]  
	mov.d $f15,$f14               	# [7]  
	or $13,$10,$0                 	# [7]  
	or $11,$1,$0                  	# [7]  
	sd $11,2256($sp)              	# [7]  .gra_spill_b074
	sdc1 $f26,1736($sp)           	# [8]  .gra_spill_b009
	or $10,$5,$0                  	# [8]  
	or $11,$6,$0                  	# [8]  
	mov.d $f14,$f2                	# [8]  
	sd $5,2312($sp)               	# [9]  .gra_spill_b081
	or $6,$9,$0                   	# [9]  
	mov.d $f16,$f1                	# [9]  
	or $9,$11,$0                  	# [9]  
	sd $15,2304($sp)              	# [10]  .gra_spill_b080
	mov.d $f12,$f31               	# [10]  
	b .BB221.jacobi_              	# [10]  
	or $11,$15,$0                 	# [10]  
.BB238.jacobi_: 	 # 0x2c60
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:238 frequency = 492.64722 (heuristic)
 #<freq>
	mov.d $f14,$f2                	# [0]  
	mov.d $f8,$f0                 	# [1]  
	mov.d $f13,$f10               	# [2]  
	mov.d $f17,$f6                	# [3]  
	or $24,$1,$0                  	# [4]  
	or $25,$4,$0                  	# [4]  
	mov.d $f16,$f9                	# [4]  
	or $16,$3,$0                  	# [5]  
	mov.d $f12,$f11               	# [5]  
	or $31,$7,$0                  	# [5]  
	or $7,$10,$0                  	# [6]  
	or $10,$12,$0                 	# [6]  
	mov.d $f4,$f5                 	# [6]  
	or $15,$2,$0                  	# [7]  
	or $8,$6,$0                   	# [7]  
	mov.d $f3,$f1                 	# [7]  
	or $12,$8,$0                  	# [8]  
	or $6,$7,$0                   	# [8]  
	mov.d $f11,$f4                	# [8]  
	or $7,$15,$0                  	# [9]  
	b .BB234.jacobi_              	# [9]  
	mov.d $f9,$f3                 	# [9]  
.BB236.jacobi_: 	 # 0x2cb8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 3
 #<swp> 
 #<freq>
 #<freq> BB:236 frequency = 492.64722 (heuristic)
 #<freq>
	mov.d $f9,$f1                 	# [0]  
	or $31,$2,$0                  	# [1]  
	mov.d $f14,$f2                	# [1]  
	or $25,$10,$0                 	# [1]  
	or $10,$4,$0                  	# [2]  
	or $16,$3,$0                  	# [2]  
	mov.d $f8,$f0                 	# [2]  
	or $24,$12,$0                 	# [3]  
	mov.d $f15,$f16               	# [3]  
	or $11,$5,$0                  	# [3]  
	mov.d $f16,$f10               	# [4]  
	or $9,$14,$0                  	# [4]  
	or $14,$7,$0                  	# [4]  
	mov.d $f11,$f12               	# [5]  
	or $7,$13,$0                  	# [5]  
	or $13,$1,$0                  	# [5]  
	mov.d $f12,$f17               	# [6]  
	or $12,$13,$0                 	# [6]  
	or $13,$11,$0                 	# [6]  
	mov.d $f17,$f5                	# [7]  
	b .BB234.jacobi_              	# [7]  
	or $5,$9,$0                   	# [7]  
.BB237.jacobi_: 	 # 0x2d10
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 2
 #<swp> 
 #<freq>
 #<freq> BB:237 frequency = 492.64722 (heuristic)
 #<freq>
	mov.d $f9,$f1                 	# [0]  
	mov.d $f14,$f4                	# [1]  
	mov.d $f8,$f0                 	# [2]  
	or $25,$1,$0                  	# [3]  
	or $16,$3,$0                  	# [3]  
	mov.d $f12,$f5                	# [3]  
	or $31,$5,$0                  	# [4]  
	or $15,$14,$0                 	# [4]  
	mov.d $f13,$f16               	# [4]  
	or $14,$13,$0                 	# [5]  
	or $24,$10,$0                 	# [5]  
	mov.d $f16,$f15               	# [5]  
	or $10,$6,$0                  	# [6]  
	or $6,$12,$0                  	# [6]  
	mov.d $f15,$f17               	# [6]  
	mov.d $f17,$f11               	# [7]  
	or $8,$2,$0                   	# [7]  
	or $11,$4,$0                  	# [7]  
	or $9,$7,$0                   	# [8]  
	or $12,$11,$0                 	# [8]  
	mov.d $f6,$f10                	# [8]  
	or $13,$9,$0                  	# [9]  
	or $5,$8,$0                   	# [9]  
	mov.d $f11,$f15               	# [9]  
	or $7,$15,$0                  	# [10]  
	b .BB234.jacobi_              	# [10]  
	mov.d $f15,$f6                	# [10]  
.BB239.jacobi_: 	 # 0x2d7c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<swp> 
 #<swp> Pipelined loop line 116 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:239 frequency = 492.64722 (heuristic)
 #<freq>
	mov.d $f8,$f0                 	# [0]  
	mov.d $f16,$f13               	# [1]  
	mov.d $f13,$f15               	# [2]  
	mov.d $f17,$f12               	# [3]  
	or $15,$14,$0                 	# [3]  
	or $14,$2,$0                  	# [4]  
	or $24,$4,$0                  	# [4]  
	mov.d $f31,$f1                	# [4]  
	or $16,$3,$0                  	# [5]  
	or $31,$13,$0                 	# [5]  
	mov.d $f3,$f6                 	# [5]  
	or $8,$5,$0                   	# [6]  
	or $5,$7,$0                   	# [6]  
	mov.d $f2,$f9                 	# [6]  
	or $25,$6,$0                  	# [7]  
	or $9,$1,$0                   	# [7]  
	mov.d $f12,$f3                	# [7]  
	or $6,$9,$0                   	# [8]  
	or $7,$8,$0                   	# [8]  
	mov.d $f15,$f2                	# [8]  
	or $13,$15,$0                 	# [9]  
	b .BB234.jacobi_              	# [9]  
	mov.d $f9,$f31                	# [9]  
.L.1.91.temp: 	 # 0x2dd8
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:59 frequency = 249.65331 (heuristic)
 #<freq>
	ldc1 $f24,%gp_rel(.lit8-30712)($gp)	# [0]  
	madd.d $f26,$f24,$f3,$f3      	# [1]  
	sqrt.d $f26,$f26              	# [5]  
	recip.d $f26,$f26             	# [35]  
	add.d $f24,$f26,$f24          	# [52]  
	recip.d $f24,$f24             	# [54]  
	mul.d $f26,$f26,$f3           	# [69]  
	b .L.1.90.temp                	# [71]  
	mul.d $f24,$f26,$f24          	# [71]  
.BB343.jacobi_: 	 # 0x2dfc
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:343 frequency = 7.39836 (heuristic)
 #<freq>
	mov.d $f13,$f2                	# [0]  
	or $13,$3,$0                  	# [1]  
	mov.d $f12,$f1                	# [1]  
	or $12,$4,$0                  	# [2]  
	or $14,$6,$0                  	# [2]  
	mov.d $f11,$f0                	# [2]  
	or $9,$5,$0                   	# [3]  
	b .BB340.jacobi_              	# [3]  
	mov.d $f10,$f7                	# [3]  
.BB342.jacobi_: 	 # 0x2e20
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<swp> 
 #<swp> Pipelined loop line 85 exit compensation for replication 1
 #<swp> 
 #<freq>
 #<freq> BB:342 frequency = 7.39836 (heuristic)
 #<freq>
	mov.d $f13,$f2                	# [0]  
	mov.d $f12,$f3                	# [1]  
	or $12,$8,$0                  	# [2]  
	mov.d $f9,$f4                 	# [2]  
	or $13,$4,$0                  	# [3]  
	or $14,$2,$0                  	# [3]  
	mov.d $f11,$f0                	# [3]  
	or $10,$5,$0                  	# [4]  
	b .BB340.jacobi_              	# [4]  
	mov.d $f10,$f1                	# [4]  
.BB35.jacobi_: 	 # 0x2e48
 #<freq>
 #<freq> BB:35 frequency = 0.49835 (heuristic)
 #<freq>
	ld $gp,1800($sp)              	# [0]  .gra_spill_b017
	.loc	1 76 24
	ld $18,1824($sp)              	# [1]  .gra_spill_b020
	ld $19,1832($sp)              	# [2]  .gra_spill_b021
	ld $20,1808($sp)              	# [3]  .gra_spill_b018
	ld $21,1760($sp)              	# [4]  .gra_spill_b012
	ld $22,1840($sp)              	# [5]  .gra_spill_b022
	ld $23,1784($sp)              	# [6]  .gra_spill_b015
	ld $30,1848($sp)              	# [7]  .gra_spill_b023
	ldc1 $f20,1704($sp)           	# [8]  .gra_spill_b005
	ldc1 $f22,1688($sp)           	# [9]  .gra_spill_b003
	ldc1 $f24,1680($sp)           	# [10]  .gra_spill_b002
	ldc1 $f26,1712($sp)           	# [11]  .gra_spill_b006
	ldc1 $f28,1696($sp)           	# [12]  .gra_spill_b004
	ldc1 $f30,1672($sp)           	# [13]  .gra_spill_b001
	ld $16,2120($sp)              	# [14]  .gra_spill_b057
	ld $17,1792($sp)              	# [15]  .gra_spill_b016
	ld $31,1776($sp)              	# [16]  .gra_spill_b014
	sw $16,0($17)                 	# [17]  
	ld $16,1768($sp)              	# [18]  .gra_spill_b013
	ld $17,1816($sp)              	# [19]  .gra_spill_b019
	jr $31                        	# [19]  
	addiu $sp,$sp,2416            	# [19]  .frame.len.jacobi_
.L.1.150.temp: 	 # 0x2ea0
 #<freq>
 #<freq> BB:111 frequency = 0.48811 (heuristic)
 #<freq>
	.loc	1 148 7
 # 144           ENDDO
 # 145  
 # 146        ENDDO
 # 147  
 # 148        WRITE(6,*) 'JACOBI: Too many iterations'
	addiu $1,$0,6                 	# [0]  
	sw $1,1604($sp)               	# [0]  _cilist+4
	sw $0,1600($sp)               	# [1]  _cilist
	lw $25,%call16(s_wsle64)($gp) 	# [2]  
	.loc	1 66 7
	ld $31,1792($sp)              	# [3]  .gra_spill_b016
	ld $24,2120($sp)              	# [4]  .gra_spill_b057
	sw $24,0($31)                 	# [5]  
	.loc	1 148 7
	jalr $25                      	# [5]  s_wsle64
	addiu $4,$sp,1600             	# [5]  _cilist
.BB113.jacobi_: 	 # 0x2ec4
 #<freq>
 #<freq> BB:113 frequency = 0.48811 (heuristic)
 #<freq>
	lw $25,%call16(do_lioxh1)($gp)	# [0]  
	lw $4,%got_page(.rodata)($gp) 	# [1]  
	addiu $6,$0,1                 	# [2]  
	addiu $5,$0,27                	# [2]  
	jalr $25                      	# [3]  do_lioxh1
	addiu $4,$4,%got_ofst(.rodata)	# [3]  
.BB114.jacobi_: 	 # 0x2edc
 #<freq>
 #<freq> BB:114 frequency = 0.48811 (heuristic)
 #<freq>
	lw $25,%call16(e_wsle64)($gp) 	# [0]  
	jalr $25                      	# [3]  e_wsle64
	nop                           	# [0]  
.BB115.jacobi_: 	 # 0x2ee8
 #<freq>
 #<freq> BB:115 frequency = 0.48811 (heuristic)
 #<freq>
	ld $gp,1800($sp)              	# [0]  .gra_spill_b017
	.loc	1 152 7
 # 149  C      PAUSE 'JACOBI: Too many iterations'
 # 150  
 # 151  C-----------------------------------------------------------
 # 152        RETURN
	ld $16,1768($sp)              	# [1]  .gra_spill_b013
	ld $17,1816($sp)              	# [2]  .gra_spill_b019
	ld $18,1824($sp)              	# [3]  .gra_spill_b020
	ld $19,1832($sp)              	# [4]  .gra_spill_b021
	ld $20,1808($sp)              	# [5]  .gra_spill_b018
	ld $21,1760($sp)              	# [6]  .gra_spill_b012
	ld $22,1840($sp)              	# [7]  .gra_spill_b022
	ld $23,1784($sp)              	# [8]  .gra_spill_b015
	ld $30,1848($sp)              	# [9]  .gra_spill_b023
	ldc1 $f20,1704($sp)           	# [10]  .gra_spill_b005
	ldc1 $f22,1688($sp)           	# [11]  .gra_spill_b003
	ldc1 $f24,1680($sp)           	# [12]  .gra_spill_b002
	ld $31,1776($sp)              	# [13]  .gra_spill_b014
	ldc1 $f26,1712($sp)           	# [14]  .gra_spill_b006
	ldc1 $f28,1696($sp)           	# [15]  .gra_spill_b004
	ldc1 $f30,1672($sp)           	# [16]  .gra_spill_b001
	jr $31                        	# [16]  
	addiu $sp,$sp,2416            	# [16]  .frame.len.jacobi_
.BB173.jacobi_: 	 # 0x2f34
 #<swp> 
 #<swp> Pipelined loop line 52 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:173 frequency = 0.45471 (heuristic)
 #<freq>
	mov.d $f6,$f1                 	# [0]  
	or $25,$4,$0                  	# [1]  
	b .BB171.jacobi_              	# [1]  
	mov.d $f5,$f0                 	# [1]  
.BB158.jacobi_: 	 # 0x2f44
 #<swp> 
 #<swp> Pipelined loop line 45 exit compensation for replication 0
 #<swp> 
 #<freq>
 #<freq> BB:158 frequency = 0.44543 (heuristic)
 #<freq>
	or $25,$4,$0                  	# [0]  
	or $24,$12,$0                 	# [1]  
	or $12,$1,$0                  	# [1]  
	or $15,$11,$0                 	# [2]  
	or $10,$2,$0                  	# [2]  
	or $13,$9,$0                  	# [3]  
	or $5,$3,$0                   	# [3]  
	b .BB156.jacobi_              	# [4]  
	or $9,$5,$0                   	# [4]  
.BB140.jacobi_: 	 # 0x2f68
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<freq>
 #<freq> BB:140 frequency = 0.00000 (heuristic)
 #<freq>
	or $5,$12,$0                  	# [0]  
.BB132.jacobi_: 	 # 0x2f6c
 #<loop> Part of loop body line 46, head labeled .L.1.37.temp
 #<loop> Unrolled 8 times (fully)
 #<swp> 
 #<swp> Pipelined loop line 46 short trip version
 #<swp>       (only executed when trip count <= 1)
 #<swp> 
 #<freq>
 #<freq> BB:132 frequency = 0.00000 (heuristic)
 #<freq>
	ldc1 $f31,%gp_rel(.lit8-30720)($gp)	# [0]  
	.loc	1 47 13
	sdc1 $f31,48($5)              	# [2]  
	sdc1 $f31,40($5)              	# [3]  
	sdc1 $f31,32($5)              	# [4]  
	sdc1 $f31,24($5)              	# [5]  
	sdc1 $f31,16($5)              	# [6]  
	sdc1 $f31,8($5)               	# [7]  
	sdc1 $f31,0($5)               	# [8]  
	b .BB131.jacobi_              	# [9]  
	sdc1 $f31,-8($5)              	# [9]  
.BB154.jacobi_: 	 # 0x2f94
 #<freq>
 #<freq> BB:154 frequency = 0.00000 (heuristic)
 #<freq>
	or $7,$10,$0                  	# [0]  
	or $6,$12,$0                  	# [1]  
	or $8,$13,$0                  	# [1]  
.BB145.jacobi_: 	 # 0x2fa0
 #<loop> Loop body line 45, nesting depth: 1, estimated iterations: 1
 #<loop> Unrolled 4 times (fully)
 #<swp> 
 #<swp> Pipelined loop line 45 short trip version
 #<swp>       (only executed when trip count <= 1)
 #<swp> 
 #<freq>
 #<freq> BB:145 frequency = 0.00000 (heuristic)
 #<freq>
	ldc1 $f1,%gp_rel(.lit8-30712)($gp)	# [0]  
	.loc	1 49 10
	ld $5,2048($sp)               	# [1]  .gra_spill_b048
	addu $4,$8,$6                 	# [1]  
	.loc	1 45 7
	ld $2,2224($sp)               	# [2]  .gra_spill_b070
	.loc	1 49 10
	sll $4,$4,3                   	# [2]  
	addu $4,$4,$5                 	# [3]  
	.loc	1 45 7
	addu $1,$2,$6                 	# [4]  
	.loc	1 49 10
	sdc1 $f1,-8($4)               	# [4]  
	.loc	1 45 7
	addiu $4,$8,1                 	# [4]  
	.loc	1 49 10
	addu $3,$4,$1                 	# [5]  
	sll $3,$3,3                   	# [6]  
	addu $3,$3,$5                 	# [7]  
	.loc	1 45 7
	addu $1,$2,$1                 	# [7]  
	addiu $4,$4,1                 	# [8]  
	addu $2,$2,$1                 	# [8]  
	.loc	1 49 10
	addu $1,$4,$1                 	# [9]  
	.loc	1 45 7
	addiu $4,$4,1                 	# [9]  
	.loc	1 49 10
	sll $1,$1,3                   	# [10]  
	addu $4,$4,$2                 	# [10]  
	sdc1 $f1,-8($3)               	# [11]  
	addu $1,$1,$5                 	# [11]  
	sll $4,$4,3                   	# [11]  
	sdc1 $f1,-8($1)               	# [12]  
	addu $4,$4,$5                 	# [12]  
	b .BB144.jacobi_              	# [13]  
	sdc1 $f1,-8($4)               	# [13]  
.BB169.jacobi_: 	 # 0x3008
 #<freq>
 #<freq> BB:169 frequency = 0.00000 (heuristic)
 #<freq>
	or $8,$31,$0                  	# [1]  
	or $5,$16,$0                  	# [1]  
	or $11,$7,$0                  	# [2]  
	or $12,$6,$0                  	# [2]  
.BB160.jacobi_: 	 # 0x3018
 #<loop> Loop body line 52, nesting depth: 1, estimated iterations: 1
 #<loop> Unrolled 2 times (fully)
 #<swp> 
 #<swp> Pipelined loop line 52 short trip version
 #<swp>       (only executed when trip count <= 1)
 #<swp> 
 #<freq>
 #<freq> BB:160 frequency = 0.00000 (heuristic)
 #<freq>
	.loc	1 53 10
	addu $3,$5,$8                 	# [0]  
	.loc	1 52 7
	ld $4,2224($sp)               	# [0]  .gra_spill_b070
	.loc	1 53 10
	ld $2,2136($sp)               	# [1]  .gra_spill_b059
	sll $3,$3,3                   	# [1]  
	.loc	1 52 7
	addiu $1,$5,1                 	# [2]  
	addu $4,$4,$8                 	# [2]  
	.loc	1 53 10
	addu $3,$3,$2                 	# [3]  
	addu $1,$1,$4                 	# [3]  
	ldc1 $f31,-8($3)              	# [4]  
	sll $1,$1,3                   	# [4]  
	addu $1,$1,$2                 	# [5]  
	ldc1 $f2,-8($1)               	# [6]  
	ldc1 $f0,%gp_rel(.lit8-30720)($gp)	# [10]  
	.loc	1 55 10
	sdc1 $f0,0($12)               	# [12]  
	sdc1 $f0,-8($12)              	# [13]  
	.loc	1 54 10
	sdc1 $f31,-8($11)             	# [14]  
	.loc	1 53 10
	sdc1 $f31,-8($10)             	# [15]  
	.loc	1 54 10
	sdc1 $f2,0($11)               	# [16]  
	b .BB159.jacobi_              	# [17]  
	.loc	1 53 10
	sdc1 $f2,0($10)               	# [17]  
.BB185.jacobi_: 	 # 0x3068
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<freq>
 #<freq> BB:185 frequency = 0.00000 (heuristic)
 #<freq>
	or $5,$24,$0                  	# [0]  
.BB175.jacobi_: 	 # 0x306c
 #<loop> Loop body line 69, nesting depth: 3, estimated iterations: 2
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 69 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:175 frequency = 0.00000 (heuristic)
 #<freq> BB:175 => BB:175 probability = 0.50000
 #<freq> BB:175 => BB:186 probability = 0.50000
 #<freq>
	.loc	1 71 16
	ldc1 $f2,-8($5)               	# [0]  
	ldc1 $f0,0($5)                	# [1]  
	ldc1 $f31,8($5)               	# [3]  
	ldc1 $f1,16($5)               	# [5]  
	abs.d $f2,$f2                 	# [11]  
	abs.d $f0,$f0                 	# [12]  
	add.d $f2,$f2,$f3             	# [13]  
	abs.d $f31,$f31               	# [14]  
	add.d $f0,$f0,$f2             	# [15]  
	abs.d $f3,$f1                 	# [16]  
	.loc	1 70 13
	addiu $5,$5,32                	# [17]  
	.loc	1 71 16
	add.d $f31,$f31,$f0           	# [17]  
	.loc	1 70 13
	bne $5,$15,.BB175.jacobi_     	# [19]  
	.loc	1 71 16
	add.d $f3,$f3,$f31            	# [19]  
.BB186.jacobi_: 	 # 0x30a4
 #<loop> Part of loop body line 69, head labeled .L.1.62.temp
 #<freq>
 #<freq> BB:186 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB174.jacobi_              	# [0]  
	mov.d $f12,$f3                	# [0]  
.BB202.jacobi_: 	 # 0x30ac
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:202 frequency = 0.00000 (heuristic)
 #<freq>
	or $12,$5,$0                  	# [0]  
.BB192.jacobi_: 	 # 0x30b0
 #<loop> Loop body line 109, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 109 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:192 frequency = 0.00000 (heuristic)
 #<freq> BB:192 => BB:192 probability = 0.50000
 #<freq> BB:192 => BB:459 probability = 0.50000
 #<freq>
	.loc	1 113 22
	ldc1 $f2,16($12)              	# [0]  
	.loc	1 111 22
	ldc1 $f1,16($10)              	# [1]  
	.loc	1 113 22
	ldc1 $f31,8($12)              	# [2]  
	.loc	1 111 22
	ldc1 $f9,8($10)               	# [3]  
	.loc	1 113 22
	ldc1 $f7,0($12)               	# [8]  
	.loc	1 111 22
	ldc1 $f5,0($10)               	# [9]  
	.loc	1 113 22
	ldc1 $f4,-8($12)              	# [10]  
	.loc	1 114 22
	nmsub.d $f8,$f1,$f2,$f24      	# [11]  
	.loc	1 111 22
	ldc1 $f3,-8($10)              	# [11]  
	.loc	1 113 22
	madd.d $f6,$f2,$f1,$f24       	# [12]  
	.loc	1 114 22
	nmsub.d $f0,$f9,$f31,$f24     	# [13]  
	.loc	1 113 22
	madd.d $f10,$f31,$f9,$f24     	# [14]  
	.loc	1 114 22
	madd.d $f2,$f2,$f8,$f26       	# [15]  
	.loc	1 113 22
	nmsub.d $f1,$f1,$f6,$f26      	# [16]  
	.loc	1 114 22
	madd.d $f31,$f31,$f0,$f26     	# [17]  
	.loc	1 113 22
	nmsub.d $f9,$f9,$f10,$f26     	# [18]  
	.loc	1 114 22
	nmsub.d $f0,$f5,$f7,$f24      	# [19]  
	.loc	1 113 22
	madd.d $f10,$f7,$f5,$f24      	# [20]  
	.loc	1 114 22
	nmsub.d $f8,$f3,$f4,$f24      	# [21]  
	sdc1 $f2,16($12)              	# [22]  
	.loc	1 113 22
	madd.d $f6,$f4,$f3,$f24       	# [22]  
	sdc1 $f1,16($10)              	# [23]  
	.loc	1 114 22
	madd.d $f7,$f7,$f0,$f26       	# [23]  
	sdc1 $f31,8($12)              	# [24]  
	.loc	1 113 22
	nmsub.d $f5,$f5,$f10,$f26     	# [24]  
	sdc1 $f9,8($10)               	# [25]  
	.loc	1 114 22
	madd.d $f4,$f4,$f8,$f26       	# [25]  
	sdc1 $f7,0($12)               	# [26]  
	.loc	1 113 22
	nmsub.d $f3,$f3,$f6,$f26      	# [26]  
	.loc	1 110 19
	addiu $12,$12,32              	# [27]  
	.loc	1 113 22
	sdc1 $f5,0($10)               	# [27]  
	.loc	1 110 19
	addiu $10,$10,32              	# [28]  
	.loc	1 114 22
	sdc1 $f4,-40($12)             	# [28]  
	.loc	1 110 19
	bne $12,$13,.BB192.jacobi_    	# [29]  
	.loc	1 113 22
	sdc1 $f3,-40($10)             	# [29]  
.BB459.jacobi_: 	 # 0x313c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:459 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB191.jacobi_              	# [0]  
	nop                           	# [0]  
.BB219.jacobi_: 	 # 0x3144
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:219 frequency = 0.00000 (heuristic)
 #<freq>
	or $12,$8,$0                  	# [1]  
	or $5,$9,$0                   	# [1]  
.BB209.jacobi_: 	 # 0x314c
 #<loop> Loop body line 110, nesting depth: 4, estimated iterations: 3
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 110 short trip version
 #<swp>       (only executed when trip count <= 3)
 #<swp> 
 #<freq>
 #<freq> BB:209 frequency = 0.00000 (heuristic)
 #<freq> BB:209 => BB:209 probability = 0.66667
 #<freq> BB:209 => BB:460 probability = 0.33333
 #<freq>
	.loc	1 119 22
	ldc1 $f3,-8($5)               	# [0]  
	.loc	1 117 22
	ldc1 $f8,-8($12)              	# [2]  
	.loc	1 116 19
	ld $2,2096($sp)               	# [3]  .gra_spill_b054
	.loc	1 119 22
	ldc1 $f1,16($5)               	# [4]  
	ldc1 $f4,0($5)                	# [5]  
	.loc	1 116 19
	addu $4,$2,$12                	# [5]  
	.loc	1 119 22
	ldc1 $f2,8($5)                	# [6]  
	.loc	1 116 19
	addu $3,$2,$4                 	# [6]  
	addu $1,$2,$3                 	# [7]  
	.loc	1 117 22
	ldc1 $f31,-8($4)              	# [7]  
	ldc1 $f9,-8($1)               	# [8]  
	ldc1 $f10,-8($3)              	# [10]  
	.loc	1 120 22
	nmsub.d $f6,$f8,$f3,$f24      	# [11]  
	.loc	1 119 22
	madd.d $f0,$f3,$f8,$f24       	# [14]  
	.loc	1 120 22
	madd.d $f3,$f3,$f6,$f26       	# [15]  
	nmsub.d $f5,$f31,$f4,$f24     	# [16]  
	nmsub.d $f6,$f9,$f1,$f24      	# [17]  
	.loc	1 119 22
	nmsub.d $f8,$f8,$f0,$f26      	# [18]  
	.loc	1 120 22
	nmsub.d $f7,$f10,$f2,$f24     	# [19]  
	madd.d $f5,$f4,$f5,$f26       	# [20]  
	.loc	1 119 22
	madd.d $f4,$f4,$f31,$f24      	# [21]  
	madd.d $f0,$f1,$f9,$f24       	# [22]  
	.loc	1 120 22
	madd.d $f7,$f2,$f7,$f26       	# [23]  
	sdc1 $f3,-8($5)               	# [24]  
	.loc	1 119 22
	madd.d $f2,$f2,$f10,$f24      	# [24]  
	sdc1 $f8,-8($12)              	# [25]  
	nmsub.d $f31,$f31,$f4,$f26    	# [25]  
	.loc	1 120 22
	sdc1 $f5,0($5)                	# [26]  
	sdc1 $f7,8($5)                	# [27]  
	madd.d $f1,$f1,$f6,$f26       	# [27]  
	.loc	1 119 22
	nmsub.d $f9,$f9,$f0,$f26      	# [28]  
	sdc1 $f31,-8($4)              	# [28]  
	nmsub.d $f10,$f10,$f2,$f26    	# [29]  
	.loc	1 116 19
	ld $4,2192($sp)               	# [29]  .gra_spill_b066
	addiu $10,$10,4               	# [30]  
	.loc	1 120 22
	sdc1 $f1,16($5)               	# [30]  
	.loc	1 116 19
	addiu $5,$5,32                	# [31]  
	.loc	1 119 22
	sdc1 $f9,-8($1)               	# [31]  
	.loc	1 116 19
	addu $12,$2,$1                	# [32]  
	bne $10,$4,.BB209.jacobi_     	# [32]  
	.loc	1 119 22
	sdc1 $f10,-8($3)              	# [32]  
.BB460.jacobi_: 	 # 0x31f0
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:460 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB208.jacobi_              	# [0]  
	nop                           	# [0]  
.L.1.106.temp: 	 # 0x31f8
 #<loop> Loop body line 116, nesting depth: 4, estimated iterations: 5
 #<loop> Not unrolled: estimated schedule improvement < 10%
 #<loop> Not unrolled: disable analysis w/-CG:unroll_analysis=off
 #<swp> 
 #<swp> Pipelined loop line 116 short trip version
 #<swp>       (only executed when trip count <= 5)
 #<swp> 
 #<freq>
 #<freq> BB:68 frequency = 0.00000 (heuristic)
 #<freq> BB:68 => BB:68 probability = 0.80000
 #<freq> BB:68 => BB:461 probability = 0.20000
 #<freq>
	.loc	1 125 22
	ldc1 $f2,-8($13)              	# [0]  
	.loc	1 123 22
	ldc1 $f1,-8($12)              	# [1]  
	.loc	1 126 22
	nmsub.d $f0,$f1,$f2,$f24      	# [11]  
	.loc	1 125 22
	madd.d $f31,$f2,$f1,$f24      	# [12]  
	.loc	1 122 19
	ld $3,2104($sp)               	# [15]  .gra_spill_b055
	.loc	1 126 22
	madd.d $f2,$f2,$f0,$f26       	# [15]  
	.loc	1 122 19
	ld $1,2024($sp)               	# [16]  .gra_spill_b045
	.loc	1 125 22
	nmsub.d $f1,$f1,$f31,$f26     	# [16]  
	.loc	1 122 19
	ld $2,2208($sp)               	# [17]  .gra_spill_b068
	addiu $18,$18,1               	# [17]  
	.loc	1 126 22
	sdc1 $f2,-8($13)              	# [18]  
	.loc	1 122 19
	addu $13,$3,$13               	# [18]  
	.loc	1 125 22
	sdc1 $f1,-8($12)              	# [19]  
	.loc	1 122 19
	bne $18,$1,.L.1.106.temp      	# [19]  
	addu $12,$2,$12               	# [19]  
.BB461.jacobi_: 	 # 0x3234
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:461 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB225.jacobi_              	# [0]  
	nop                           	# [0]  
.BB251.jacobi_: 	 # 0x323c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:251 frequency = 0.00000 (heuristic)
 #<freq>
	or $12,$5,$0                  	# [0]  
.BB241.jacobi_: 	 # 0x3240
 #<loop> Loop body line 122, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolled 4 times
 #<swp> 
 #<swp> Pipelined loop line 122 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:241 frequency = 0.00000 (heuristic)
 #<freq> BB:241 => BB:241 probability = 0.50000
 #<freq> BB:241 => BB:358 probability = 0.50000
 #<freq>
	.loc	1 131 22
	ldc1 $f0,16($12)              	# [0]  
	.loc	1 129 22
	ldc1 $f31,16($10)             	# [1]  
	.loc	1 131 22
	ldc1 $f9,8($12)               	# [2]  
	.loc	1 129 22
	ldc1 $f7,8($10)               	# [3]  
	.loc	1 131 22
	ldc1 $f5,0($12)               	# [8]  
	.loc	1 129 22
	ldc1 $f3,0($10)               	# [9]  
	.loc	1 131 22
	ldc1 $f2,-8($12)              	# [10]  
	.loc	1 132 22
	nmsub.d $f6,$f31,$f0,$f24     	# [11]  
	.loc	1 129 22
	ldc1 $f1,-8($10)              	# [11]  
	.loc	1 131 22
	madd.d $f4,$f0,$f31,$f24      	# [12]  
	.loc	1 132 22
	nmsub.d $f10,$f7,$f9,$f24     	# [13]  
	.loc	1 131 22
	madd.d $f8,$f9,$f7,$f24       	# [14]  
	.loc	1 132 22
	madd.d $f0,$f0,$f6,$f26       	# [15]  
	.loc	1 131 22
	nmsub.d $f31,$f31,$f4,$f26    	# [16]  
	.loc	1 132 22
	madd.d $f9,$f9,$f10,$f26      	# [17]  
	.loc	1 131 22
	nmsub.d $f7,$f7,$f8,$f26      	# [18]  
	.loc	1 132 22
	nmsub.d $f10,$f3,$f5,$f24     	# [19]  
	.loc	1 131 22
	madd.d $f8,$f5,$f3,$f24       	# [20]  
	.loc	1 132 22
	nmsub.d $f6,$f1,$f2,$f24      	# [21]  
	sdc1 $f0,16($12)              	# [22]  
	.loc	1 131 22
	madd.d $f4,$f2,$f1,$f24       	# [22]  
	sdc1 $f31,16($10)             	# [23]  
	.loc	1 132 22
	madd.d $f5,$f5,$f10,$f26      	# [23]  
	sdc1 $f9,8($12)               	# [24]  
	.loc	1 131 22
	nmsub.d $f3,$f3,$f8,$f26      	# [24]  
	sdc1 $f7,8($10)               	# [25]  
	.loc	1 132 22
	madd.d $f2,$f2,$f6,$f26       	# [25]  
	sdc1 $f5,0($12)               	# [26]  
	.loc	1 131 22
	nmsub.d $f1,$f1,$f4,$f26      	# [26]  
	.loc	1 128 19
	addiu $12,$12,32              	# [27]  
	.loc	1 131 22
	sdc1 $f3,0($10)               	# [27]  
	.loc	1 128 19
	addiu $10,$10,32              	# [28]  
	.loc	1 132 22
	sdc1 $f2,-40($12)             	# [28]  
	.loc	1 128 19
	bne $12,$13,.BB241.jacobi_    	# [29]  
	.loc	1 131 22
	sdc1 $f1,-40($10)             	# [29]  
.BB358.jacobi_: 	 # 0x32cc
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:358 frequency = 0.00000 (heuristic)
 #<freq>
	b .-2436                      	# [0]  .BB240.jacobi_+4
	ld $1,2120($sp)               	# [0]  .gra_spill_b057
.BB268.jacobi_: 	 # 0x32d4
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:268 frequency = 0.00000 (heuristic)
 #<freq>
	or $12,$5,$0                  	# [0]  
	or $10,$6,$0                  	# [0]  
.BB258.jacobi_: 	 # 0x32dc
 #<loop> Loop body line 109, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 109 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:258 frequency = 0.00000 (heuristic)
 #<freq> BB:258 => BB:258 probability = 0.50000
 #<freq> BB:258 => BB:462 probability = 0.50000
 #<freq>
	.loc	1 113 22
	ldc1 $f3,0($12)               	# [0]  
	.loc	1 111 22
	ldc1 $f1,0($10)               	# [1]  
	.loc	1 113 22
	ldc1 $f0,-8($12)              	# [2]  
	.loc	1 114 22
	nmsub.d $f6,$f1,$f3,$f18      	# [3]  
	.loc	1 111 22
	ldc1 $f31,-8($10)             	# [3]  
	.loc	1 113 22
	madd.d $f5,$f3,$f1,$f18       	# [4]  
	.loc	1 114 22
	nmsub.d $f4,$f31,$f0,$f18     	# [5]  
	.loc	1 113 22
	madd.d $f2,$f0,$f31,$f18      	# [6]  
	.loc	1 114 22
	madd.d $f3,$f3,$f6,$f19       	# [7]  
	.loc	1 113 22
	nmsub.d $f1,$f1,$f5,$f19      	# [8]  
	.loc	1 114 22
	madd.d $f0,$f0,$f4,$f19       	# [9]  
	sdc1 $f3,0($12)               	# [10]  
	.loc	1 113 22
	nmsub.d $f31,$f31,$f2,$f19    	# [10]  
	.loc	1 110 19
	addiu $12,$12,16              	# [11]  
	.loc	1 113 22
	sdc1 $f1,0($10)               	# [11]  
	.loc	1 110 19
	addiu $10,$10,16              	# [12]  
	.loc	1 114 22
	sdc1 $f0,-24($12)             	# [12]  
	.loc	1 110 19
	bne $12,$13,.BB258.jacobi_    	# [13]  
	.loc	1 113 22
	sdc1 $f31,-24($10)            	# [13]  
.BB462.jacobi_: 	 # 0x3328
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:462 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB257.jacobi_              	# [0]  
	nop                           	# [0]  
.BB285.jacobi_: 	 # 0x3330
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:285 frequency = 0.00000 (heuristic)
 #<freq>
	or $5,$11,$0                  	# [1]  
	or $10,$7,$0                  	# [1]  
.BB275.jacobi_: 	 # 0x3338
 #<loop> Loop body line 110, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 110 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:275 frequency = 0.00000 (heuristic)
 #<freq> BB:275 => BB:275 probability = 0.50000
 #<freq> BB:275 => BB:463 probability = 0.50000
 #<freq>
	.loc	1 119 22
	ldc1 $f0,-8($5)               	# [0]  
	.loc	1 116 19
	ld $2,2096($sp)               	# [1]  .gra_spill_b054
	.loc	1 117 22
	ldc1 $f3,-8($10)              	# [2]  
	.loc	1 119 22
	ldc1 $f1,0($5)                	# [3]  
	.loc	1 116 19
	addu $1,$2,$10                	# [3]  
	.loc	1 120 22
	nmsub.d $f4,$f3,$f0,$f18      	# [4]  
	.loc	1 117 22
	ldc1 $f31,-8($1)              	# [4]  
	.loc	1 119 22
	madd.d $f6,$f0,$f3,$f18       	# [5]  
	.loc	1 120 22
	nmsub.d $f5,$f31,$f1,$f18     	# [6]  
	.loc	1 119 22
	madd.d $f2,$f1,$f31,$f18      	# [7]  
	.loc	1 120 22
	madd.d $f0,$f0,$f4,$f19       	# [8]  
	.loc	1 119 22
	nmsub.d $f3,$f3,$f6,$f19      	# [9]  
	.loc	1 116 19
	ld $4,2192($sp)               	# [10]  .gra_spill_b066
	.loc	1 120 22
	madd.d $f1,$f1,$f5,$f19       	# [10]  
	sdc1 $f0,-8($5)               	# [11]  
	.loc	1 119 22
	nmsub.d $f31,$f31,$f2,$f19    	# [11]  
	.loc	1 116 19
	addiu $5,$5,16                	# [12]  
	addiu $6,$6,2                 	# [12]  
	.loc	1 119 22
	sdc1 $f3,-8($10)              	# [12]  
	.loc	1 120 22
	sdc1 $f1,-16($5)              	# [13]  
	.loc	1 116 19
	addu $10,$2,$1                	# [14]  
	bne $6,$4,.BB275.jacobi_      	# [14]  
	.loc	1 119 22
	sdc1 $f31,-8($1)              	# [14]  
.BB463.jacobi_: 	 # 0x3394
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:463 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB274.jacobi_              	# [0]  
	nop                           	# [0]  
.BB303.jacobi_: 	 # 0x339c
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:303 frequency = 0.00000 (heuristic)
 #<freq>
	or $10,$16,$0                 	# [1]  
	or $6,$25,$0                  	# [1]  
.BB292.jacobi_: 	 # 0x33a4
 #<loop> Loop body line 116, nesting depth: 4, estimated iterations: 4
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 116 short trip version
 #<swp>       (only executed when trip count <= 4)
 #<swp> 
 #<freq>
 #<freq> BB:292 frequency = 0.00000 (heuristic)
 #<freq> BB:292 => BB:292 probability = 0.75000
 #<freq> BB:292 => BB:464 probability = 0.25000
 #<freq>
	.loc	1 125 22
	ldc1 $f3,-8($10)              	# [0]  
	.loc	1 122 19
	ld $1,2208($sp)               	# [1]  .gra_spill_b068
	ld $3,2104($sp)               	# [2]  .gra_spill_b055
	.loc	1 123 22
	ldc1 $f1,-8($6)               	# [3]  
	.loc	1 122 19
	addu $4,$1,$6                 	# [3]  
	addu $2,$3,$10                	# [4]  
	.loc	1 123 22
	ldc1 $f31,-8($4)              	# [4]  
	.loc	1 125 22
	ldc1 $f0,-8($2)               	# [5]  
	.loc	1 126 22
	nmsub.d $f6,$f1,$f3,$f18      	# [13]  
	.loc	1 125 22
	madd.d $f5,$f3,$f1,$f18       	# [14]  
	madd.d $f2,$f0,$f31,$f18      	# [15]  
	.loc	1 126 22
	nmsub.d $f4,$f31,$f0,$f18     	# [16]  
	madd.d $f3,$f3,$f6,$f19       	# [17]  
	.loc	1 125 22
	nmsub.d $f1,$f1,$f5,$f19      	# [19]  
	.loc	1 126 22
	madd.d $f0,$f0,$f4,$f19       	# [20]  
	sdc1 $f3,-8($10)              	# [20]  
	.loc	1 125 22
	nmsub.d $f31,$f31,$f2,$f19    	# [21]  
	.loc	1 122 19
	addu $10,$3,$2                	# [21]  
	ld $3,2024($sp)               	# [21]  .gra_spill_b045
	addiu $5,$5,2                 	# [22]  
	.loc	1 125 22
	sdc1 $f1,-8($6)               	# [22]  
	.loc	1 126 22
	sdc1 $f0,-8($2)               	# [23]  
	.loc	1 122 19
	addu $6,$1,$4                 	# [24]  
	bne $5,$3,.BB292.jacobi_      	# [24]  
	.loc	1 125 22
	sdc1 $f31,-8($4)              	# [24]  
.BB464.jacobi_: 	 # 0x3408
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:464 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB291.jacobi_              	# [0]  
	nop                           	# [0]  
.BB321.jacobi_: 	 # 0x3410
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:321 frequency = 0.00000 (heuristic)
 #<freq>
	or $12,$5,$0                  	# [0]  
	or $10,$6,$0                  	# [0]  
.BB311.jacobi_: 	 # 0x3418
 #<loop> Loop body line 122, nesting depth: 4, estimated iterations: 2
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 122 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:311 frequency = 0.00000 (heuristic)
 #<freq> BB:311 => BB:311 probability = 0.50000
 #<freq> BB:311 => BB:362 probability = 0.50000
 #<freq>
	.loc	1 131 22
	ldc1 $f3,0($12)               	# [0]  
	.loc	1 129 22
	ldc1 $f1,0($10)               	# [1]  
	.loc	1 131 22
	ldc1 $f0,-8($12)              	# [2]  
	.loc	1 132 22
	nmsub.d $f6,$f1,$f3,$f18      	# [3]  
	.loc	1 129 22
	ldc1 $f31,-8($10)             	# [3]  
	.loc	1 131 22
	madd.d $f5,$f3,$f1,$f18       	# [4]  
	.loc	1 132 22
	nmsub.d $f4,$f31,$f0,$f18     	# [5]  
	.loc	1 131 22
	madd.d $f2,$f0,$f31,$f18      	# [6]  
	.loc	1 132 22
	madd.d $f3,$f3,$f6,$f19       	# [7]  
	.loc	1 131 22
	nmsub.d $f1,$f1,$f5,$f19      	# [8]  
	.loc	1 132 22
	madd.d $f0,$f0,$f4,$f19       	# [9]  
	sdc1 $f3,0($12)               	# [10]  
	.loc	1 131 22
	nmsub.d $f31,$f31,$f2,$f19    	# [10]  
	.loc	1 128 19
	addiu $12,$12,16              	# [11]  
	.loc	1 131 22
	sdc1 $f1,0($10)               	# [11]  
	.loc	1 128 19
	addiu $10,$10,16              	# [12]  
	.loc	1 132 22
	sdc1 $f0,-24($12)             	# [12]  
	.loc	1 128 19
	bne $12,$13,.BB311.jacobi_    	# [13]  
	.loc	1 131 22
	sdc1 $f31,-24($10)            	# [13]  
.BB362.jacobi_: 	 # 0x3464
 #<loop> Part of loop body line 86, head labeled .L.1.79.temp
 #<freq>
 #<freq> BB:362 frequency = 0.00000 (heuristic)
 #<freq>
	b .-6900                      	# [0]  .BB310.jacobi_+4
	ld $1,2120($sp)               	# [0]  .gra_spill_b057
.BB338.jacobi_: 	 # 0x346c
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:338 frequency = 0.00000 (heuristic)
 #<freq>
	or $7,$5,$0                   	# [1]  
	or $10,$8,$0                  	# [1]  
.BB328.jacobi_: 	 # 0x3474
 #<loop> Loop body line 85, nesting depth: 2, estimated iterations: 2
 #<loop> Unrolled 2 times
 #<swp> 
 #<swp> Pipelined loop line 85 short trip version
 #<swp>       (only executed when trip count <= 2)
 #<swp> 
 #<freq>
 #<freq> BB:328 frequency = 0.00000 (heuristic)
 #<freq> BB:328 => BB:328 probability = 0.50000
 #<freq> BB:328 => BB:465 probability = 0.50000
 #<freq>
	.loc	1 141 13
	ldc1 $f0,0($6)                	# [0]  
	ldc1 $f1,-8($7)               	# [1]  
	ldc1 $f2,%gp_rel(.lit8-30720)($gp)	# [2]  
	ldc1 $f31,0($7)               	# [3]  
	.loc	1 143 13
	sdc1 $f2,-8($7)               	# [4]  
	sdc1 $f2,0($7)                	# [5]  
	.loc	1 141 13
	ldc1 $f2,-8($6)               	# [6]  
	add.d $f31,$f31,$f0           	# [15]  
	.loc	1 140 10
	addiu $10,$10,16              	# [16]  
	.loc	1 141 13
	sdc1 $f31,0($6)               	# [16]  
	.loc	1 142 13
	sdc1 $f31,-16($10)            	# [17]  
	.loc	1 141 13
	add.d $f1,$f1,$f2             	# [17]  
	.loc	1 140 10
	addiu $7,$7,16                	# [18]  
	.loc	1 141 13
	sdc1 $f1,-8($6)               	# [18]  
	.loc	1 140 10
	addiu $6,$6,16                	# [19]  
	bne $10,$13,.BB328.jacobi_    	# [19]  
	.loc	1 142 13
	sdc1 $f1,-24($10)             	# [19]  
.BB465.jacobi_: 	 # 0x34b8
 #<loop> Part of loop body line 66, head labeled .L.1.57.temp
 #<freq>
 #<freq> BB:465 frequency = 0.00000 (heuristic)
 #<freq>
	b .BB327.jacobi_              	# [0]  
	nop                           	# [0]  
	.end	jacobi_

	.section .lit8
	.origin 0x0
	.align	0
	# offset 0
	.dword	0x0000000000000000  	# double 0.00000
	.origin 0x10
	.align	0
	# offset 16
	.dword	0x3fc999999999999a  	# double 0.200000
	.origin 0x20
	.align	0
	# offset 32
	.dword	0x8000000000000000  	# double 0.00000

	.section .rodata
	.origin 0x0
	.align	0
	# offset 0
	.byte	0x4a, 0x41, 0x43, 0x4f, 0x42, 0x49, 0x3a, 0x20 	# JACOBI: 
	.byte	0x54, 0x6f, 0x6f, 0x20, 0x6d, 0x61, 0x6e, 0x79 	# Too many
	.byte	0x20, 0x69, 0x74, 0x65, 0x72, 0x61, 0x74, 0x69 	#  iterati
	.byte	0x6f, 0x6e, 0x73, 0x0 	# ons\000

	.section .lit8
	.origin 0x28
	.align	0
	# offset 40
	.dword	0x3fe0000000000000  	# double 0.500000
	.origin 0x8
	.align	0
	# offset 8
	.dword	0x3ff0000000000000  	# double 1.00000
	.origin 0x18
	.align	0
	# offset 24
	.dword	0x4059000000000000  	# double 100.000
	.globl	 s_wsle64
	.globl	 do_lioxh1
	.globl	 e_wsle64
	.section .text
	.align 4
	.section .lit8
	.align 3
	.section .rodata
	.align 3
	.gpvalue 30720

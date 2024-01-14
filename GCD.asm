.data
LIST: .word 10, 25
.global start
.text
start:
	la s0, LIST
	lw a1 0(s0) #Y
	lw a2 4(s0) #X
	addi a0, a0, 0
	jal GCD
	
	
	


Recurse:

	addi, sp, sp, -12
	sw a1, 0(sp)
	sw a2, 4(sp)
	sw ra 8(sp)
	add t0, a2, zero #t0 = x
	add a2, a1, zero
	rem  a1, t0, a1
	jal GCD
	
	lw a1, 0(sp)
	lw a2, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 12
	jr ra
	
GCD: 	bnez a1, Recurse
	add a0, a2, zero
	ebreak
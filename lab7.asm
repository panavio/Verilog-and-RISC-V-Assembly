.global _start
.text
_start:
	la s2, LIST
	addi s10, zero, 0 #s10 is sum
	addi s11, zero, 0 #s11 is counter
	# Write your code here
	WHILE:
	lw t0, 0(s2)    
	addi t1, t0, 1
	beq t1, zero, END 

	add s10, s10, t0  
	addi s2, s2, 4    
	addi s11, s11, 1  
	j WHILE

END: 
	ebreak
.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1
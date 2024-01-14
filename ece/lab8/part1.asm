.global _start
.global ONES
.text
_start:
	la s2, LIST
	#addi a0, zero, 0 #a0 is temp result for each word
	addi s10, zero, 0 #final result
	# Write your code here
	WHILE:
	lw t0, 0(s2)    #loads the word
	addi t1, t0, 1 #to stop
	beq t1, zero, END # to stop
	#addi a0, zero, 0
	
	jal ONES
	
	ble a0, s10, ELSE #if temp>stored result
		addi s10, a0, 0  # load the temp to stored res
		beq zero, zero, AFTER
	ELSE:
		beq zero, zero, AFTER
	
	AFTER:
		addi s2, s2, 4    #counter for adress, go to next address
	j WHILE
    #jal ONES


ONES:
	addi s5, s2, 0
	la s2, LIST # Load the memory address into s2
	lw s3, 0(s2)
	addi s4, zero, 0 # Register s4 will hold the result
ONELOOP:
	beqz s3, ENDONE # Loop until data contains no more 1’s
	srli s2, s3, 1 # Perform SHIFT, followed by AND
	and s3, s3, s2
	addi s4, s4, 1 # Count the string lengths so far
	b ONELOOP
ENDONE:
	add a0, s4, zero
	addi s2, zero, 0
	addi s2, s5, 0
	jr ra

END:
    ebreak
    
.global LIST
.data
LIST:
.word 0x1fffffff, 0x12345678, -1,#29 0x1D


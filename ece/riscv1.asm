.global _start
.text
_start:
    # Write your code here
    #lw s2, LIST
	lw s1, 0xffff0000
	#beqz s1, DATA_YES
	bnez s1, DATA_YES
	j _start
    
DATA_YES:
	lw s2, 0xffff0000
	lw s3, 0xffff0008
	#addi s3, s3, 1
	bnez s3, DISP_YES
	j DATA_YES
	
DISP_YES:
	lw s4, 0xffff0004
	li t0, 0xffff000c
	sw s4, 0(t0)
	#sw s4, 0(0xffff0000)
	#sb s4, 0(a0)
	j _start


END:
    ebreak    

.data

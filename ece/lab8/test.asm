.global _start
.text
_start:
    # Write your code here
    la s2, LIST
    la s3,LIST
    lw s0, 0(s2) #s0 has the number of elements in the list
    addi s0, s0, -1 #-1 because indexing starts at 0
    
    addi s10, zero, 0 #s10 is switch counter
    addi s11, zero, 0 #s11 is cycle counter 
    addi s2, s2, 4  #skip first element
    
WHILE:
    beq s11, s0, END #while cycle counter != element number

    addi s10, s11, 0 #switch counter starts from last cycle
WHILE_SUBSWITCH:
    beq s10, s0, AFTER #while switch counter !=element number
    addi a0, zero, 0 #set a0=0
    
    lw a1, 0(s2) #load word to registers
    lw a2, 4(s2)
    ble a2, a1, SWAP #check if should switch
    addi s2, s2, 4   #go to next element
    
    addi s10, s10, 1 #add 1 to switch counter
    j WHILE_SUBSWITCH
AFTER:
    addi s11, s11, 1  
    #addi s3, s3, 4
    
    addi s2, s3, 0
    addi s2, s2, 4
    j WHILE


SWAP:
    #swap a0 with a1, temp register a3 will be used
    addi a3, a2, 0 #a3=a2
    addi a2, a1, 0 #a2=a1
    addi a1, a3, 0 # a1=a3 (previously a2)
    sw a1 0(s2) #switch to new address
    sw a2, 4(s2)#switch no 2
    addi a0, zero, 1 #change status
    j WHILE_SUBSWITCH
    


END:
    ebreak    

.global LIST
.data
LIST:
.word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
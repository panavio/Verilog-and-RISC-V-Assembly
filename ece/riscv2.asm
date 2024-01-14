.data
# Messages
counter: .word 0
msg_1: .asciz "Please take a deep breath      "
msg_2: .space 32 
.asciz "Please drink some water        "
msg_3: .space 32 
.asciz "Please give your eyes a break  "
# Timer Related
timeNow:.word 0xFFFF0018 #current time/ timecount 0xFFFF001C for the upper 32 bits and 0xFFFF0018 for the lower 32 bits
cmp:	.word 0xFFFF0020 #time for new interrupt0xFFFF0024 for the upper 32 bits and 0xFFFF0020 for the lower 32 bits
.text
# Display Related
.eqv OUT_CTRL 0xffff0008
.eqv OUT 0xffff000C

main:
	la s0, cmp
	lw s0, 0(s0) #load word on time for new interrupt

	li s1, 5000 # Set time to trigger interrupt to be 5000 milliseconds (5 seconds)

	sw s1, 0(s0) # Set the handler address and enable interrupts
	
	la t0, timer_handler
	
	csrrw zero, utvec, t0 #set utvec to handler address
	csrrsi zero, ustatus, 0x1 #set interrupt enable bit
	csrrsi zero, uie, 0x10 #set bit 4 to enable timer

LOOP: 


	j LOOP
# Loop over the messages
# Print message to ASCII display
timer_handler:
	addi sp, sp, -4
	sw t1, 0(sp)
	sw t2, 4(sp)

	la t1, counter
	lw t2, 0(t1)
	addi t2, t2, 1
	sw t2, 0(t1)
	
	
	
	
	lw t2, 4(sp)
	lw t1, 0(sp)
	addi sp, sp, 8
	
	uret
# Push registers to the stack
# Indicate that 5 seconds have passed
# Pop registers from the stack

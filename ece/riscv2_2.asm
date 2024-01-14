.data
# Messages
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
	la s4, msg_1
	#mv s10, zero
	#addi s11, s11, 3
	li s1, 5000 # Set time to trigger interrupt to be 5000 milliseconds (5 seconds)
	li s10, 1
	li s11, 2
	sw s1, 0(s0) # Set the handler address and enable interrupts
	la t0, timer_handler
	
	csrrw zero, utvec, t0 #set utvec to handler address
	csrrsi zero, ustatus, 0x1 #set interrupt enable bit
	csrrsi zero, uie, 0x10 #set bit 4 to enable timer
timer_handler:
	# Push registers to the stack
	# Indicate that 5 seconds have passed
	# Pop registers from the stack
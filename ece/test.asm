.data
    # Messages
    msg_1: .asciz "Please take a deep breath "
    msg_2: .asciz "Please drink some water "
    msg_3: .asciz "Please give your eyes a break "

    # Timer Related
    timeNow: .word 0xFFFF0018 # current time
    cmp: .word 0xFFFF0020    # time for new interrupt

	.text
	# Display Related
	.eqv OUT_CTRL 0xffff0008
	.eqv OUT 0xffff000C

main:
    # Set up timer interrupt
    la t0, timer_handler  # Load address of the interrupt handler
    csrrw zero, utvec, t0  # Set utvec CSR to the handler address

    li t1, 1               # Set bit 4 of uie CSR to enable timer interrupts
    csrrsi zero, uie, 1

    li t2, 1               # Set bit 0 of ustatus CSR to enable user-level interrupts
    csrrsi zero, ustatus, 1

    # Initialize timecmp to 5000 milliseconds (5 seconds)
    la t3, cmp
    li t4, 5000
    sw t4, 0(t3)

    # Loop indefinitely
    j main

timer_handler:
    # Save registers to stack if necessary

    # Update timecmp for the next interrupt (5 seconds later)
    la t0, cmp
    lw t1, 0(t0)
    li t2, 5000
    add t1, t1, t2
    sw t1, 0(t0)

    # Display appropriate message based on the timecmp value
    la t0, cmp
    lw t1, 0(t0)

    la t2, msg_1
    la t3, msg_2
    la t4, msg_3

    bge t1, t2, check_msg2
    # Display msg_1
    lw a0, 0xffff000C
    la a1, msg_1
    jal display_message
    j timer_handler_done

check_msg2:
    bge t1, t3, check_msg3
    # Display msg_2
    lw a0, OUT
    la a1, msg_2
    jal display_message
    j timer_handler_done

check_msg3:
    # Display msg_3
    lw a0, OUT
    la a1, msg_3
    jal display_message

timer_handler_done:
    # Restore registers from stack if necessary
    ret

display_message:
    lw t0, OUT_CTRL
    li t1, 1
    sb t1, 0(t0)

    lw t0, OUT
    sb t1, 0(t0)

    lw t0, OUT_CTRL
    li t1, 1
    sb t1, 0(t0)

    jr ra
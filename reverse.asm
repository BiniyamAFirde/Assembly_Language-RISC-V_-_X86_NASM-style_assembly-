.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93

.data
msg:    .asciz "Enter a String: "
buffer: .space 256

.text

main:
    # Prompt
    la a0, msg
    li a7, printString
    ecall

    # Input
    la a0, buffer
    li a1, 256
    li a7, readString
    ecall

    # Process
    la a0, buffer
    jal function

    # Output
    la a0, buffer
    li a7, printString
    ecall

    # Exit
    li a0, 0
    li a7, sysExit
    ecall


# --- Reverse all digit sequences in string ---
function:
    mv t0, a0             # current position

scan_loop:
    lbu t2, 0(t0)
    beqz t2, done         # end of string?

    # Check if digit
    li t3, '0'
    bltu t2, t3, skip_char
    li t3, '9'
    bgtu t2, t3, skip_char

    # Found start of digits
    mv t1, t0             # start
find_end:
    addi t0, t0, 1
    lbu t2, 0(t0)
    beqz t2, reverse_seq  # end of string → reverse
    li t3, '0'
    bltu t2, t3, reverse_seq
    li t3, '9'
    bgtu t2, t3, reverse_seq
    j find_end

reverse_seq:
    addi t0, t0, -1       # step back to last digit
reverse_loop:
    bgeu t1, t0, resume   # stop when start >= end
    lbu t2, 0(t1)
    lbu t3, 0(t0)
    sb t3, 0(t1)
    sb t2, 0(t0)
    addi t1, t1, 1
    addi t0, t0, -1
    j reverse_loop

resume:
    addi t0, t0, 1        # move to next after digits
    j scan_loop

skip_char:
    addi t0, t0, 1
    j scan_loop

done:
    ret


# ============================================
# Problem 8: Remove characters preceded by digits
# Input: "abc5f67gh"
# Output: "abc567h"
# Explanation: remove 'f' (after '5'), remove 'g' (after '7')
# Time: 60-90 minutes
# ============================================

.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93

.data
buffer: .space 256

.text
main:
    la a0, buffer
    li a1, 256
    li a7, readString
    ecall
    
    la a0, buffer
    jal function
    
    la a0, buffer
    li a7, printString
    ecall
    
    li a0, 0
    li a7, sysExit
    ecall

function:
    mv t0, a0               # Source
    mv t1, a0               # Destination
    li t6, 0                # Prev was digit (0=no, 1=yes)
    
function_loop:
    lbu t2, 0(t0)
    addi t0, t0, 1
    beqz t2, loop_end
    
    # Check if current is digit
    li t3, '0'
    bltu t2, t3, not_digit
    li t3, '9'
    bgtu t2, t3, not_digit
    
    # Current IS digit - always copy
    sb t2, 0(t1)
    addi t1, t1, 1
    li t6, 1                # Set flag
    j function_loop
    
not_digit:
    # Current is NOT digit
    # If previous was digit, skip current
    bnez t6, skip_char
    
    # Previous was not digit, copy current
    sb t2, 0(t1)
    addi t1, t1, 1
    j function_loop
    
skip_char:
    li t6, 0                # Reset flag after skipping
    j function_loop
    
loop_end:
    sb zero, 0(t1)
    ret

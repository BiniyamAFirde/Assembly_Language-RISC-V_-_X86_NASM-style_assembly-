# ============================================
# Problem 7: Remove substring by positions
# Input: "abcdefgh" 2 4 → "abfgh"
# Input: "abcdefgh" 4 2 → "abfgh" (swap if needed)
# Input: "abcdefgh" 90 100 → "abcdefgh" (out of range)
# Input: "abcdefgh" 10 5 → "abcde" (partial range)
# Time: 120 minutes (FULL EXAM PROBLEM)
# ============================================

.eqv printString, 4
.eqv readString, 8
.eqv readInt, 5
.eqv sysExit, 93

.data
buffer: .space 256

.text
main:
    # Read string
    la a0, buffer
    li a1, 256
    li a7, readString
    ecall
    
    # Read position 1
    li a7, readInt
    ecall
    mv s0, a0               # s0 = pos1
    
    # Read position 2
    li a7, readInt
    ecall
    mv s1, a0               # s1 = pos2
    
    # Remove substring
    la a0, buffer
    mv a1, s0
    mv a2, s1
    jal remove_substring
    
    # Print result
    la a0, buffer
    li a7, printString
    ecall
    
    li a0, 0
    li a7, sysExit
    ecall

remove_substring:
    # a0 = string, a1 = pos1, a2 = pos2
    # Save registers
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    
    # Ensure pos1 <= pos2 (swap if needed)
    ble a1, a2, positions_ok
    mv t0, a1
    mv a1, a2
    mv a2, t0
    
positions_ok:
    # a1 = start (inclusive), a2 = end (inclusive)
    mv s0, a1               # Start position
    mv s1, a2               # End position
    
    # Find string length
    mv t0, a0
    li t1, 0                # Length
    
find_length:
    lbu t2, 0(t0)
    beqz t2, length_done
    addi t1, t1, 1
    addi t0, t0, 1
    j find_length
    
length_done:
    mv s2, t1               # s2 = string length
    
    # Handle out-of-range cases
    bge s0, s2, no_removal  # start >= length
    
    # Clamp end to string length - 1
    addi t0, s2, -1         # max valid index
    ble s1, t0, end_ok
    mv s1, t0
    
end_ok:
    # Copy characters before start
    # Then copy characters after end
    mv t0, a0               # Source
    mv t1, a0               # Destination
    li t2, 0                # Current index
    
    # Copy [0, start)
copy_before:
    bge t2, s0, skip_middle
    lbu t3, 0(t0)
    sb t3, 0(t1)
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, 1
    j copy_before
    
skip_middle:
    # Skip [start, end]
    addi t3, s1, 1          # end + 1
skip_loop:
    bge t2, t3, copy_after
    addi t0, t0, 1
    addi t2, t2, 1
    j skip_loop
    
copy_after:
    # Copy rest of string
    lbu t3, 0(t0)
    beqz t3, removal_done
    sb t3, 0(t1)
    addi t0, t0, 1
    addi t1, t1, 1
    j copy_after
    
removal_done:
    sb zero, 0(t1)          # Null terminate
    j restore_return
    
no_removal:
    # Positions out of range, do nothing
    
restore_return:
    lw s2, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 12
    ret

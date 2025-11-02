.eqv printString, 4
.eqv readString, 8
.eqv printInt, 1
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
 
    #mv a0, a0
    li a7, printInt
    ecall
    	
    li a0, 0
    li a7, sysExit
    ecall

function:
    mv t0, a0               # Current position
    li t1, 0                # Count
    li t2, 0                # In sequence flag (0=no, 1=yes)
    
loop:
    lbu t3, 0(t0)
    beqz t3, done
    
    # Check if digit
    li t4, '0'
    bltu t3, t4, not_digit
    li t4, '9'
    bgtu t3, t4, not_digit
    
    # Is digit
    beqz t2, new_sequence   # If not in sequence, start new
    j next_char             # Already in sequence, continue
    
new_sequence:
    addi t1, t1, 1          # Increment count
    li t2, 1                # Set in-sequence flag
    j next_char
    
not_digit:
    li t2, 0                # Reset flag (out of sequence)
    
next_char:
    addi t0, t0, 1
    j loop
    
done:
    mv a0, t1               # Return count
    ret

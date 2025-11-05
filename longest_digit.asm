
.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93

.data
buffer: .space 256
output: .space 256

.text
main:
   
    la a0, buffer
    li a1, 256
    li a7, readString
    ecall

    la a0, buffer
    la a1, output
    jal function

    la a0, output
    li a7, printString
    ecall

    li a0, 0
    li a7, sysExit
    ecall

function:
 
    mv t0, a0             
    li t1, 0       #counter       
    li t2, 0       #flag
    
scan_loop:
    lbu t3, 0(t0)           # Current char
    beqz t3, extract        # End of string
    
    # Check if digit
    li t4, '0'
    bltu t3, t4, skip
    li t4, '9'
    bgtu t3, t4, skip
    
    # Start of digit sequence
    mv t5, t0               # Sequence start
    li t6, 0                # Sequence length
    
count_seq:
    lbu t3, 0(t0)
    li t4, '0'
    bltu t3, t4, check_max
    li t4, '9'
    bgtu t3, t4, check_max
    
    addi t6, t6, 1          # Length++
    addi t0, t0, 1          # Next char
    j count_seq
    
check_max:
    # If current > max, update max
    ble t6, t1, scan_loop   # If cur <= max, continue
    mv t1, t6               # New max length
    mv t2, t5               # New max start
    j scan_loop
    
skip:
    addi t0, t0, 1
    j scan_loop
    
extract:
    # Copy longest sequence to output
    # t2 = start, t1 = length, a1 = output
    beqz t1, empty          # No digits found
    
    mv t0, t2               # Source
    mv t3, a1               # Destination
    mv t4, t1               # Counter
    
copy_loop:
    beqz t4, copy_done
    lbu t5, 0(t0)
    sb t5, 0(t3)
    addi t0, t0, 1
    addi t3, t3, 1
    addi t4, t4, -1
    j copy_loop
    
copy_done:
    sb zero, 0(t3)          # Null terminate
    ret
    
empty:
    sb zero, 0(a1)          # Empty output
    ret

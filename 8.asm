#Count only decimals
.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93
.eqv printInt, 1


.data
buffer: .space 256
msg: .asciz "Enter a String: "
return_msg: .asciz "The result is: "
.text
main:
	la a0, msg
	li a7, printString
	ecall
	
	la a0, buffer
	li a1, 256
	li a7, readString
	ecall
	
	la a0, buffer
	jal function
	
	mv a0, a0
	li a7, printInt
	ecall
	
	la a0, return_msg
	li a7, printString
	ecall
	
	la a0, buffer
	li a7, printString
	ecall
	
	li a0, 0
	li a7, sysExit
	ecall
	
function:
	mv t0, a0
	mv t1, a0
	li t4, 0
function_loop:
	
	lbu t2, 0(t0)
	addi t0, t0, 1
	beqz t2, loop_end
	
	li t3, '0'
	bltu t2, t3, function_loop
	li t3, '9'
	bgtu t2, t3, function_loop
	
	addi t4, t4, 1
	
save:
	sb t2, 0(t1)
	addi t1, t1, 1
	j function_loop
loop_end:
	sb zero, 0(t1)
	
	
	mv a0, t4
	ret
	

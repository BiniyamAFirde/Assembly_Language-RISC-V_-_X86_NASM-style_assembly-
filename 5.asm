.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93
.eqv printInt, 1


.data
buffer: .space 256
msg: .asciz "Enter a String: "

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
	
	li a0, 0
	li a7, sysExit
	ecall

function:
	mv t0, a0
	li t3, 0
	li t4, '\n'
	
function_loop:
	
	lbu t2, 0(t0)
	addi t0, t0, 1
	
	beqz t2, loop_end
	
	beq t2, t4, loop_end

	addi t3, t3, 1
	
	
	j function_loop
loop_end:
	mv a0, t3
	ret

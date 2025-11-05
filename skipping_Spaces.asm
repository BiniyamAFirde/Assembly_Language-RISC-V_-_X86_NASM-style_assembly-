.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93



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
	
	la a0, buffer
	li a7, printString
	ecall
	
	li a0, 0
	li a7, sysExit
	ecall
	
	
function:
	
	mv t0, a0
	mv t1, a0
	
	
	
function_loop:
	
	lbu t2, 0(t0)
	beqz t2, loop_end
	addi t0,t0,1
	
	
	li t3, ' '
	beq t2, t3, function_loop
	
	sb t2, 0(t1)
	addi t1, t1, 1
	
	j function_loop
	
loop_end:
	sb zero, 0(t1)
	ret	
	
	

  

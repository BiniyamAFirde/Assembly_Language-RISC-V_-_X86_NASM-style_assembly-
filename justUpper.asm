.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93



.data

msg: .asciz "Enter a String: "
buffer: .space 256

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
	addi t0,t0,1
	beqz t2, loop_end
	
process:
		
	li t3, 'a'
	bltu t2,t3, save
	li t3, 'z'
	bgtu t2,t3,save
	
	addi t2, t2, -32

	
save:
	sb t2, 0(t1)
	addi t1,t1,1
skip:
	j function_loop
loop_end:
	sb zero, 0(t1)
	ret
	
	
	
	
	
	

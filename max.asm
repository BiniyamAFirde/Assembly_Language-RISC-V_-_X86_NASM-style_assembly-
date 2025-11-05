#finding maximum integer: "abc789c54"=>>>"9"
.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93
.eqv printInt, 1



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
	
	mv a0, t6
	li a7, printInt
	ecall
	
	li a0, 0
	li a7, sysExit
	ecall
	
function:
	mv t0, a0
	li t1, 0
	li 
function_loop:
	lbu t2, 0(t0)
	addi t0,t0, 1
	beqz t2, loop_end
	
	li t3, '0'
	bltu t2, t3, function_loop
	li t3, '9'
	bgtu t2, t3, function_loop
	
	
	bleu t2, t6, function_loop
	mv t6, t2
	j function_loop
	

	# t3 * 10 + (t2-'0')
loop_end:
	li t5, '0'
	sub t6, t6, t5
	ret
	

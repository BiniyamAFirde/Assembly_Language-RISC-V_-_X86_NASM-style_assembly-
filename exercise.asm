.eqv printString, 4
.eqv readString, 8
.eqv printInt, 1
.eqv sysExit, 93

.data

msg: .asciz "Enter a String: "
buffer: .space 256

.text
main:

	la	a0, msg
	li	a7, printString
	ecall
	
	la	a0, buffer
	li	a1, 256
	li	a7, readString
	ecall
	
	la	a0, buffer
	jal	ra, function	# CORRECTED: Added 'ra' register
	
	
	mv	a1, a0
	li	a7, printInt
	mv	a0, a1
	ecall

	li	a0, 0
	li	a7, sysExit
	ecall
		
	
function:
	addi	t0, zero, 0

function_loop:

	lbu	t1, 0(a0)
	beqz	t1, loop_end
	
	# Check if digit (0-9)
	li	t2, '0'
	blt	t1, t2, check_A
	li	t2, '9'
	bgt	t1, t2, check_A
	li	t5, '0'
	sub	t1, t1, t5		# ASCII to integer
	j	accumulate
	
check_A:

	li	t2, 'A'
	beq	t1, t2, yesA
	li	t2, 'a'
	beq	t1, t2, yesA
	li	t2, 'B'
	beq	t1, t2, yesB
	li	t2, 'b'
	beq	t1, t2, yesB
	addi	a0, a0, 1
	j	function_loop
	
yesA:

	li	t1, 10
	j	accumulate
	
yesB:

	li	t1, 11
	j	accumulate
	
accumulate:
	
	li	t6, 12
	mul	t0, t0, t6
	add	t0, t0, t1
	addi	a0, a0, 1
	j	function_loop
	
loop_end:
	mv	a0, t0
	ret

.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93

.data

msg: .asciz "Hello World"
buffer: .space 100
number: .word 42


.text

main:
	la a0, msg
	li a7, printString
	ecall
	
	
	#Exit
	
	li a0, 0
	li a7, sysExit
	ecall

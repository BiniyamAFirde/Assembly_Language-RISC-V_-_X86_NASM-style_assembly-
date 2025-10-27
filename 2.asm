.eqv printString, 4
.eqv readString, 8
.eqv sysExit, 93
.eqv printInt, 1


.data

msg: .asciz "Wanna write something_?"
buffer: .space 256


.text

main:
	#print the prompt first
	
	la a0, msg
	li a7, printString
	ecall
	
	#scan the User_string
	
	la a0, buffer
	li a1, 256
	li a7, readString
	ecall
	
	#print the buffer from the User
	
	la a0, buffer
	li a7, printString
	ecall
	
	 #Exit the program
	 
	 li a0, 0
	 li a7, 93
	 ecall 

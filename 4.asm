.eqv printString, 4
.eqv readString, 8
.eqv printInt, 1
.eqv sysExit, 93

.data

msg: .asciz "Enter the String_"
buffer: .space 256
#output: .space 256
return_msg: .asciz "The result of the string without the space is: "


.text

main:
	#print the prompt
	la a0, msg
	li a7, printString
	ecall
	
	# Scan the given string
	
	la a0, buffer
	li a1, 256
	li a7, readString
	ecall
	
	#filtering
	
	la a0, buffer
	#la a1, output
	jal filtering
	
	la a0, return_msg
	li a7, printString
	ecall
	
	la a0, buffer
	li a7, printString
	ecall
	
	li a0, 0
	li a7, sysExit
	ecall
	
	
filtering:
	mv t0, a0
	mv t1, a0
		
filtering_loop:
	#we are reading here
	lbu t2, 0(t0)
	addi t0, t0, 1
	beqz t2, loop_end
	
	li t3, ' '
	beq t2, t3, filtering_loop
	
	#storing----because we are writing
	sb t2, 0(t1)
	addi t1,t1, 1
	
	j filtering_loop
loop_end:
	#write null-----
	sb zero, 0(t1)
	ret

	
	
	
	
	
	
	
	

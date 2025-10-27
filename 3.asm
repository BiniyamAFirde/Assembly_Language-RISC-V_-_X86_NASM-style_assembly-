.eqv printString, 4
.eqv readString, 8
.eqv printInt, 1
.eqv sysExit, 93


.data 

prompt: .asciz "Enter a number_"
buffer: .space 256
result_msg: .asciz "Length: "

.text

main:
	#print the prompt

	la a0, prompt
	li a7, printString
	ecall
	
	#Read the String from the User
	
	la a0, buffer
	li a1, 256
	li a7, readString
	ecall
	
	#Count the length
	
	la a0, buffer
	jal count_length
	

	#Store the number
	mv t6, a0
	
	
	#print result message
	la a0, result_msg
	li a7, printString
	ecall
	
	#print the number
	
	mv a0, t6
	li a7, printInt
	ecall
	
	#Exit
	
	li a0, 0
	li a7, sysExit
	ecall
	
count_length:
	
	mv t0, a0
	li t1, 0
	
count_loop:
	lbu t2, 0(t0)
	beqz t2, count_done
	
	li t3,'\n'
	beq t2,t3,count_done
	
	addi t1, t1, 1    #counter +++
	addi t0, t0, 1
	
	j count_loop
	
count_done:
	mv a0, t1
	ret	






	

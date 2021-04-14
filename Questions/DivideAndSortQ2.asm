.data
	userInput: .space 128 #user is allowed to enter a string with the length 128
	input: .asciiz "Input: " #string to use while asking for input
	output: .asciiz "Output: "
	newLine: .asciiz "\n" #to print new line

.text

	main:
	
		li $v0,4
		la $a0,input #print message
		syscall
	
		li $v0,8 #ask user for input
		la $a0,userInput
		li $a1,128 #assign user input to a0 register
		syscall
		
		li $v0,4
		la $a0,newLine #print message
		syscall
	
		
	
	
	
	
	exit:
		li $v0,10 #end program
		syscall
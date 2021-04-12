.data
	message: .asciiz "Enter the string: " #string to use while asking for input
	newLine: .asciiz "\n" #to print new line
	userInput: .space 100 #user is allowed to enter a string with the length 100
.text	
	main:
		
		li $v0,4
		la $a0,message #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,userInput
		li $a1,100
		syscall
		
		# index /offset   =$t0
		addi $t0,$zero,0 # just for index
		while:
		
		exit:
		
		li $v0,10
		syscall
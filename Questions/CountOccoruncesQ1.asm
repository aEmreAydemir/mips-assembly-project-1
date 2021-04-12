.data
	message: .asciiz "Enter the string: " #string to use while asking for input
	newLine: .asciiz "\n" #to print new line
	userInput: .space 100 #user is allowed to enter a string with the length 100
	counter: .word 0:26 #put 0 in 26 empty spaces for character counts in english alphabet
.text	
	main:
		
		li $v0,4
		la $a0,message #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,userInput
		li $a1,100
		syscall
		add $t2, $a0, $zero
		add $t1,$zero,$zero
		addi $t3,$zero,10
		
		loopString:
		lb $t0,0($t2)
		beq $t0, $zero, endLoop
		beq $t0,$t3,Pointer
		addi $t1,$t1,1
		
		Pointer:
		addi $t2,$t2,1
		j loopString
		endLoop:
		
		add $a0,$t1,$zero
		add $v0,$zero,1
		syscall
		
		li $v0,10
		syscall
		
		
		
		######from now on is not important
		# index /offset   =$t0
		addi $t0,$zero,0 # just for index
		while:
		beq $t0,100,exit
		lbu $t6, userInput($t0)
		li $v0,1
		addi $a0,$t6,0
		syscall
		
		li $v0,4
		la $a0,newLine
		syscall
		
		addi $t0,$t0,1
		j while
		exit:
		
		li $v0,10
		syscall
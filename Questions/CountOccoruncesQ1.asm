.data
	message: .asciiz "Enter the string: " #string to use while asking for input
	newLine: .asciiz "\n" #to print new line
	userInput: .space 128 #user is allowed to enter a string with the length 128
	counter: .word 0:26
	  #put 0 in 26 empty spaces for character counts in english alphabet
.text	
	main:
		
		li $v0,4
		la $a0,message #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,userInput
		li $a1,128
		syscall
		
		add $t0, $a0, $zero
		add $t1,$zero,$zero
		addi $t3,$zero,10 # dont know what this is?

		
		searchInput:
		lb $t2,0($t0)
		
		bgt $t2,64,identifyCase
		icContinue:
		
		beq $t2, $zero, endLoop 
		beq $t2,$t3,Pointer
		# #use as a counter
		
		Pointer:
		addi $t0,$t0,1
		j searchInput
		
		identifyCase:
		blt $t2,91,upperCase
		bgt $t2,96,lowerCase
		j icContinue
		upperCase:
		add $t2,$t2,-65
		mul $t2,$t2,4
		lw $t6,counter($t2)
		add $t6,$t6,1
		sw $t6,counter($t2)				
		j icContinue
		
		lowerCase:
		bgt $t2,123,icContinue
		add $t2,$t2,-97
		mul $t2,$t2,4
		lw $t6,counter($t2)
		add $t6,$t6,1
		sw $t6,counter($t2)
		j icContinue
		addi $t1,$t1,1
		
		
		
		
		endLoop:
		
		#add $a0,$t1,$zero
		#add $v0,$zero,1
		#syscall
		
		addi $t0,$zero,0
	
	while:
		beq $t0,104,exit
		
		lw $t6,counter($t0)
		li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,newLine
		syscall
		
		addi $t0,$t0,4
		j while	
	exit:
					
		li $v0,10
		syscall
		
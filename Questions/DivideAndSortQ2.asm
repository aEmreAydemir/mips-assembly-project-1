.data
	userInput: .space 128 #user is allowed to enter a string with the length 256
	input: .asciiz "Input: " #string to use while asking for input
	output: .asciiz "Output: "
	newLine: .asciiz "\n" #to print new line
	space: .asciiz " "
	integers: .word 0:128
	singleInt: .word -1:10
	
.text
	.globl Sort
	Sort:
	
		li $v0,4
		la $a0,input #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,userInput
		li $a1,128 #assign user input to a0 register
		syscall
		
		add $t0, $a0, $zero #put content of a0 in t0 register
		add $t1,$zero,$zero #initialize t1 as 1. we ll use t1 as a multiplier. if number is starting with -, multiplier is -1,
		# after the calculation multiply with t1 which will make it negative
		
	#	li $v0,4
	#	la $a0,newLine #print message
	#	syscall
		
		
		add $s0,$zero,$zero #out of t registers. so we ll use s0
		add $t3,$zero,1 #t3 will be used to find length of integers
		add $t4,$zero,$zero
		divideInput:
		lb $t2,0($t0) #pointer for the current char. t0 is our incrementor					
			
		
		
		#t0 pointer, , $t2 current char, #t3 sign #t4 length
		
		beq $t2,0,exit1 #if we reach new line, exit
		beq $t2,32,positiveSign #32 is for space char
		beq $t2,45,negativeSign #45 is for - char
				
		add $t2,$t2,-48
		mul $t5,$t4,4
		sw $t2,singleInt($t5)
	#	li $v0,1
	#	move $a0,$t2
	#	syscall		
		add $t4,$t4,1 #length
		add $t9,$zero,$t4
		j NewLine
		lineBack:
		
		add $t0,$t0,1
		add $t8,$zero,$zero					#t0 pointer, , $t2 current char, #t3 sign #t4 length, $t5 int pointer
		j divideInput					#t6 exponent # t8 int total
		
		checkLength:
		lw $t1, singleInt($t5)
		add $t4,$zero,$zero
		beq $t9,0,addToArray
		add $t9,$t9,-1
		mul $t7,$t6,$t1
		add $t8,$t8,$t7
		div $t6,$t6,10

		add $t5,$t5,4
		j checkLength
		exponent:
		
		add $t4,$t4,-1
		mul $t6,$t6,10
		beq $t4,1,checkLength
		
		
		j exponent
		
		addToArray:
		mul $t8,$t8,$t3
		#li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		#move $a0,$t8
		#syscall
		add $t4,$zero,1
		mul $t4,$s0,4
		sw $t8,integers($t4)
		
		add $s0,$s0,1
		add $t8,$zero,$zero
		add $t4,$zero,$zero
		add $t3,$zero,1
		j pointer
		
		positiveSign:
		add $t5,$zero,$zero
		add $t6,$zero,1
		beq $t3,-1,exponent
		add $t3,$zero,1 #make sure sign indicator is 1
		j exponent
		
		negativeSign:
		add $t3,$zero,-1 #make sure sign indicator is -1
		add $t4,$zero,$zero
		j pointer
		
		pointer:
		add $t0,$t0,1
		j divideInput
		
		NewLine:
		 
		j lineBack
		
		li $v0,4
		la $a0,output #print output
		syscall
		
		#li $v0,4
		#la $a0,userInput #print output
		#syscall
		#print ordered version here
	
		
	exit1:
		add $t3,$s0,-1
		add $t0,$zero,$zero
		add $t6,$zero,$zero
		mul $t3,$t3,4
		j exit
		while:
		beq $t0,512,exit #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
		lw $t6,integers($t0) #load the number of occorunces starting from a's occorunce
		li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,newLine
		syscall
		
		bge $t0,$t3,exit
		add $t0,$t0,4 #increment by 4 to get to the next int adress
		j while	
	exit:
		
		
		
		jal main

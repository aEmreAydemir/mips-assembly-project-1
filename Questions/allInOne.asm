.data
    	welcome:    	.asciiz		"Welcome to our MIPS project\n"
    	menu:		.asciiz		"\nMain Menu:\n"
	countAlphabet: 	.asciiz		"1. Count Alphabetic Characters\n"
	sortNumbers:	.asciiz		"2. Sort Numbers\n"
	primeNumbers :	.asciiz		"3. Prime(N)\n"
	huffman:	.asciiz		"4. Huffman Coding\n"
	exit:		.asciiz		"5. Exit\n"
	
	Q1message: .asciiz "Enter the string: " #string to use while asking for input
	Q1newLine: .asciiz "\n" #to print new line
	Q1userInput: .space 128 #user is allowed to enter a string with the length 128
	Q1counter: .word 0:26 #put 0 in 26 empty spaces for character counts in english alphabet
	Q1ordered: .word 0:26
	
	Q2userInput: .space 128 #user is allowed to enter a string with the length 256
	Q2input: .asciiz "Input: " #string to use while asking for input
	Q2output: .asciiz "Output: "
	Q2newLine: .asciiz "\n" #to print new line
	Q2space: .asciiz " "
	Q2integers: .word 0:128
	Q2singleInt: .word -1:10
	
	Q3message : .asciiz "Please enter an integer number for num_prime(N): "
	Q3output1 : .asciiz "prime("
	Q3output2 : .asciiz ") is: "
	Q3newLine : .asciiz "\n"
	Q3userInput: .word 0
	Q3table: .word 1:1000001 #look up table for prime number function. #all numbers are set to 1/true initially
	
.text

.globl main

		li $v0,4
		la $a0,welcome #print welcome message
		syscall
main:
		li $v0,4
		la $a0,menu
		syscall
		
		li $v0,4
		la $a0,countAlphabet
		syscall
		
		li $v0,4
		la $a0,sortNumbers
		syscall
		
		li $v0,4
		la $a0,primeNumbers
		syscall
		
		li $v0,4
		la $a0,huffman
		syscall
		
		li $v0,4
		la $a0,exit
		syscall
		
		li $v0,5 #asking user an int choice between 1-5. Depending on the input following
		syscall	#branch equal instructions will jump to different labels
		
		move $t0,$v0 #assign users entry into t0 register
		
		beq $t0,1,execAlphabet
    		beq $t0,2,execSort
    		beq $t0,3,execPrime
    		beq $t0,4,execHuffman
    		beq $t0,5,exitSys	
    		
    		j main # if user doesnt enter correctly this will jum to main
    		
    # call output function from other file. Just a way of reaching other assembly instructions
    execAlphabet:
    jal     CountAlphabet
    
    execSort:
    jal     Sort
    
    execPrime:
    jal     PrimeNumbers
    
    execHuffman:
    #jal     Huffman
    
    exitSys:
    # exit program
    li      $v0, 10
    syscall

	.globl CountAlphabet
	CountAlphabet:
		
		li $v0,4
		la $a0,Q1message #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,Q1userInput
		li $a1,128 #assign user input to a0 register
		syscall
		
		add $t0, $a0, $zero #put content of a0 in t0 register
		add $t1,$zero,$zero #initialize t1
		#addi $t3,$zero,0 # dont remember why do i add 10 here. This is not important anymore

		
		searchInput: #searching label.We start by taking the first char and then the rest. t2 holds chars
		lb $t2,0($t0) 
		
		bge $t2,65,identifyCase #if t2 s decimal value bigger than 65 go to case identify part otherwise iterate to the Pointer part
		icContinue: #icContinue is a label to come back whenever needed from case labels
		
		beq $t2, $zero, endLoop #if there are no chars left, endLoop
		#beq $t2,$t3,Pointer
		
		Pointer: #pointer points to the current char of string we work on.
		addi $t0,$t0,1 #increment pointer by 1
		j searchInput #jump back to search part
		
		identifyCase:
		#simply, we came here knowing that char => 65. if char is less or equal to 90 that makes it an upperCase.
		ble $t2,90,upperCase 
		bge $t2,97,lowerCase #if chars decimal is bigger or equal to 97 it "might" be an lowercase letter
		j Pointer #if neither of that is true, we dont need it change the char.
		
		
		upperCase:
		add $t2,$t2,-65 #if we subtract 65 from uppercase letters we get their alphabetical places A=0, B=1... etc
		mul $t2,$t2,4 #since integers need 4 bytes, their indexes are incremented by 4 for every int
		lw $t6,Q1counter($t2) #load word from the position of that chars index. Its initially 0 but it changes everytime the same
		#character occures so we load it back.
		
		add $t6,$t6,1 #increment older value by 1
		sw $t6,Q1counter($t2) #store new value at the same spot.
		add $t2,$zero,$zero #make sure t2 is back to 0 again to prevent possible bugs
		j Pointer #change the current char to the next char
		
		lowerCase:
		bge $t2,123,Pointer #we came here knowing that char=>65 and =>97. but we also need to check if its <=123. because we
		#only need lower case letters
		
		add $t2,$t2,-97 #subtract 97 to get the alphabetical index
		mul $t2,$t2,4 #find position by multiplying index
		lw $t6,Q1counter($t2) #load the current value at that index
		add $t6,$t6,1 #increment by 1
		sw $t6,Q1counter($t2) #store older value
		add $t2,$zero,$zero #make sure t2 is zero
		j Pointer #iterate to the next char
		
		# addi $t1,$t1,1
		
		
		
		
		endLoop: #label to end the loop simply
		
		#add $a0,$t1,$zero
		#add $v0,$zero,1
		#syscall
		add $t0,$zero,$zero
		add $t6,$zero,$zero
		add $t3,$zero,$zero
		#mul $t1,$s0,4
		add $t6,$1,-4
		addi $t6,$t6,104

				addi $t0,$zero,0 #clear t0
	
	while:
		beq $t0,104,exitQ1 #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
		lw $t6,Q1counter($t0) #load the number of occorunces starting from a's occorunce
		ble $t6,0,continueNext
		
		div $t3,$t0,4
		add $t3,$t3,97
		
		
		li $v0, 11
		move $a0,$t3
		syscall
		
		li $a0, ' '
		li $v0, 11
		syscall

		li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,Q1newLine
		syscall
		continueNext:
		addi $t0,$t0,4 #increment by 4 to get to the next int adress
		j while	
	exitQ1:
		
		jal     main #jump to main label inside Menu.asm			
		
			.globl Sort
	Sort:
	
		li $v0,4
		la $a0,Q2input #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,Q2userInput
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
		sw $t2,Q2singleInt($t5)
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
		lw $t1, Q2singleInt($t5)
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
		sw $t8,Q2integers($t4)
		
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
		la $a0,Q2output #print output
		syscall
		
		#li $v0,4
		#la $a0,userInput #print output
		#syscall
		#print ordered version here
	
		
	exit1:
		add $t1,$zero,$s0	
		add $t3,$s0,-1
		add $t0,$zero,$zero
		add $t6,$zero,$zero
		mul $t3,$t3,4
		#j exit
		
	
	
		
		
	#	while:
	#	beq $t0,512,exit #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
	#	lw $t6,integers($t0) #load the number of occorunces starting from a's occorunce
		#li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		#move $a0,$t6
		#syscall
		
		#li $v0,4
		#la $a0,newLine
		#syscall
		
		#bge $t0,$t3,exit
		#add $t0,$t0,4 #increment by 4 to get to the next int adress
		#j while	
		exitSort:
		add $t0,$zero,$zero
		add $t6,$zero,$zero
		add $t3,$zero,$zero
		mul $t1,$s0,4
		add $t6,$1,-4
	
		Q2sortNumbers:
		bge $t0,$t1,outOfSort
		
		add $t2,$zero,4
		
		innerSort:
		sub $t3,$t1,$t0
		bge $t2,$t3,outer
		add $t7,$t2,-4
		lw $t8,Q2integers($t7) # j - 1
		lw $t9,Q2integers($t2) # j
		bgt $t8,$t9,swap
		j noswap
		swap:
		lw $t5,Q2integers($t7) #temp
		sw $t9,Q2integers($t7)
		sw $t5,Q2integers($t2)
		noswap:
		
		
		add $t2,$t2,4
		j innerSort
		outer:
		
		add $t0,$t0,4
		j Q2sortNumbers
		
		
		outOfSort:
		add $t1,$zero,$s0	
		add $t3,$s0,-1
		add $t0,$zero,$zero
		add $t6,$zero,$zero
		mul $t3,$t3,4
		#j exit
		
	
	
		
		
		printSorted:
		beq $t0,512,out #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
		lw $t6,Q2integers($t0) #load the number of occorunces starting from a's occorunce
		li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,Q2newLine
		syscall
		
		bge $t0,$t3,out
		add $t0,$t0,4 #increment by 4 to get to the next int adress
		j printSorted	
		
		out:

		jal main
		#li $v0,10 #end program
		#syscall
		
		.globl PrimeNumbers

PrimeNumbers:
		li $v0,4
		la $a0,Q3message #print message to enter max number
		syscall
		
		li $v0,5 #asking int input from user into V0
		syscall
		
		move $t0,$v0 #assign users entry into t0 register
		
		add $t1,$zero,2 #initialize t1
		add $t2,$zero,$zero #t2 will be used for square of t1
		add $t7,$zero,-1 #to sign non primes we ll use t7. it holds value -1
	primeNumber:
		#outer loop of eratosthenes algorithm
	
		#t1 is the iterator value here. it starts at 2. square of t1 is stored in t2
		mul $t2,$t1,$t1 
		bgt $t2,$t0,breakOut #if t2 exceed value of input entered by user, breakOut of the loop
		
		mul $t5,$t1,4 #to reach the value of the array at index t5 multiply by 4. because we need 4 bytes for each int
		lw  $t4,Q3table($t5) #load the value of table at current index
		
		add $t3,$t2,$zero #t3 is for inner for loop 
		beq $t4,1, detectNonPrimes #if $t4 is 1/true, enter inner loop 
		#bne $t4,1,primeNumbersIncrementor
		
		j primeNumbersIncrementor #if not, we dont need to check this. increment index by 1
				
		detectNonPrimes:
		mul $t6,$t3,4 #again multiply by 4 to get current index at table array
		sw $t7,Q3table($t6) #since we know now its not prime, sign it with -1
		
		j detectNonPrimesIncrementor #increment iterator
		
		detectNonPrimesIncrementor:	
		add $t3,$t3,$t1 #our iterator is incremented by outer loops iterator value.
		bgt $t3,$t0,primeNumbersIncrementor #if it exceeds input value, breakout to outer loop
		j detectNonPrimes
		
		primeNumbersIncrementor:
		add $t1,$t1,1 #iterate to the next integer.
		j primeNumber
		
		breakOut:
		add $t6,$zero,$zero #t6 is our counter for primes we marked
		mul $t1,$t0,4 #t0 is what the user entered as input. by multiplying it with 4, we will set our loops top value
		add $t0,$zero,8 #we start from index 2 (4*2=8) since we dont check 0,1
		#add $t1,$t1,4	
		countPrimes:
		bgt $t0,$t1,Q3exit # limit value of loop is predefined at above code. its users input * 4bytes
		
		lw $t2,Q3table($t0) # load the value at current index

		beq $t2,1,incrementCounter #if its 1/true. it means its marked as prime. incrementCounter
		continueCounting:
		
		addi $t0,$t0,4 #increment by 4 to get to the next int adress
		j countPrimes	
		
		incrementCounter:
		add $t6,$t6,1 #if value is 1 increment counter here
		j continueCounting
					
Q3exit:
		li $v0,1
		move $a0,$t6
		syscall
		
    		jal     main #when the program is ended jump to menu instructions
		#li $v0,10 #end program
		#syscall
		
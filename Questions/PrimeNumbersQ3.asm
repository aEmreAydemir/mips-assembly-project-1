.data
	message : .asciiz "Please enter an integer number for num_prime(N): "
	output1 : .asciiz "prime("
	output2 : .asciiz ") is: "
	newLine : .asciiz "\n"
	userInput: .word 0
	table: .word 1:1000001 #look up table for prime number function. #all numbers are set to 1/true initially
.text
	.globl main

main:
		
		li $v0,4
		la $a0,message #print message to enter max number
		syscall
		
		li $v0,5 #asking int input from user into V0
		syscall
		
		move $t0,$v0 #assign users entry into t0 register
		
		add $t1,$zero,2 #initialize t1
		add $t2,$zero,$zero #t2 will be used for square of t1
		add $t7,$zero,-1 #to sign non primes
	primeNumber:
		mul $t2,$t1,$t1
		bgt $t2,$t0,breakOut
		
		mul $t5,$t1,4 #to reach the value of the array at index t5 multiply by 4
		lw  $t4,table($t5)
		
		beq $t4,1, detectNonPrimes
		bne $t4,1,primeNumbersIncrementor
		
		
		add $t3,$t2,$zero #t3 is for inner for loop
		detectNonPrimes:
		mul $t6,$t3,4
		sw $t7,table($t6)
		
		j detectNonPrimesIncrementor
		
		detectNonPrimesIncrementor:	
		add $t3,$t3,$t1
		bgt $t3,$t0,primeNumbersIncrementor
		j detectNonPrimes
		
		primeNumbersIncrementor:
		add $t1,$t1,1
		j primeNumber
		
	j breakOut
	j primeNumber
		
		breakOut:
		add $t6,$zero,$zero
		mul $t1,$t0,4
		add $t0,$zero,$zero
		#add $t1,$zero,2	
		countPrimes:
		beq $t0,$t1,exit #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
		lw $t2,table($t0) #load the number of occorunces starting from a's occorunce

		
		beq $t2,1,incrementCounter
		continueCounting:
		li $v0,1
		
		addi $t0,$t0,4 #increment by 4 to get to the next int adress
		j countPrimes	
		
		incrementCounter:
		add $t6,$t6,1
		j continueCounting
		
		
			
exit:
		li $v0,1
		move $a0,$t6
		syscall
		
		#li $v0,1
		#move $a0,$t1
		#syscall
		
		li $v0,10 #end program
		syscall
		
		

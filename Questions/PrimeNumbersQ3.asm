.data
	message : .asciiz "Please enter an integer number for num_prime(N): "
	output1 : .asciiz "prime("
	output2 : .asciiz ") is: "
	newLine : .asciiz "\n"
	userInput: .word 0
	table: .word 1:1000001 #look up table for prime number function. #all numbers are set to 1/true initially
.text
	.globl PrimeNumbers

PrimeNumbers:
		li $v0,4
		la $a0,message #print message to enter max number
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
		lw  $t4,table($t5) #load the value of table at current index
		
		add $t3,$t2,$zero #t3 is for inner for loop 
		beq $t4,1, detectNonPrimes #if $t4 is 1/true, enter inner loop 
		#bne $t4,1,primeNumbersIncrementor
		
		j primeNumbersIncrementor #if not, we dont need to check this. increment index by 1
				
		detectNonPrimes:
		mul $t6,$t3,4 #again multiply by 4 to get current index at table array
		sw $t7,table($t6) #since we know now its not prime, sign it with -1
		
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
		bgt $t0,$t1,exit # limit value of loop is predefined at above code. its users input * 4bytes
		
		lw $t2,table($t0) # load the value at current index

		beq $t2,1,incrementCounter #if its 1/true. it means its marked as prime. incrementCounter
		continueCounting:
		
		addi $t0,$t0,4 #increment by 4 to get to the next int adress
		j countPrimes	
		
		incrementCounter:
		add $t6,$t6,1 #if value is 1 increment counter here
		j continueCounting
					
exit:
		li $v0,1
		move $a0,$t6
		syscall
		
    		jal     main #when the program is ended jump to menu instructions
		#li $v0,10 #end program
		#syscall

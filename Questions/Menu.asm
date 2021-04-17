.data
    	welcome:    	.asciiz		"Welcome to our MIPS project\n"
    	menu:		.asciiz		"\nMain Menu:\n"
	countAlphabet: 	.asciiz		"1. Count Alphabetic Characters\n"
	sortNumbers:	.asciiz		"2. Sort Numbers\n"
	primeNumbers :	.asciiz		"3. Prime(N)\n"
	huffman:	.asciiz		"4. Huffman Coding\n"
	exit:		.asciiz		"5. Exit\n"
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
    jal     Huffman
    
    exitSys:
    # exit program
    li      $v0, 10
    syscall

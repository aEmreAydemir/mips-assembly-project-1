.data
	message: .asciiz "Enter the string: " #string to use while asking for input
	newLine: .asciiz "\n" #to print new line
	userInput: .space 128 #user is allowed to enter a string with the length 128
	counter: .word 0:26 #put 0 in 26 empty spaces for character counts in english alphabet
.text	
	.globl CountAlphabet
	CountAlphabet:
		
		li $v0,4
		la $a0,message #print message
		syscall
		
		li $v0,8 #ask user for input
		la $a0,userInput
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
		lw $t6,counter($t2) #load word from the position of that chars index. Its initially 0 but it changes everytime the same
		#character occures so we load it back.
		
		add $t6,$t6,1 #increment older value by 1
		sw $t6,counter($t2) #store new value at the same spot.
		add $t2,$zero,$zero #make sure t2 is back to 0 again to prevent possible bugs
		j Pointer #change the current char to the next char
		
		lowerCase:
		bge $t2,123,Pointer #we came here knowing that char=>65 and =>97. but we also need to check if its <=123. because we
		#only need lower case letters
		
		add $t2,$t2,-97 #subtract 97 to get the alphabetical index
		mul $t2,$t2,4 #find position by multiplying index
		lw $t6,counter($t2) #load the current value at that index
		add $t6,$t6,1 #increment by 1
		sw $t6,counter($t2) #store older value
		add $t2,$zero,$zero #make sure t2 is zero
		j Pointer #iterate to the next char
		
		# addi $t1,$t1,1
		
		
		
		
		endLoop: #label to end the loop simply
		
		#add $a0,$t1,$zero
		#add $v0,$zero,1
		#syscall
		
		addi $t0,$zero,0 #clear t0
	
	while:
		beq $t0,104,exit #104 comes from 26 * 4. 26 indexes for alphabets and 4 bytes of spaces for ints
		
		lw $t6,counter($t0) #load the number of occorunces starting from a's occorunce
		li $v0,1
		#addi $t6,$t6,0 #or USE move $a0,$t6
		move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,newLine
		syscall
		
		addi $t0,$t0,4 #increment by 4 to get to the next int adress
		j while	
	exit:
		
		jal     main #jump to main label inside Menu.asm			
		
		#li $v0,10 #end program
		#syscall
		

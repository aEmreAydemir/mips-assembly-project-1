.data
	prompt: .asciiz "enter your age:\n "
	message: .asciiz "\n your age is: "
	
.text

	#prompt u ser to enter age
	li $v0,4 #print a string
	la $a0,prompt
	syscall
	
	#get user input
	li $v0,5 #code to ask for int from user
	syscall  #number is stored in v0
	
	#store result in t0 temporarily
	move $t0,$v0 #move v0 to t0
	
	li $v0, 4
	la $a0 , message
	syscall
	
	li $v0,1
	move $a0,$t0
	syscall
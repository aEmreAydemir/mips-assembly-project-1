.data
	message: .asciiz "your name is: "
	userInput: .space 20 #this user Input will allow user to enter 20 chars/bytes long text
.text

	main:
		li $v0, 8
		la $a0, userInput
		li $a1,20
		syscall
		
		li $v0,4
		la $a0,message
		syscall
		
		li $v0,4
		la $a0,userInput
		syscall
	#tell system the end of main
	li $v0, 10 #always do this after main is finished
	syscall
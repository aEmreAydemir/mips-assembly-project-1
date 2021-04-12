.data

	message: .asciiz "hi, how are u"

.text

	main:
		addi $s0,$zero,15
		addi $s1,$zero,10
	
	bgt $s0,$s1,displayMessage #branch greater then, blt: branch less then 
	#bgtz branch is greater then zero
		
	#end main
	li $v0,10
	syscall
	
	
	displayMessage:
		li $v0, 4
		la $a0,message
		syscall
	
	
.data
	message : .asciiz "after while loop is done"
	space : .asciiz " "
.text

	main:
		addi $t0,$zero,0 #i=0
		
		while:
			bgt $t0, 10,exit #if value of t0 greater then 10 go to exit label
			jal printNumber
			addi $t0,$t0,1 #i++
			j while # go back to while loop
		
		exit:
		li $v0,4
		la $a0,message
		syscall
		
		#end of program
		li $v0,10
		syscall
		
		printNumber:
		li $v0,1
		add $a0,$t0,$zero
		syscall
		
		li $v0,4
		la $a0,space
		syscall
		jr $ra
		
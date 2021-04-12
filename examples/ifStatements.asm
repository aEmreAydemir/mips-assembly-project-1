.data
	message0:   .asciiz "numbers are not equal\n"
	message1:  .asciiz "numbers are equal\n"
.text
	main:
	
		addi $t0,$zero,20
		addi $t1,$zero,20
		
		beq $t0,$t1, numbersEqual #branch if equal. to compare t0 and t1. if its equal go to label numbersEqual
		bne $t0,$t1, numbersDifferent #branch not equal. go to numbersDifferent if not equal
	li $v0,10
	syscall #always end program after main
	
	#this are not procedure. they are labels and jr doesnt work for labels. fix later
	numbersEqual:
		li $v0,4
		la $a0,message1
		syscall #this will run if numbers are equal but it will still go to numbersDifferent. cant fix it right now
		#jr $ra.
		
		
		
	#numbersDifferent:
	#	li $v0,4
	#	la $a0,message0
	#	syscall
		#jr $ra this wont work 
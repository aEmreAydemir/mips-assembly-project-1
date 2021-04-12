.data

.text

	main:
	
	addi $a1,$zero,50 #use a registers to past value. put 50 in a1
	addi $a2,$zero,100 
	
	jal addNumbers
	
	li $v0,1
	addi $a0,$v1,0 #v1 is used as a return argumant
	syscall
	
	li $v0 , 10
	syscall #system will shutdown program
	
	addNumbers:
		add $v1, $a1,$a2
		#v1 is for return values so store in v1		
		jr $ra
.data
		number1: .word 20
		number2: .word 8
.text
	lw $s0, number1
	lw $s1, number2
	
	sub $t0,$s0,$s1 #t0= 20-8
	
	li $v0 ,1 #to print int
	
	move $a0, $t0 #move value of t0 to a0
	
	syscall
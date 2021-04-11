.data
	number1: .word 6
	number2: .word 20 #declare two ints to add in data section
.text
	lw $t0, number1($zero)
	lw $t1, number2($zero) #load number1 and num2 into t0 and t1 registers
	
	add $t2,$t0,$t1  # sum of t0 and t1 is added to t2
	
	 li $v0, 1 #print int
	 add $a0, $zero, $t2 #add t2+0  and load to a0
	 syscall
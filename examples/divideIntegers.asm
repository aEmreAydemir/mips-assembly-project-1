.data

.text
	#first way
	addi $t0, $zero, 30
	addi $t1, $zero , 4 #declare 30 and 5 to divide

	div $s0, $t0,$t1 #divide t0 by t1 and store it in s0
	li $v0,1
	add $a0,$zero,$s0
	#second way
	addi $t2,$zero, 40
	addi $t3 ,$zero,20
	
	div $t2,$t3 #result will go to lo register and remainder will be in hi register
	
	mflo $s1
	mfhi $s2	
	
	li $v0, 1
	add $a1, $zero,$s1 #try s2 for remainder
	#second way
	syscall


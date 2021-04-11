.data
	
.text
	########first way
	addi $s0, $zero , 100 #add 100 plus zero in s0. this is to create without using predeclared data
	addi $s1, $zero, 4
	
	mul $t0,$s0,$s1 #put the product of s0 and s1 into t0
	li $v0,1
	add $a0, $zero,$t0 #system will print argumant0 which is 40
	
	############another way of multiplication
	addi $t0, $zero , 2000
	addi $t1, $zero, 10
	
	mult $t0, $t1 #if u multiply this way result will be in lo and hi registers
	mflo $s0 #move product to s0 from lo
	
	#display
	li $v0, 1
	add $a0, $zero,$s0
	#################
	
	###third way
	addi $s0,$zero,4
	sll $t0,$s0,2 #shift left twice means multiply with 2^2
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	syscall
	
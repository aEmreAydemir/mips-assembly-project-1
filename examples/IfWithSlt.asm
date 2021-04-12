.data
	message: .asciiz "number is smaller"
.text

	addi $t0,$zero,1
	addi $t1,$zero,100
	
	#set less than
	slt $s0, $t0, $t1 # if t0 is smaller then t1 s0 is 1 otherwise 0
	bne $s0,$zero,printMessage #if s0 is not 0 its 1. which means t0 is smaller.
	
	#end program
	li $v0,10
	syscall
	
	printMessage:
		li $v0,4
		la $a0,message
		syscall
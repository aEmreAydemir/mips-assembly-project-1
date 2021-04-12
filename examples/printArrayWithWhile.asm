.data
	array: .word 3 5 12 53 24 # 5 elements declared. if i did like 3:5 . it would put 3 in all 5 indexes
	newLine: .asciiz "\n"
.text
	main:

	
	#clear $t0 to 0
	addi $t0,$zero,0
	
	while:
		beq $t0,20,exit
		
		lw $t6,array($t0)
		li $v0,1
		addi $a0,$t6,0 #or USE move $a0,$t6
		syscall
		
		li $v0,4
		la $a0,newLine
		syscall
		
		addi $t0,$t0,4
		j while	
	exit:
	
	#end program
	li $v0 ,10
	syscall
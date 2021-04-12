.data
	array: .space 12 #allocate 4bytes for each integer. allocated space for 3 integers  ######## INSIDE RAM
	newLine: .asciiz "\n"
.text
	main:
	addi $s0,$zero,4
	addi $s1,$zero , 11	########### INSIDE PROCESSOR
	addi $s2,$zero, 22
	
	# index /offset   =$t0
	addi $t0,$zero,0 # just for index
	
	sw $s0,array($t0) #put the s0 in first 4 bytes of array
	addi $t0,$t0,4 	#increment index by 4 because int is 4 bytes
	sw $s1,array($t0)
	addi $t0,$t0,4
	sw $s2,array($t0)
	
	#clear $t0 to 0
	addi $t0,$zero,0
	
	while:
		beq $t0,12,exit
		
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
.data

	newLine: .asciiz "\n" #to print a new line

.text

	main:
	
		addi $s0,$zero,10
		jal increaseRegister #first it will print 40, 
		
		li $v0,4
		la $a0,newLine
		syscall
		
		li $v0,1 #then 10
		move $a0,$s0
		syscall
	
	#signal the end of the program
	li $v0,10
	syscall
	
		increaseRegister:
			addi $sp, $sp, -4 #stack pointer. allocate 4 bytes
			sw   $s0, 0($sp) #save s0 in the 0. place of the stack. as a temporary value ####we dont need to do this with t registers
			
			addi $s0,$s0,30 #30 +10 =40 s0. do what you want with s0.
			#print
			li $v0,1
			move $a0,$s0
			syscall
			
			lw $s0,0($sp) #put old value(10) back to s0.
			addi $sp,$sp,4  #restore 4 bytes back to stack pointer
			jr $ra
			
			
			
			
			
			
			
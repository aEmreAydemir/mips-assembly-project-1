.data

	newLine: .asciiz "\n" #to print a new line

.text

	main:
	
		addi $s0,$zero,10
		jal increaseRegister #first it will print 40, 
		
		li $v0,4
		la $a0,newLine
		syscall
		
		jal printValue
	
	#signal the end of the program
	li $v0,10
	syscall
	
		increaseRegister:
			addi $sp, $sp, -8 #stack pointer. allocate 8 bytes
			sw   $s0, 0($sp) #save s0 in the 0. place of the stack. as a temporary value ####we dont need to do this with t registers
			
			sw   $ra,4($sp) #store return address at sp4
			
			addi $s0,$s0,30 #30 +10 =40 s0. do what you want with s0.
			
			jal printValue
			lw $s0, 0($sp)
			lw $ra,4($sp) #put old values back from sp to return address because otherwise it
			#will cause an overflow. Probably starts to an endless loop. keeps returning to same adress
			
			addi $sp,$sp,8  #restore 8 bytes back to stack pointer
			jr $ra
		
		printValue:
			#print
			li $v0,1
			move $a0,$s0
			syscall
			jr $ra
			
			
			
			
			
.data
	message: .asciiz "this is a text\n"
.text
	main:
	   jal displayMessage #jump to display message procedure
	   
	   addi $s0, $zero,5
	   
	   li $v0,1 #print 5
	   add $a0,$zero,$s0
	   syscall
	
	li $v0,10 #tell the system that the program is done.
	syscall
	
	displayMessage:
		li $v0,4
		la $a0,message
		syscall
		jr $ra #jump register a.  go back.
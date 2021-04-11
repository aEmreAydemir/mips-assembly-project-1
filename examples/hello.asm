.data
	message: .asciiz "hello world \n "  #declare data in .data part

.text  #text is for instructions

	li $v0, 4  #tell the system to print a message
	la $a0, message #load address of the message to print
	syscall #make the code run
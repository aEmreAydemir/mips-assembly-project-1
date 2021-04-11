.data
	character: .byte 'm'  #define a char of 8 bits. USE ' ' for char
.text

	li $v0,4
	la $a0 , character

	syscall
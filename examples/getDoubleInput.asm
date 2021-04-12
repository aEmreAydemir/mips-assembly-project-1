.data
	prompt: .asciiz "enter value of euler: "
.text
	#display message to user
	li $v0,4
	la $a0,prompt
	syscall
	
	#get double from user
	li $v0, 7 #7 is for double input
	syscall # double is stored in f0 and f1. because doubles are 64 bits long
	
	#display
	
	li $v0,3
	add.d $f12,$f0,$f10 #f10 has 0.0 in it so its ok.
	syscall
.data
	message: .asciiz "enter float: "
	zero: .float 0.0
.text
	lwc1 $f4, zero
	
	li $v0,4
	la $a0,message
	syscall
	
	#read float from kb
	li $v0,6 #6 is to read float
	syscall
	#float wont be in v0. it will be in f0
	
	li $v0, 2
	add.s $f12, $f0,$f4 #add f0 and 0 and save it in f12
	syscall 
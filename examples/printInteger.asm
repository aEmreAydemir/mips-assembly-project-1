.data

	age: .word 22 #use .word to define integer of 4bytes

.text

	li $v0, 1 # prepare the system to print an int / word
	lw $a0, age #move the value of age to a0
	syscall
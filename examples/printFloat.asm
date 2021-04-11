.data
	PI: .float 3.14
.text
	li   $v0, 2 #the value to print ints is 2
	lwc1 $f12, PI #load PI to float12 register from coprocessor1
	syscall
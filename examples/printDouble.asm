.data
	doubleVar: .double 84.44
	zeroDouble: .double 0.0 #zero register for doubles dosnt exist so create for your own
.text

	ldc1	$f2, doubleVar  #since a double is 64 bits we need 2 registers to hold a double value --->stored in f2 and f3
	ldc1	$f0, zeroDouble # stored in f0 and f1
	
	li $v0,3 #3 to print double
	add.d $f12, $f2,$f0 #add doubleVar and ZeroDouble together
	syscall
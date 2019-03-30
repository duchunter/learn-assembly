# Laboratory Exercise 7 Home Assignment 1

.text
main:
	li $a0, -45		# Load input parameter
	jal abs			# Jump and link to abs procedure
	nop
	add $s0, $zero, $v0
	li $v0, 10		# Terminate
	syscall

endmain:

#--------------------------------------------------------------------
# function abs
# param[in]	$a1	the interger need to be gained the absolute value
# return	$v0	absolute value
#--------------------------------------------------------------------

abs:
	sub $v0, $zero, $a0	# Put -(a0) in v0; in case (a0) < 0
	bltz $a0, done		#i f (a0) < 0 then done
	nop
	add $v0, $a1, $zero	# else put (a0) in v0
	
done:
	jr $ra
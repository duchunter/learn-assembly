# Laboratory Exercise 7, Assignment 2

.text
main:
	li $a0, 2		# Load test input
	li $a1, 6
	li $a2, 9
	jal max			# Call max procedure
	nop

endmain:

#---------------------------------------------------------------------
# Procedure max: find the largest of three integers
# param[in] $a0 integers
# param[in] $a1 integers
# param[in] $a2 integers
# return $v0 the largest value
#---------------------------------------------------------------------

max:
	add $v0, $a0, $zero	# Copy (a0) in v0; largest so far
	sub $t0, $a1, $v0	# Compute (a1)-(v0)
	bltz $t0, okay		# If (a1)-(v0)<0 then no change
	nop
	add $v0, $a1, $zero	# Else (a1) is largest thus far

okay:
	sub $t0, $a2, $v0	# Compute (a2)-(v0)
	bltz $t0, done		# If (a2)-(v0)<0 then no change
	nop
	add $v0, $a2, $zero	# Else (a2) is largest overall
	
done:
	jr $ra			# Return to calling program

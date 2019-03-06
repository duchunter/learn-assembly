# Exercise 4, Assignment 4
.text:
	li $s1 0x80000000	# Most negative
	li $s2 0x80000000	# Also most negative
	j start

start:
	li $t0, 0		# No Overflow is default status
	addu $s3, $s1, $s2	# s3 = s1 + s2
	
	xor $t1, $s1, $s2	# Test if s1 and s2 have the same sign
	bltz $t1, EXIT		# If not, exit
	
	xor $t1, $s1, $s3	# Test if s1 and s3 have the same sign
	bgtz $t1, EXIT		# If yes, exit
	
	xor $t1, $s2, $s3	# Test if s2 and s3 have the same sign
	bgtz $t1, EXIT		# If yes, exit
	
	j OVERFLOW

OVERFLOW:
	li $t0, 1		# The result is overflow
	j EXIT

EXIT:

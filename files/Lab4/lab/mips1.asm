# Exercise 4, Assignment 1
.text:
	li $s1 0x80000000	# Most negative
	li $s2 0x80000000	# Also most negative
	j start

start:
	li $t0, 0		# No Overflow is default status
	addu $s3, $s1, $s2	# s3 = s1 + s2
	xor $t1, $s1, $s2	# Test if s1 and s2 have the same sign
	
	bltz $t1, EXIT		# If not, exit
	slt $t2, $s3, $s1	# If s3 < s1, t2 = 1
	bltz $s1, NEGATIVE	# Test if s1 (or s2 if u like) is negative
	beq $t2, $zero, EXIT	# If s3 > s1 -> exit (true, positive + positive -> more positive)
	j OVERFLOW
	
NEGATIVE:
	bne $t2, $zero, EXIT	# If s3 < s1 -> exit (true, negative + negative -> more negative)
	j OVERFLOW

OVERFLOW:
	li $t0, 1		# The result is overflow
	j EXIT

EXIT:

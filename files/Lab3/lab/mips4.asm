# Assignment 4

# if (condition)
#	x=x+1;
#	z=1;
# else
#	y=y-1;
#	z=2*z;

# $s1 = i
# $s2 = j
# $t0 = comparision result
# $t1 = x
# $t2 = y
# $t3 = z

# $s3 = i + j
# $s4 = m
# $s5 = n
# $s6 = m + n

.text
	li $s1, 1	# i = 1
	li $s2, 3	# j = 3
	li $s4, 6	# m = 6
	li $s5, 9	# n = 9
	add $s3, $s1, $s2
	add $s6, $s4, $s5
	j start		# move to start

start:
	# a. i < j
	slt $t0, $s1, $s2
	beq $t0, $zero, else
	
	# b. i >= j
	slt $t0, $s1, $s2
	bne $t0, $zero, else
	
	# c. i + j <= 0
	slt $t0, $zero, $s3
	bne $t0, $zero, else
	
	# d. i + j >= m + n
	slt $t0, $s6, $s3
	bne $t0, $zero, else
	
	# then 
	addi $t1, $t1, 1		# then x = x + 1
	addi $t3, $zero, 1		# z = 1
	j endif				# skip "else" part
else:
	addi $t2, $t2, -1		# y = y -1
	add $t3, $t3, $t3		# z = z*2
endif:

# Home Assignment 1

# if (i<=j)
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

start:
	slt $t0, $s2, $s1		# j < i
	bne $t0, $zero, else		# branch to else if j < i
	addi $t1, $t1, 1		# then x = x + 1
	addi $t3, $zero, 1		# z = 1
	j				# skip "else" part
else:
	addi $t2, $t2, -1		# y = y -1
	add $t3, $t3, $t3		# z = z*2
endif:
# Home Assignment 3

# switch(test) {
#	case 0:
#		a=a+1; break;
#	case 1:
#		a=a-1; break;
#	case 2:
#		b=2*b; break;
# }


# $s0 = adress of test var
# $s1 = value of test var
# $s2 = a
# $s3 = b

.data
	test: .word 1

.text
	la $s0, test	# load the address of test variable
	lw $s1, 0($s0)  # load the value of test to register $t1
	
	# load value for test case
	li $t0, 0	
	li $t1, 1
	li $t2, 2
	
	# check condition
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2

case_0: 
	addi $s2, $s2, 1	# a=a+1
	j			# break
case_1: 
	sub $s2, $s2, $t1	# a=a-1
	j			# break
case_2: 
	add $s3, $s3, $s3	# b=b*2
	j			# break
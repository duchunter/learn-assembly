# Assigment 6

# loop:
#	if abs(A[i]) > max then max = A[i]
#	i += 1
#	if i < length then loop 

# $s1 = index i
# $s2 = starting address of A
# $s3 = array max index
# $s4 = max
# $s5 = index of max

# $to = current value of pointer at i of A
# $t1 = offset then current pointer value of A (*A[i])
# $t2 = temporary absolute value

.data
	A: .word 1, 2, 3, 4, 5, 6, 7, -17, 16

.text
	li $s1, 0	# i = 0
	la $s2, A	# load array
	li $s3, 8	# array max index = 8
	lw $s4, 0($s2)	# max = A[0]
	li $s5, 0	# index of max = 0
	j loop
	
loop:
	add $t1, $t1, $s2	# store the address of A[i]
	lw $t0, 0($t1)		# load value of A[i] in $t0
	abs $t2, $t0		# compute abs
	bgt $t2, $s4, greater	# if abs > max
	j increment
	
greater:
	add $s4, $zero, $t0	# max = A[i]
	add $s5, $zero, $s1	# index of max = i
	j increment
	
	
increment:
	add $s1, $s1, 1		# i += 1
	add $t1, $s1, $s1	# t1=2 * s1
	add $t1, $t1, $t1	# t1=4 * s1
	bne $s1, $s3, loop	# if i != length, goto loop
	

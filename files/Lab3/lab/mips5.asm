# Assigment 5

# loop: i=i+step;
# 	Sum=sum+A[i];
# 	If(I !=n) goto loop;

# $s1 = index i
# $s2 = starting address of A
# $s3 = comparison const n
# $s4 = step
# $s5 = sum
# $to = current value of pointer at i of A
# $t1 = offset then current pointer value of A (*A[i])

.data
	A: .word 1, 2, 3, 4, 5, 6, 7

.text
	li $s1, 0
	la $s2, A
	li $s3, 3
	li $s4, 1
	li $s5, 0
	j loop
	
loop:
	add $t1, $t1, $s2	# t1 store the address of A[i]
	lw $t0, 0($t1)		# load value of A[i] in $t0
	add $s5, $s5, $t0	# sum=sum+A[i]
	add $s1, $s1, $s4	# i=i+step
	add $t1, $s1, $s1	# t1=2*s1
	add $t1, $t1, $t1	# t1=4*s1
	
	# a. i < n
	blt $s1, $s3, loop
	
	# b. i <= n
	sgt $s0, $s1, $s3
	beq $0, $zero, loop
	
	# c. sum >= 0
	slt $s0, $s5, $zero
	beq $s0, $zero, loop
	
	# d. A[i] == 0
	beq $t0, $zero, loop

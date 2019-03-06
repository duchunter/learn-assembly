# Exercise 4, Assignment 3
.text
	li $s1, -4
	li $s2, 2
	
	# a. abs $s0, $s1 (s0 = |s1|)
	nor $s0, $s1, $zero
	addi $s0, $s0, 1
	
	# b. move $s0, $s1 ($s0 = $s1)
	addi $s0, $s1, 0
	
	# c. not $s0, (s0 = invert s0)
	nor $s0, $s0, $zero
	
	# d. ble $s1, $s2, L (if (s1 <= s2) j L)
	slt $t0, $s2, $s1
	beq $t0, $zero, L

L:
	li $t1, 1
	
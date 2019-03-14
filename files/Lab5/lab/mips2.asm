# Laboratory Exercise 5, Assignment 2
.data
	msg: .asciiz "The sum of "
	msg1: .asciiz " and "
	msg2: .asciiz " is "
.text
	li $s0, 1		# s0 = 1
	li $s1, 3		# s1 = 3
	add $t0, $s0, $s1	# t0 = s0 + s1
	
	# The sum of
	li $v0, 4
	la $a0, msg
	syscall 
	
	# $s0
	li $v0, 1
	move $a0, $s0
	syscall 
	
	# and
	li $v0, 4
	la $a0, msg1
	syscall 
	
	# $s1
	li $v0, 1
	move $a0, $s1
	syscall 
	
	# is
	li $v0, 4
	la $a0, msg2
	syscall 
	
	# $t0
	li $v0, 1
	move $a0, $t0
	syscall 
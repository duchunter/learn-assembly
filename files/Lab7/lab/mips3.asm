# Laboratory Exercise 7, Assignment 3

.text
main:
	li $s0, 2
	li $s1, 5
	
push:
	addi $sp, $sp, -8	# adjust the stack pointer
	sw $s0, 4($sp)		# push $s0 to stack
	sw $s1, 0($sp)		# push $s1 to stack
	
work:
	nop
	nop
	nop

pop:
	lw $s0, 0($sp)		# pop from stack to $s0
	addi $sp, $sp, 4	# adjust the stack pointer
	lw $s1, 0($sp)		# pop from stack to $s1
	

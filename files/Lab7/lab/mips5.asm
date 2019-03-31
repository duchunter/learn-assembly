# Laboratory Exercise 7, Assignment 5

.data
	Largest: .asciiz "Largest: "
	Smallest: .asciiz "\nSmallest: "
	At: .asciiz ","

.text
main:
	# Init value
	li $s0, 3
	li $s1, 6
	li $s2, 9
	li $s3, 4
	li $s4, 7
	li $s5, 5
	li $s6, 1
	li $s7, 8
	
	# Save all value to stack
	addi $sp, $sp, -32		# allocate space for 8 value
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	
	lw $t0, 0($sp)		# init largest value t0 = s0 (pop from stack)
	addi $sp, $sp, 4	# adjust the stack pointer
	li $t1, 0		# init largest index t1 = 0
	move $t2, $s0		# init smallest value t2 = s0
	li $t3, 0		# init smallest index t3 = 0
	li $a1, 0		# init current index = 0
	jal find
	
print:
	# Largest
	li $v0, 4
	la $a0, Largest 
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, At 
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	
	# Smallest
	li $v0, 4
	la $a0, Smallest 
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, At 
	syscall
	li $v0, 1
	move $a0, $t3
	syscall

quit:
	li $v0, 10
	syscall

#===============================================================================
# Procedure find
# increase index at a1
# if a1 > 7 -> jump back to main
# pop value to a0, adjust stack pointer
# if a0 > t0 (max) set t0 = a0 and t1 = a1 (index)
# if a0 < t2 (min) set t2 = a0 and t3 = a1
#===============================================================================	
find:
	addi $a1, $a1, 1	# increase index
	addi $a2, $a1, -7
	bgtz $a2, done		# check if index > 7
	lw $a0, 0($sp)		# pop from stack
	addi $sp, $sp, 4	# adjust the stack pointer
	bgt $a0, $t0, set_max
	blt $a0, $t2, set_min
	j continue
	
set_max:
	move $t0, $a0
	move $t1, $a1
	j continue

set_min:
	move $t2, $a0
	move $t3, $a1
	j continue
	
continue:
	j find

done:
	jr $ra
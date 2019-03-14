# Laboratory Exercise 5, Assignment 5
.data
	string: .space 50
	Message1: .asciiz "Enter string:"
	Message2: .asciiz "Reverse string:"
	
.text
main:

get_string:
	li $v0, 54
	la $a0, Message1
	la $a1, string
	la $a2  50
	syscall

move_to_end:
	la $a3, string			# a0 = Address(string[0])
	xor $t0, $zero, $zero		# t0 = i = 0
	
check_char:
	add $t1, $a3, $t0		# t1 = a0 + t0 = Address(string[0] + i)
	lb $t2, 0($t1)			# t2 = string[i]
	beq $t2, $zero, end_of_str 	# Is null char?
	addi $t0, $t0, 1		# t0 = t0 + 1-> i = i + 1
	j check_char
	
end_of_str:
	addi $t0, $t0, -2		# Terminate \n

print_reverse_string:
	li $v0 , 4
	la $a0 , Message2
	syscall
	
print_from_last:
	add $t1, $a3, $t0		# t1 = a0 + t0 = Address(string[0] + i)
	lb $t2, 0($t1)			# t2 = string[i]
	beq $t2, $zero, stop_printing 	# Is null char?
	addi $t0, $t0, -1		# t0 = t0 - 1-> i = i - 1
	li $v0 , 11
	move $a0 , $t2
	syscall
	j print_from_last

stop_printing:
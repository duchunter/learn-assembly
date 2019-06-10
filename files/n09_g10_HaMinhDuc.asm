# Ha Minh Duc - 20161067
# Problem 9: Write a program to:
# - Display DCE image
# - Display DCE without colors
# - Shuffle letter
# - Display DCE with colors inputed from keyboard

.eqv HEIGHT 	16
.eqv LENGTH 	59
.eqv START_D 	0
.eqv END_D   	22
.eqv START_C 	22
.eqv END_C   	42
.eqv START_E 	42
.eqv END_E 	58

.data
	# The image (0 - 22), (23 - 42), (43 - 58), (1), length 59, height: 16
	Line1: .ascii "                                           *************  \n"
	Line2: .ascii " **************                           *3333333333333* \n"
	Line3: .ascii "*222222222222222*                         *33333********  \n"
	Line4: .ascii "*22222******222222*                       *33333*         \n"
	Line5: .ascii "*22222*      *22222*                      *33333********  \n"
	Line6: .ascii "*22222*       *22222*      *************  *3333333333333* \n"
	Line7: .ascii "*22222*       *22222*    **11111*****111* *33333********  \n"
	Line8: .ascii "*22222*       *22222*  **1111**       **  *33333*         \n"
	Line9: .ascii "*22222*      *222222*  *1111*             *33333********  \n"
	LineA: .ascii "*22222*******222222*  *11111*             *3333333333333* \n"
	LineB: .ascii "*2222222222222222*    *11111*              *************  \n"
	LineC: .ascii " ***************      *11111*                             \n"
	LineD: .ascii "      ---              *1111**                            \n"
	LineE: .ascii "    / o o \\             *1111****   *****                 \n"
	LineF: .ascii "    \\   > /             **111111***111*                   \n"
	LineG: .ascii "     -----                ***********     dce.hust.edu.vn \n"
	EndLine: .asciiz ""
	
	# The menu
	Menu: .asciiz "\n\n1. Original image\n2. Only border\n3. Shuffle (ECD)\n4. Custom colors\n\n0. Exit\n\nEnter your choice: "
	ColorD: .asciiz "Color for D: "
	ColorC: .asciiz "Color for C: "
	ColorE: .asciiz "Color for E: "
	
.text
main:
	# Display menu
	la $a0, Menu
	li $v0, 4
	syscall
	
	# Get input integer, input value stored in v0
	li $v0, 5
	syscall
	
	# 0. Exit
	beq $v0, $zero, end
	
	# 1. Original image
	li $a0, 1
	beq $v0, $a0, original_image
	
	# 2. Only border
	li $a0, 2
	beq $v0, $a0, only_border
	
	# 3. Shuffle
	li $a0, 3
	beq $v0, $a0, shuffle
	
	# 4. Custom colors
	li $a0, 4
	beq $v0, $a0, custom_colors
	
	# Default loop
	j main
	
	
# 1. Print original image
original_image:
	la $a0, Line1
	li $v0, 4
	syscall
	j main


# 2. Only border
only_border:
	# Reserve a0 for character to print
	la $a1, Line1
	La $a2, EndLine
	li $s0, 48		# 0, bound left
	li $s1, 57		# 9, bound right
	li $v0, 11		# Print character  mode

only_border_loop:
	lb $a0, 0($a1)
	blt $a0, $s0, only_border_increment	# if character < 0
	bgt $a0, $s1, only_border_increment	# if character > 9
	li $a0, 32				# set character = space

only_border_increment:
	syscall
	addi $a1, $a1, 1
	beq $a1, $a2, main
	j only_border_loop


# 3. Shuffle (ECD)
shuffle:
	# Reserve a0 for character to print
	la $a1, Line1
	La $a2, EndLine
	li $v0, 11			# Print character  mode
	
print_e:
	addi $s0, $a1, START_E		# Start of e
	addi $s1, $a1, END_E		# End of e
	jal shuffle_print_char
		
print_c:
	addi $s0, $a1, START_C		# Start of c
	addi $s1, $a1, END_C		# End of c
	jal shuffle_print_char

print_d:
	addi $s0, $a1, START_D		# Start of d
	addi $s1, $a1, END_D		# End of d
	jal shuffle_print_char

print_new_line:
	addi $a1, $a1, LENGTH
	addi $a1, $a1, -1
	lb $a0, 0($a1)
	syscall
	addi $a1, $a1, 1
	beq $a1, $a2, main		# Exit if reach end
	j print_e			# or print next line

# Print a character (D/C/E)
# s0: start address
# s1: end address
shuffle_print_char:
	lb $a0, 0($s0)
	syscall
	addi $s0, $s0, 1
	blt $s0, $s1, shuffle_print_char		# Continue if not end
	jr $ra

	
# 4. Custom colors
custom_colors:
	# Ask for color of D, store in s0
	la $a0, ColorD
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	move $s0, $v0
	li $v0, 12		# Clear leftover new line character
	syscall
	
	# Ask for color of C, store in s1
	la $a0, ColorC
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	move $s1, $v0
	li $v0, 12		# Clear leftover new line character
	syscall
	
	# Ask for color of E, store in s2
	la $a0, ColorE
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	move $s2, $v0
	li $v0, 12		# Clear leftover new line character
	syscall
	
	# Reserve a0 for character to print
	la $a1, Line1
	La $a2, EndLine
	li $s3, 50		# Current color of D (48 + 2)
	li $s4, 49		# Current color of C (48 + 1)
	li $s5, 51		# Current color of E ( 8 + 3)
	li $v0, 11		# Print character mode

custom_colors_loop:
	lb $a0, 0($a1)
	beq $a0, $s3, change_d		# if character = color of D
	beq $a0, $s4, change_c		# if character = color of C
	beq $a0, $s5, change_e		# if character = color of E
	j custom_colors_increment	# else print it

change_d:
	move $a0, $s0
	j custom_colors_increment

change_c:
	move $a0, $s1
	j custom_colors_increment
	
change_e:
	move $a0, $s2
	j custom_colors_increment

custom_colors_increment:
	syscall
	addi $a1, $a1, 1
	beq $a1, $a2, main
	j custom_colors_loop
	
																			
end:
	

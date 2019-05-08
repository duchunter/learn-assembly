#NguyenTrungThanh - 20163727

.data
	prompt: .asciiz "Enter the i number to display: " 
	label: .asciiz "i power(2,i) square(i) Hexadeical(i) \n"
	theResult: .word 0
	theNumber: .word 0
	theSpace: .asciiz " "
	tenSpace: .asciiz "          "
	fourSpace: .asciiz "    "
	mask: .asciiz "0x"
	result: .space 8
.text
.globl main
main:
	# scan input  
	la $a0, prompt		# Print promt to screen
	li $v0, 4
	syscall
	
	li $v0, 5		# Get input from stdin
	syscall
	
	sw $v0, theNumber	# save input to constant
	
	la $a0, label		# print the labe; to screen
	jal print_result
	
	lw $a0, theNumber	# print i
	li $v0, 1
	syscall
	
	la $a0, theSpace	# print space between
	jal print_result
	
	lw $a0, theNumber	# pass constant number to parameter
	jal findPower2		# Calculate power i of 2
	sw $v0, theResult	# save result to v0 for printing
	jal printResult		# printing power i of 2
	
	la $a0, tenSpace	# print space
	jal print_result

	lw $a0, theNumber	# pass constant number to parameter
	jal findSquare		# calculate square of i
	sw $v0, theResult	# save result to v0
	jal printResult		# print square of i
	
	la $a0, fourSpace	# print 4 spaces
	jal print_result	
				
	la $a0, mask		# print 0x
	jal print_result
					
	lw $v0, theNumber		#Recover v0
	jal	convert_dec_to_hex	# convert i => hexadecimal
	la $a0, result			# load result to parameter
	jal print_result		# print hexadecimal
	
Exit:
	la $v0, 10 			# exit program
	syscall	



print_result:				# function to print a0
	li $v0, 4
	syscall
	jr $ra

printResult:				# function to print theResult
	li $v0, 1
	lw $a0, theResult
	syscall
	jr $ra

findSquare:				# function calculate square of i
	mult $a0, $a0
	mflo $v0
	jr $ra

convert_dec_to_hex:			# function convert decimal to hexadecimal and save to result
	move $t2, $v0			# assign value of parameter v0 to t2
	
	li $t0, 8			# init t0 with value 8
	la $t3, result			# load result to t3
	
	Loop:
		beqz	$t0, end_func	# if t0 == 0 jump to end of function
		rol 	$t2, $t2, 4	# rotate left t2 by 4 bit
		and	$t4, $t2, 0xf	# assign t4 = value of mask t2 with 0xf
		ble 	$t4, 9, Sum	# if t4 = 9 jump to sum
		addi 	$t4, $t4, 55	# else t4 = t4 + 55
	
		b 	End		# end of loop
	
	Sum:
		addi $t4, $t4, 48	# t4 become (1 -> 9)
		
	End: 
		sb $t4, 0($t3)		# save value t4 to t3
		addi $t3, $t3, 1	
		addi $t0, $t0, -1	
	j Loop
	
	end_func:
		jr	$ra		# return
	
	
.globl findPower2			# recursive function calculate power i of 2
findPower2:
	subu $sp, $sp, 8		# init stack pointer with 8 bits
	sw $ra, ($sp)			# save return address to first 4 bits
	sw $s0, 4($sp)			# save value of s0 to next 4 bits
	li $s1, 2			# init s1 = 2
	
	# base case
	beq $a0, 0, caseOne		# if a0 == 0 then jump to case one
	caseOne: 			# return v0 = 1
		li $v0, 1
		beq $a0, 0, powerDone
	
	beq $a0, 1, caseTwo		# if a0 = 1 then jump to case two
	caseTwo:			# return v0 = 2
		li $v0, 2
	
	move $s0, $a0			# move value of a0 to s0
	sub $a0, $a0, 1			# a0 = a0 - 1
	jal findPower2			# recursive call 
	
	mul $v0, $s1, $v0		# v0 = s1 * v0
	
	powerDone:			# done recursive
		lw $ra, ($sp)		# recover return address
		lw $s0, 4($sp)		# recover s0
		addu $sp, $sp, 8	# recover stack pointer
		jr $ra			# return


	
		

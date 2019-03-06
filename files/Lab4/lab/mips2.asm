# Exercise 4, Assignment 2
.text
	li $s0, 0x0563			# Load test value for these function
	andi $t0, $s0, 0xff000000	# Extract the MSB of $s0
	andi $s0, $s0, 0xffffff00	# Clear LSB of $s0
	ori $s0, $s0, 0x00000010	# Set LSB of $s0
	andi $s0, $s0, 0		# Clear $s0
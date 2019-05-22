.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014

.text
main:	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	li $t3, 0x01				# row 1
	li $t4, 0x02				# row 2
	li $t5, 0x04				# row 3
	li $t6, 0x08				# row 4
	
polling:
	sb $t3, 0($t1)				
	lb $a0, 0($t2)
	bne $a0, $zero, print			
	
	sb $t4, 0($t1)				
	lb $a0, 0($t2)
	bne $a0, $zero, print			
	
	sb $t5, 0($t1)				
	lb $a0, 0($t2)
	bne $a0, $zero, print		
	
	sb $t6, 0($t1)				
	lb $a0, 0($t2)
	bne $a0, $zero, print
	
	j sleep
	
print:	li $v0, 34				# print integer (hexa)
	syscall
sleep:	li $a0, 100				# sleep 100ms
	li $v0, 32
	syscall
back_to_polling: 
	j polling				# continue polling
	

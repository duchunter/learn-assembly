.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014

.text
main:	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	li $t3, 0x08				#check row 4 with key C, D,E, F
	
polling:
	sb $t3, 0($t1)				# must reassign expected row
	lb $a0, 0($t2)				# read scan code of key button
print:	li $v0, 34				# print integer (hexa)
	syscall
sleep:	li $a0, 100				# sleep 100ms
	li $v0, 32
	syscall
back_to_polling: 
	j polling				# continue polling
	

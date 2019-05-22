.eqv	HEADING	0xffff8010 	# Integer: An angle between 0 and 359
				# 0 : North (up)
				# 90: East (right)
				# 180: South (down)
				# 270: West (left)
.eqv	MOVING	0xffff8050 	# Boolean: whether or not to move
.eqv	LEAVETRACK 0xffff8020 	# Boolean (0 or non-0):
				# whether or not to leave a track
.eqv 	WHEREX 0xffff8030 	# Integer: Current x-location of MarsBot
.eqv 	WHEREY 0xffff8040 	# Integer: Current y-location of MarsBot
.text
main:	jal TRACK # draw track line
	nop
	addi $a0, $zero, 90 # Marsbot rotates 90* and start running
	jal ROTATE
	nop
	jal GO
	nop
sleep1: addi $v0, $zero, 32 # Keep running by sleeping in 6000 ms
	li $a0, 6000
	syscall

	jal UNTRACK # keep old track
	nop
	jal TRACK # and draw new track line
	nop
goDOWN: addi $a0, $zero, 210 # Marsbot rotates 230*
	jal ROTATE
	nop

sleep2: addi $v0,$zero,32 # Keep running by sleeping in 3000 ms
	li $a0,3000
	syscall
	jal UNTRACK # keep old track
	nop
	jal TRACK # and draw new track line
	nop
goLEFT: addi $a0, $zero, 330 # Marsbot rotates 300*
	jal ROTATE
	nop

sleep3: addi $v0,$zero,32 # Keep running by sleeping in 3000 ms
	li $a0,3000
	syscall
	jal UNTRACK
	nop
	jal STOP
	nop
	j end
	
end_main:

#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO:	li $at, MOVING # change MOVING port
	addi $k0, $zero, 1 # to logic 1,
	sb $k0, 0($at) # to start running
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP:	li $at, MOVING # change MOVING port to 0
	sb $zero, 0($at) # to stop
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK:	li $at, LEAVETRACK # change LEAVETRACK port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start tracking
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
	sb $zero, 0($at) # to stop drawing tail
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	li $at, HEADING # change HEADING port
	sw $a0, 0($at) # to rotate robot
	nop
	jr $ra
	nop

end:
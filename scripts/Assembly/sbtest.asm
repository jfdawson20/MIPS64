

.text

main:
	addi $7, $0,11111       #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	add $10, $7,$7      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
	sb  $10, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0

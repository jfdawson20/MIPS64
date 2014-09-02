

.text

main:
	addi $7, $0,12       #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	lh $11,0($7)
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
	add $10, $0,$11      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
	sw   $11, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
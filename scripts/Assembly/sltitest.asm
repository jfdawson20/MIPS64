

.text

main:
	addi $7, $0,-12       #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	addi $11, $0,2      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	
	slti $11,$7,30   #       GPR[11]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
	sw   $11, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
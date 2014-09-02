

.text

main:
	addi $7, $0,-1      #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	bgtz $7,jumphere
	
	addi $7, $7,2      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
jumphere: 
	sw  $7, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
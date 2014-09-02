

.text

main:
	addi $7, $0,1      #       GPR[ 7 ]? 
	bltz $7,jumphere
	add $7, $7,$7      #       GPR[11]? -3
	
jumphere: 
	sw  $7, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0

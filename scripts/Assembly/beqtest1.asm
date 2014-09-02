

.text

main:
	addi $7, $0,32      #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	beq $7,$0,jumphere
	
	add $7, $7,$7      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
jumphere: 
	sw  $7, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
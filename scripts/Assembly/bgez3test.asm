

.text

main:
	addi $7, $0,0      #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	addi $8, $0, 1
	sll $0,$0,0
	sll $0,$0,0
	
	bgez $7,jumphere
	
	add $8, $8,$8      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
jumphere: 
	sw  $8, 0($8)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0



.text

main:
	addi $7, $0, 200       #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	addi $11, $0, 100      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	
	andi  $11, $7,200    #       GPR[11]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
	sw   $11, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
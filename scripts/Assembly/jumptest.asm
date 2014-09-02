

.text

main:
	addi $7, $0,8       #       GPR[ 7 ]? 
	sll $0,$0,0
	sll $0,$0,0
	
	j jumphere
	
	add $7, $7,$7      #       GPR[11]? -3
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	
jumphere: 
	sh  $7, 0($7)       #       memory[17]? 20
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
	sll $0,$0,0
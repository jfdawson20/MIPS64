

.text

main:
	 addi $7, $0, 17       #       GPR[ 7 ]? 17
       	 addi $11, $0, -3      #       GPR[11]? -3
         sub  $11, $7, $11   #       GPR[11]? 20
         sw   $11, 0($7)
         sll $0,$0,0
         sll $0,$0,0
         sll $0,$0,0
	 sll $0,$0,0
     
.data 
	max_input: .space 1000
	error: .asciiz "\nInvalid Hexadecimal number"
	newline: .asciiz "\n"
	message: .asciiz "\nDone"
.text
	main: 
		li $v0, 8  
    	la $a0, max_input
    	li $a1, 9
    	syscall

    	add $t0, $zero, 0
    	la $s0, max_input

    	iterate: 
    		add $s1, $s0, $t0
    		lb $a1, 0($s1)

    		beq $a1, $zero, done 
    		
    		jal subprogram1

    		li $v0, 1 
    		addi $a0, $v1, 0
    		syscall 

    		la $a0, newline
			li $v0, 4
			syscall
    		j iterate

    	subprogram1:
    		sub $v1, $a1, 48 
			blt $v1, 0, exit
			blt $v1, 10, store
				store: 
					jr $ra
			sub $v1, $v1, 7
			blt $v1, 10, exit
			blt $v1, 16, store1
				store1: 
					jr $ra
			sub $v1, $v1, 32
			blt $v1, 10, exit
			blt $v1, 16, store2
				store2: 
					jr $ra
			bgt $v1, 15, exit

		exit: 
			la $a0, error
	        addi $v0, $zero, 4
	        syscall 

	    done: 

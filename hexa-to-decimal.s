.data 
    max_input: .space 10000
    not_valid: .asciiz "NaN"
    too_large: .asciiz "too large"
.text
    main: 
            li $v0, 8
            la $a0, max_input 
            li $a1, 1001
            syscall 

            la $s0, max_input 
            li $s1, 0
            li $s2, 0

        word_list: 
            la $s1, ($s2)

        substring: 
            add $t1, $s0, $s2
            lb $t2, 0($t1)

            beq $t2, 0, end_substring
            beq $t2, 10, end_substring
            beq $t2, 44, end_substring

            add $s2, $s2, 1
            j substring
        end_substring:
            la $a0, ($s1)
            la $a1, ($s2)
            jal subprogram_2
            jal subprogram_3

            beq $t2, 0, end_wl 
            beq $t2, 10, end_wl
            addi $s2, $s2, 1

            li $v0, 11
            li $a0, 44
            syscall 
            j word_list 
        end_wl: 
            li $v0, 10 
            syscall 


        subprogram_2:
            la $s7, ($ra)
            la $t9, ($a0)

            addi $t8, $a1, 0 
            la $t7, max_input 

            clear_front: 
                beq $t9, $t8, end_deletion 
                add $t6, $t7, $t9
                lb $t5, ($t6)

                beq $t5, 32, addup 
                beq $t5, 9, addup
                j clear_back
            addup: 
                addi $t9, $t9, 1 
                j clear_front

            clear_back: 
                beq $t9, $t8, end_deletion
                add $t6, $t7, $t8 
                addi $t6, $t6, -1 
                lb $t5, ($t6)
                beq $t5, 32, adddown 
                beq $t5, 9, adddown 
                j end_deletion
            adddown: 
                addi $t8, $t8, -1 
                j clear_back

            end_deletion: 
                beq $t9, $t8, not_a_number 
                li $t4, 0 
                li $s6, 0 

            convert: 
                beq $t9, $t8, end_convert 
                add $t6, $t7, $t9 
                lb $t5, ($t6)
                la $a0, ($t5)
                jal sub_program1 
                bne $v0, 0, continue 
                j not_a_number 
            continue: 
                sll $t4, $t4, 4 
                sub $t6, $t5, $v1 
                add $t4, $t4, $t6
                addi $s6, $s6, 1 
                addi $t9, $t9, 1
                j convert
            end_convert:
                bgt $s6, 8, large_num
                li $v0, 1 
                j end_string
            large_num:
                li $v0, 0 
                la $t4, too_large
                j end_string
            not_a_number: 
                li $v0, 0 
                la $t4, not_valid
            end_string: 
                addi $sp, $sp, -4 
                sw $t4, ($sp)
                addi $sp, $sp, -4 
                sw $v0, ($sp)
                la $ra, ($s7)
                jr $ra
   		sub_program1: 
   				blt $a0, 48, invalid
   				addi $v1, $0, 48 
   				blt $a0, 58, valid

   				blt $a0, 65, invalid 
   				addi $v1, $0, 55
   				blt $a0, 71, valid 
   				blt $a0, 97, invalid 
   				addi $v1, $0, 87 
   				blt $a0, 103, valid 
   				bgt $a0, 102, invalid 

   			valid: 
   				li $v0, 1
   				jr $ra 
   			invalid: 
   				li $v0, 0 
   				jr $ra 

   		subprogram_3:
	   		lw $t8, ($sp)
	   		addi $sp, $sp, 4
	   		lw $t7, ($sp)
	   		beq $t8, 0, okay

   			li $t6, 10 
   			divu $t7, $t6
   			li $v0, 1 
   			mflo $a0
   			beq $a0, 0, foo
   			syscall 
   		foo: 
   			mfhi $a0 
   			syscall 
   			j exit
   		okay: 
   			li $v0, 4 
   			la $a0, ($t7)
   			syscall 
   		exit: 
   			jr $ra 

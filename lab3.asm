.data

input_qtd: .asciiz "Entre com a quantidade de numeros do vetor: \n"

number_1: .asciiz "Entre com o numero "

number_2: .asciiz " do vetor: \n"

vector_read_: .asciiz "Vetor lido:"

vector_normalized_: .asciiz "\nVetor normalizado:"

space: .asciiz " "



vet:.align 2 

    .space 400



.text

.globl main

main:
    li.s $f3, 10000.0 #menor
    li.s $f2, -10000.0 #maior
    
    
    move $t0, $zero #indice 

    move $t1, $zero #valor a ser adicionado

    move $t3, $zero #aux

    li $t2, 400 #tamanho



    jal read_positive_integer1

    move $t2, $v0 #tamanho atual do array

    mul $t2, $t2, 4

    

    jal loop

    

    move $t0, $zero

    

    la $a0, vector_read_

    jal print_sring

    

    jal loopimprime

    

    move $t0, $zero

    jal procurar1
    
    move $t0, $zero

    jal procurar2

    move $t0, $zero


    jal normalizar

    

    move $t0, $zero

    
    la $a0, vector_normalized_

    jal print_sring

    jal loopimprime



    li $v0, 10	# end

	syscall





loop:

 	beq $t0, $t2, saida



 	la $a0, number_1

    li $v0, 4	# code to print string

	syscall

	

	li $v0, 1

    move $a0, $t3

    syscall

	

	la $a0, number_2

    li $v0, 4	# code to print string

	syscall

 	

 	li $v0, 6

 	syscall
 	mov.s $f1, $f0


    

    s.s $f1, vet($t0)

 	addi $t0, $t0, 4

 	addi $t3, $t3, 1
	

	j loop

	

saida:

    jr $ra



loopimprime:

     beq $t0, $t2, saida

        

        li $v0, 4

        la $a0, space

        syscall

        

        li $v0, 2

        l.s $f12, vet($t0)

        syscall

        

        

        addi $t0, $t0, 4

     j loopimprime



procurar1:

    #achar o menor e o maior

    beq $t0, $t2, saida


    l.s $f4, vet($t0)


    c.lt.s $f4, $f3

    bc1t atualiza1
    
    
    

    addi $t0, $t0, 4

    j procurar1



atualiza1:

    mov.s $f3, $f4
    j procurar1
    
    
procurar2:

    #achar o menor e o maior

    beq $t0, $t2, saida


    l.s $f5, vet($t0)


    c.lt.s $f2, $f5

    bc1t atualiza2
    

    addi $t0, $t0, 4

    j procurar2



atualiza2:

    mov.s $f2, $f5
    j procurar2


normalizar: 
    beq $t0, $t2, saida
    l.s $f6, vet($t0)
    
    #valor - menor(a) / maior - menor (b)
    sub.s $f7, $f6, $f3 #(a)
    sub.s $f8, $f2, $f3 #(b)
    
    div.s $f9, $f7, $f8 #a/b
    
    s.s $f9, vet($t0)

 	addi $t0, $t0, 4

    j normalizar



print_sring: # Parameters: $a0 - address of the string to be printed.



 	li $v0, 4	# code to print string

	syscall

	jr $ra



read_integer: # Return: $v0 - an integer.

    li $v0, 5	# code to read integer

    syscall

    jr $ra



read_positive_integer1: # Return: $v0 - a positive integer.

    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)

    

read_number1:



    la $a0, input_qtd

    jal print_sring

    jal read_integer

    jal return_integer

    

return_integer:

	

    lw $ra, 0($sp)

    addi $sp, $sp, 4 # loading return address

    

    jr $ra






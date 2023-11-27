.data

input_opcoes: .asciiz "Escolha uma opcao:\n1 - Criar item\n2 - Comprar estoque\n3 - Vender estoque\n4 - Sair\n"

ID_1: .asciiz "Digite o ID do item novo: "
erro_1: .asciiz "ID ja esta em uso."

ID_2: .asciiz "Digite o ID do item a ser comprado: "
qtd_2: .asciiz "\nDigite a quantidade do item a ser comprado: "
erro_2: .asciiz "\nID de item invalido.\n\n"

ID_3: .asciiz "Digite o ID do item a ser vendido: "
qtd_3: .asciiz "\nDigite a quantidade do item a ser vendido: "
erro_3: .asciiz "\nId de item invalido.\n\n"
erro_4: .asciiz "\nEstoque insuficiente.\n\n"

estoque: .asciiz "\nEstoque: "
final: .asciiz "\nItem "
twopoint: .asciiz ": "
space: .asciiz "\n\n"


vet:.align 2 
    .space 1000

ides:.align 2 
    .space 1000
 
.text
.globl variavel


variavel:
    li $t9, 1000
    li $t8, 0 # posicao do vetor de ids

main:
    
    jal read_positive_integer1
    move $t0, $v0 #tamanho atual do array

    beq $t0, 1, criar_item
    beq $t0, 2, comprar_estoque
    beq $t0, 3, vender_estoque
    beq $t0, 4, sair
    j main
    
   
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
    la $a0, input_opcoes
    jal print_sring
    jal read_integer
    jal return_integer
   
return_integer:
    lw $ra, 0($sp)
    addi $sp, $sp, 4 
    jr $ra


criar_item:
    li $t5, 0
   
    li $v0, 4
    la $a0, ID_1
    syscall

    li $v0, 5  # ler o id        
    syscall
    
    move $t1, $v0
    # Verificar se o ID ja existe
    jal verificar_id
    sw $t1, ides($t8)
    mul $t1, $t1, 4

    addi $t8, $t8, 4
    
    # Criar item
    sw $zero, vet($t1)        # Inicializar estoque com 0

    j imprimir_estoque2 


verificar_id:
    #blt $t1, 0, id_erro     # ID negativo invalido
    #bge $t1, 1000, id_erro  # ID maior que 999 invalido
    beq $t5, $t8, saida	
    
    lw $t2, ides($t5)
    beq $t1, $t2, id_erro
    addi $t5, $t5, 4

    j verificar_id

saida:
   jr $ra

id_erro:
    li $v0, 4
    la $a0, erro_1
    syscall
    j main


comprar_estoque:
    li $t5, 0
    li $v0, 4
    la $a0, ID_2
    syscall

    li $v0, 5                  # Ler inteiro (ID do item)
    syscall
    move $t7, $v0

    # Verificar se o ID existe
    jal verificar_id2

    # Ler quantidade
    li $v0, 4
    la $a0, qtd_2
    syscall

    li $v0, 5                  # Ler inteiro (quantidade)
    syscall
    move $t6, $v0

    mul $t7, $t7, 4
    # Comprar estoque
    lw $t3, vet($t7)         # Carregar estoque atual
    add $t3, $t3, $t6          # Adicionar quantidade comprada
    sw $t3, vet($t7)         # Atualizar estoque

    j imprimir_estoque2

verificar_id2:
    beq $t5, $t8, continua	
    lw $t4, ides($t5)
    beq $t7, $t4, saida2
    addi $t5, $t5, 4
    
    j verificar_id2

continua:

    li $v0, 4
    la $a0, erro_2
    syscall
    j main 

saida2:
   jr $ra
   
   
vender_estoque:
    li $t5, 0
    li $v0, 4
    la $a0, ID_3
    syscall

    li $v0, 5                  # Ler inteiro (ID do item)
    syscall
    move $t1, $v0

    # Verificar se o ID existe
    jal verificar_id3

    # Ler quantidade
    li $v0, 4
    la $a0, qtd_3
    syscall

    li $v0, 5                  # Ler inteiro (quantidade)
    syscall
    move $t2, $v0

    mul $t1, $t1, 4
    # Verificar estoque suficiente
    lw $t3, vet($t1)         # Carregar estoque atual
    blt $t3, $t2, muito

    # Vender estoque
    sub $t3, $t3, $t2          # Subtrair quantidade vendida
    sw $t3, vet($t1)         # Atualizar estoque

    j imprimir_estoque2


muito:
    li $v0, 4
    la $a0, erro_4
    syscall
    j main

verificar_id3:
    beq $t5, $t8, continua3	
    lw $t4, ides($t5)
    beq $t1, $t4, saida3
    addi $t5, $t5, 4
    
    j verificar_id3

continua3:
    li $v0, 4
    la $a0, erro_3
    syscall
    j main 

saida3:
   jr $ra



imprimir_estoque2:
    li $t5, 0
    li $t9, 1000
    li $t7, -1
    li $v0, 4
    la $a0, estoque
    syscall
    
    
    j print_items_loop2

print_items_loop2:
    beq $t5, $t9, bora2
    li $t6, 0
    addi $t7, $t7, 1
    
    j busca

soma2:
    addi $t5, $t5, 4
    j print_items_loop2
    
bora2:
    li $v0, 4
    la $a0, space
    syscall
    j main

busca:
    beq $t6, $t8, soma2
    
   
    
    lw $t3, ides($t6)
    
    
    
    
    
    addi $t6, $t6, 4
    
    beq $t7, $t3, eissoai
    
    j busca
    
    

eissoai:

    mul $t2, $t3, 4
    
    lw $t4, vet($t2)
    #beqz $t4, proximo2
    
    li $v0, 4
    la $a0, final
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, twopoint
    syscall
    
    li $v0, 1
    move $a0, $t4              # Imprimir quantidade
    syscall
    
    addi $t5, $t5, 4
    
    j print_items_loop2

sair:
    li $v0, 10	# end
    syscall







.data

	str1: .asciiz "Entre com a altura do paralelepipedo: \n"
	str2: .asciiz "Entre com a largura do paralelepipedo: \n"
	str3: .asciiz "Entre com a espessura do paralelepipedo: \n"
	str4: .asciiz "Medida invalida.\n"
	str5: .asciiz "Volume do paralelepipedo: "

.text
.globl main

main:
    jal read_positive_integer1
    move $s0, $v0

    jal read_positive_integer2
    move $s1, $v0

    jal read_positive_integer3
    move $s2, $v0

    mul $s3, $s0, $s1
    mul $s3, $s3, $s2

    la $a0, str5
    jal print_sring

	li $v0, 1	# code to print integer
	move $a0, $s3	# the value to be printed in $a0
	syscall

	li $v0, 10	# end
	syscall

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

    la $a0, str1
    jal print_sring
    
    jal read_integer
    
    bge $v0, $0, return_integer
	
    la $a0, str4
    jal print_sring
    
    j read_number1
    
read_positive_integer2: # Return: $v0 - a positive integer.
    addi $sp, $sp, -4 # saving return address
    sw $ra, 0($sp)

read_number2:

    la $a0, str2
    jal print_sring
    
    jal read_integer
    
    bge $v0, $0, return_integer
	
    la $a0, str4
    jal print_sring
    
    j read_number2
    
read_positive_integer3: # Return: $v0 - a positive integer.
    addi $sp, $sp, -4 # saving return address
    sw $ra, 0($sp)
    
read_number3:

    la $a0, str3
    jal print_sring
    
    jal read_integer
    
    bge $v0, $0, return_integer
	
    la $a0, str4
    jal print_sring
    
    j read_number3
	
return_integer:
	
    lw $ra, 0($sp)
    addi $sp, $sp, 4 # loading return address
    
    jr $ra
    
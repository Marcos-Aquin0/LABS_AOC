.data



str_x: .asciiz "Entre com a coordenada x do ponto P: \n"

str_y: .asciiz "Entre com a coordenada y do ponto P: \n"

str_A: .asciiz "Entre com o brilho do pixel A: \n"

str_B: .asciiz "Entre com o brilho do pixel B: \n"

str_C: .asciiz "Entre com o brilho do pixel C: \n"

str_D: .asciiz "Entre com o brilho do pixel D: \n"



str4: .asciiz "Coordenada invalida.\n"

str5: .asciiz "Brilho invalido.\n"

str_luz: .asciiz "Valor do brilho do ponto P: "



one_float: .float 1.0

twoh_float: .float 255.0



.text

.globl main



main:



    jal read_positive_float1

    mov.s $f1, $f0



    jal read_positive_float2

    mov.s $f3, $f0



    jal read_positive_float3

    mov.s $f4, $f0



    jal read_positive_float4

    mov.s $f5, $f0



    jal read_positive_float5

    mov.s $f6, $f0



    jal read_positive_float6

    mov.s $f7, $f0



    l.s $f31, one_float

    

    sub.s $f8, $f31, $f1

    sub.s $f9, $f31, $f3

    

#(1.0-x)*(1.0-y)*bA     

    mul.s $f10, $f8, $f9

    mul.s $f11, $f10, $f4



#+(1.0-x)*y*bB

    mul.s $f12, $f8, $f3

    mul.s $f13, $f12, $f5



#+x*(1.0-y)*bC

    mul.s $f14, $f1, $f9

    mul.s $f15, $f14, $f6



#+x*y*bD)

    mul.s $f16, $f1, $f3

    mul.s $f17, $f16, $f7

    

    add.s $f18, $f11, $f13

    add.s $f19, $f18, $f15

    add.s $f20, $f19, $f17

    

    round.w.s $f20, $f20
  

    la $a0, str_luz

    jal print_sring

    

    li $v0, 1

    mfc1 $a0, $f20

    syscall



	li $v0, 10	# end

	syscall





print_sring: # Parameters: $a0 - address of the string to be printed.



 	li $v0, 4	# code to print string

	syscall

	jr $ra





read_float: # Return a positive float.



    li $v0, 6	# code to read float

    syscall

    jr $ra







read_positive_float1: # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number1:



    la $a0, str_x

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number1

    

    l.s $f2, one_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str4

    jal print_sring

    j read_number1

    



read_positive_float2: # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number2:



    la $a0, str_y

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number2

    

    l.s $f2, one_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str4

    jal print_sring

    j read_number2

    

    

read_positive_float3:  # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number3:



    la $a0, str_A

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number3

    

    l.s $f2, twoh_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str5

    jal print_sring

    j read_number3

    

    

read_positive_float4:  # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number4:



    la $a0, str_B

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number4

    

    l.s $f2, twoh_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str5

    jal print_sring

    j read_number4

    



read_positive_float5: # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number5:



    la $a0, str_C

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number5

    

    l.s $f2, twoh_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str5

    jal print_sring

    j read_number5

    

    

read_positive_float6: # Return a positive float.



    addi $sp, $sp, -4 # saving return address

    sw $ra, 0($sp)





read_number6:



    la $a0, str_D

    jal print_sring

    jal read_float

    li.s $f2, 0.0



    #bge $v0, $0, return_float

    c.lt.s $f0, $f2

    bc1t invalid_number6

    

    l.s $f2, twoh_float

    c.le.s $f0, $f2

    bc1t return_float

   

    la $a0, str5

    jal print_sring

    j read_number6





return_float:

    lw $ra, 0($sp)

    addi $sp, $sp, 4 # loading return address



    jr $ra

    

invalid_number1:

    la $a0, str4

    jal print_sring

    j read_number1

    

invalid_number2:

    la $a0, str4

    jal print_sring

    j read_number2

    

invalid_number3:

    la $a0, str5

    jal print_sring

    j read_number3

    

invalid_number4:

    la $a0, str5

    jal print_sring

    j read_number4

    

invalid_number5:

    la $a0, str5

    jal print_sring

    j read_number5

    

invalid_number6:

    la $a0, str5

    jal print_sring

    j read_number6

    

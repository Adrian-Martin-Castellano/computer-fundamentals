# AUTHOR: Adrián Martín Castellano
# ASSIGNMENT: Practice Nº 2 (Subroutines & Vector Operations)
# STYLE GUIDE: Clean MIPS Assembly

size = 4     
maxdim = 40  
    .data
v1:         .space 160
v2:         .space 160 
n1:         .word 0 # number of elements in vector 1 (initially empty)
n2:         .word 0 # number of elements in vector 2 (initially empty)
space:      .asciiz " "
newline:    .asciiz "\n"
title:      .asciiz "\nComputer Principles - Assignment PR4. Subroutines.\n"
menu:       .ascii  "\n(1) Change vector dimension\n(2) Change an element of a vector\n"
            .ascii  "(3) Invert a vector (Mirror)\n(4) Calculate dot product of two vectors\n"
            .asciiz "(0) Exit\n\nChoose option: "
cabvec:     .asciiz "\nVector with dimension "
error_op:   .asciiz "\nError: Invalid option.\n"
choose_vec: .asciiz "\nChoose vector for operation (1) for v1, (2) for v2: "
choose_ind: .asciiz "\nChoose element index to modify: "
newval:     .asciiz "\nEnter new value for the chosen element: "
newdim:     .asciiz "\nEnter new dimension for the vector (1-40): "
error_dim:  .asciiz "\nError: Invalid dimension.\n"
error_ind:  .asciiz "\nError: Invalid index.\n"
error_d_dim:.asciiz "\nError: Vectors must have matching dimensions.\n"
msg_dotpr:  .asciiz "\nThe dot product of the vectors is: "
msg_fin:    .asciiz "\nPROGRAM FINISHED.\n"

    .text
# --- SUBROUTINE: print_vec ---
print_vec:
    addi $sp, $sp, -24                    
    sw $ra, 20($sp)                       
    s.s $f21, 16($sp)                     
    sw $s4, 12($sp)                       
    sw $s3, 8($sp)                        
    sw $s2, 4($sp)                        
    sw $s1, 0($sp)                        

    move $s0, $a0                         # $s0 = base address
    move $s1, $a1                         # $s1 = dimension
    move $s2, $a2                         # $s2 = separator string
    move $s3, $zero                       # index tracker = 0

for_print_vec:
    mul $s4, $s3, 4                     
    add $s4, $s4, $s0                   
    l.s $f12, 0($s4)                    

    li $v0, 2
    syscall                             
    li $v0, 4
    move $a0, $s2                       
    syscall
    addi $s3, $s3, 1                    
    blt $s3, $s1, for_print_vec         

bucle_print_v_end:
    lw $s1, 0($sp)
    lw $s2, 4($sp)
    lw $s3, 8($sp)
    lw $s4, 12($sp)
    l.s $f21, 16($sp)
    lw $ra, 20($sp)
    addi $sp, $sp, 24
    jr $ra                              

# --- Subrutine: change_elto ---
change_elto:
    # $a0 = vector address, $a1 = index (0-based tracking), $f0 = new value
    mul $t3, $a1, size                  
    add $t3, $t3, $a0                   
    s.s $f0, 0($t3)                    
    jr $ra                              

# --- Subrutine: swap ---
swap:
    mul $t4, $a1, size                    
    add $t4, $t4, $a0                     
    l.s $f10, 0($t4)                     # aux = v[i]

    mul $t6, $a2, size                    
    add $t6, $t6, $a0                     
    l.s $f4, 0($t6)                      # target = v[j]

    s.s $f4, 0($t4)                      # v[i] = v[j]
    s.s $f10, 0($t6)                     # v[j] = aux
    jr $ra                              

# --- Subrutine: mirror (Recursive) ---
mirror:
    # Base Case: if (n == 0 || n == 1) return;
    ble $a1, 1, return
    
    addi $sp, $sp, -16                    
    sw $ra, 12($sp)                       
    sw $a0, 8($sp)                        
    sw $a1, 4($sp)                        

    # swap(v, 0, n-1)
    li $a1, 0                             # index i = 0
    lw $t7, 4($sp)                        # recover n
    addi $a2, $t7, -1                     # index j = n - 1
    jal swap                            

    # Recurse: mirror(v + 1, n - 2)
    lw $a0, 8($sp)
    lw $a1, 4($sp)
    addi $a0, $a0, 4                      # v + 1 (advance 4 bytes)
    addi $a1, $a1, -2                     # n - 2
    jal mirror                          

    lw $ra, 12($sp)                       
    addi $sp, $sp, 16
return:
    jr $ra                              

# --- Subrutine: mult_add ---
mult_add:
    mul.s $f4, $f12, $f13                           
    add.s $f0, $f14, $f4                           
    jr $ra                                          

# --- Subrutine: prod_esc (Dot Product) ---
prod_esc: 
    li.s $f4, 0.0                                 # result accumulator = 0.0
    beq $a2, $zero, end_prod_esc                   

    move $t9, $zero                               # index i = 0
bucle_prod_esc:
    addi $sp, $sp, -20                               
    sw $ra, 16($sp)                               
    sw $a0, 12($sp)                               
    sw $a1, 8($sp)                                 
    sw $a2, 4($sp)                                 
    sw $t9, 0($sp)                                

    l.s $f12, 0($a0)                              
    l.s $f13, 0($a1)                              
    mov.s $f14, $f4                               

    jal mult_add                                  
    mov.s $f4, $f0                                # Update local accumulator safely

    lw $t9, 0($sp)                                
    lw $a2, 4($sp)
    lw $a1, 8($sp) 
    lw $a0, 12($sp) 
    lw $ra, 16($sp) 
    addi $sp, $sp, 20 

    addi $a0, $a0, 4                             
    addi $a1, $a1, 4                             
    addi $t9, $t9, 1                             
    blt $t9, $a2, bucle_prod_esc                 

end_prod_esc:
    mov.s $f0, $f4                               
    jr $ra                                       

# --- Main block ---
main:
    li $v0, 4
    la $a0, title                        
    syscall

    la $s2, v1                          
    la $s3, v2                          
    lw $s0, n1                          
    lw $s1, n2                          

    move $t0, $zero                   
generador_vector1:
    mul $t3, $t0, size                  
    add $t3, $t3, $s2                   
    li $t4, 10                          
    add $t4, $t4, $t0                   
    mtc1 $t4, $f4                       
    cvt.s.w $f4, $f4                    
    s.s $f4, 0($t3)                     
    
    addi $s0, $s0, 1                         
    addi $t0, $t0, 1                         
    blt $t0, maxdim, generador_vector1   
    sw $s0, n1                          

    move $t0, $zero                     
generador_vector2:
    mul $t3, $t0, size                  
    add $t3, $t3, $s3                   
    li $t4, 40                          
    sub $t4, $t4, $t0                   
    mtc1 $t4, $f4                       
    cvt.s.w $f4, $f4                    
    s.s $f4, 0($t3)                     
    
    addi $s1, $s1, 1                         
    addi $t0, $t0, 1                         
    blt $t0, maxdim, generador_vector2    
    sw $s1, n2                          

do_while:
    li $v0, 4
    la $a0, cabvec                    
    syscall
    li $v0, 1
    move $a0, $s0                    
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    la $a0, v1                          
    lw $a1, n1                          
    la $a2, space                       
    jal print_vec                       

    li $v0, 4
    la $a0, cabvec                    
    syscall
    li $v0, 1
    move $a0, $s1                    
    syscall
    li $v0, 4
    la $a0, newline                   
    syscall

    la $a0, v2                          
    lw $a1, n2                          
    la $a2, space                       
    jal print_vec                       

menu_: 
    li $v0, 4                           
    la $a0, menu                        
    syscall                             

    li $v0, 5
    syscall                             
    move $t0, $v0

    beq $t0, $zero, opcion_0              
    beq $t0, 1, opcion_1                  
    beq $t0, 2, opcion_2                  
    beq $t0, 3, opcion_3                  
    beq $t0, 4, opcion_4                  

    blt $t0, $zero, fallo_opcion          
    bgt $t0, 4, fallo_opcion              

opcion_0:
    j end                               

opcion_1:
    li $v0, 4
    la $a0, choose_vec                        
    syscall

    li $v0, 5
    syscall                                 
    move $t1, $v0

    blt $t1, 1, fallo_opcion_vector           
    bgt $t1, 2, fallo_opcion_vector           
    j continuar_opcion_1                    

fallo_opcion_vector:
    li $v0, 4
    la $a0, error_op                       
    syscall
    j do_while                              

continuar_opcion_1:
    li $v0, 4
    la $a0, newdim                       
    syscall

    li $v0, 5
    syscall                                 
    move $t2, $v0

    blt $t2, 1, fallo_dimension               
    bgt $t2, 40, fallo_dimension              
    j continuar2_opcion1                    

fallo_dimension:
    li $v0, 4
    la $a0, error_dim                       
    syscall
    j do_while                              

continuar2_opcion1:
    beq $t1, 1, cambio_dim_v1                 
    beq $t1, 2, cambio_dim_v2                 

cambio_dim_v1:
    sw $t2, n1                          
    move $s0, $t2                        
    j do_while                          

cambio_dim_v2:
    sw $t2, n2                           
    move $s1, $t2                         
    j do_while                          

opcion_2:
    li $v0, 4
    la $a0, choose_vec                        
    syscall

    li $v0, 5
    syscall                                 
    move $t1, $v0

    blt $t1, 1, fallo_opcion_vector           
    bgt $t1, 2, fallo_opcion_vector           
    j continuar_opcion_2                    

continuar_opcion_2:
    li $v0, 4
    la $a0, choose_ind                        
    syscall

    li $v0, 5
    syscall                                 
    move $t3, $v0

    beq $t1, 1, continuar_elec1               
    j continuar_elec2                       

continuar_elec1:
    blt $t3, $zero, fallo_indice            
    bge $t3, $s0, fallo_indice              

    li $v0, 4
    la $a0, newval                        
    syscall 

    li $v0, 6
    syscall                             
    mov.s $f5, $f0

    la $a0, v1                          
    move $a1, $t3                        
    mov.s $f0, $f5                       

    jal change_elto                     
    j do_while                          

continuar_elec2:
    blt $t3, $zero, fallo_indice        
    bge $t3, $s1, fallo_indice          

    li $v0, 4
    la $a0, newval                       
    syscall 

    li $v0, 6
    syscall                             
    mov.s $f5, $f0

    la $a0, v2                          
    move $a1, $t3                        
    mov.s $f0, $f5                       

    jal change_elto                     
    j do_while                          

fallo_indice:
    li $v0, 4
    la $a0, error_ind                        
    syscall 
    j do_while

opcion_3:
    li $v0, 4
    la $a0, choose_vec                        
    syscall

    li $v0, 5
    syscall                                 
    move $t1, $v0

    blt $t1, 1, fallo_opcion_vector           
    bgt $t1, 2, fallo_opcion_vector           
    j continuar_opcion_3                    

continuar_opcion_3:
    beq $t1, 1, opcion3_elec1                 
    beq $t1, 2, opcion3_elec2                 

opcion3_elec1:
    la $a0, v1                              
    lw $a1, n1                              
    jal mirror                              
    j do_while

opcion3_elec2:
    la $a0, v2                              
    lw $a1, n2                              
    jal mirror                              
    j do_while                          

opcion_4:
    beq $s0, $s1, continuar_opcion4           

    li $v0, 4
    la $a0, error_d_dim                     
    syscall   
    j do_while                              

continuar_opcion4:
    la $a0, v1                               
    la $a1, v2                               
    lw $a2, n1                               

    jal prod_esc                            
    mov.s $f12, $f0                          

    li $v0, 4
    la $a0, msg_dotpr                     
    syscall

    li $v0, 2                                
    syscall
    j do_while                              

fallo_opcion:
    li $v0, 4
    la $a0, error_op                     
    syscall
    j do_while                          

end:
    li $v0, 4
    la $a0, msg_fin                     
    syscall

    li $v0, 10
    syscall
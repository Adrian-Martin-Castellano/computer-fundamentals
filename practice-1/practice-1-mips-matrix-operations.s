# AUTHOR: Adrián Martín Castellano 
# ASSIGNMENT: Practice Nº 1 (Matrix Operations)
# STYLE GUIDE: Clean MIPS Assembly

    .data
maxElements:    .word 400 
size:           .word 4   
    
mat:   .word   100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119
       .word   120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
       .word   140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
       .word   160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179
       .word   180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199
       .word   200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219
       .word   220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
       .word   240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259
       .word   260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279
       .word   280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299
       .word   300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319
       .word   320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339
       .word   340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359
       .word   360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379
       .word   380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399
       .word   400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419
       .word   420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439
       .word   440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459
       .word   460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479
       .word   480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499

numRows:    .word   20 
numCols:    .word   20  

title:       .asciiz "\nComputer Principles - Assignment PR3. Matrix Manipulation.\n"
msg_matrix:  .asciiz "\nThe matrix is "
msg_x:       .asciiz "x"
separator:   .asciiz "  "
newline:     .asciiz "\n"
menu:        .ascii  "\n(1) Change dimensions\n(2) Swap two elements\n"
             .ascii  "(3) Sum perimeter elements\n(4) Calculate max and min of main diagonal\n"
             .asciiz "(0) Exit\n\nChoose option: "

error_opt:   .asciiz "\nError: Invalid option.\n"
msg_nrows:   .asciiz "Enter number of rows: "
msg_ncols:   .asciiz "Enter number of columns: "
error_nrows: .asciiz "\nError: Invalid dimension. Incorrect row selection.\n"
error_ncols: .asciiz "\nError: Invalid dimension. Incorrect column selection.\n"
error_dim:   .asciiz "\nError: Invalid dimension. Exceeds max number of elements (400).\n"
msg_i:       .asciiz "Enter row of the first element to swap: "
msg_j:       .asciiz "Enter column of the first element to swap: "
msg_r:       .asciiz "Enter row of the second element to swap: "
msg_s:       .asciiz "Enter column of the second element to swap: "
msg_sum:     .asciiz "\nSum of perimeter elements: "
msg_max:     .asciiz "\nThe maximum value on the main diagonal is "
msg_min:     .asciiz " and the minimum is "
msg_end:     .asciiz "\nProgram finished.\n"

    .text
main:
    # Print initial header title
    li $v0, 4
    la $a0, title
    syscall

while:
    lw $t8, numRows     # $t8 = current rows
    lw $t9, numCols     # $t9 = current columns
    lw $s0, maxElements

    li $v0, 4
    la $a0, msg_matrix
    syscall
    
    li $v0, 1
    move $a0, $t8
    syscall
    
    li $v0, 4
    la $a0, msg_x
    syscall
    
    li $v0, 1
    move $a0, $t9
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall

    # --- Matrix Printing Loop ---
    move $t0, $zero     # r = 0 (row index tracker)
loop_1.1:
    move $t1, $zero     # c = 0 (column index tracker)
loop_1.2:
    # Target Address = mat + (r * numCols + c) * 4
    mul $t4, $t0, $t9   # r * numCols
    addu $t4, $t4, $t1  # (r * numCols) + c
    sll $t4, $t4, 2     # Multiply offset by 4 (bytes per word)
    lw $t5, mat($t4)    

    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, separator
    syscall

    addi $t1, $t1, 1    # c++
    blt $t1, $t9, loop_1.2

    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1    # r++
    blt $t0, $t8, loop_1.1

menu_prompt:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5           # Read user option choice
    syscall
    move $s1, $v0       # $s1 = chosen option

    # Option validation rules
    beq $s1, 0, end
    blt $s1, $zero, failure
    bgt $s1, 4, failure
    
    beq $s1, 1, option_1
    beq $s1, 2, option_2
    beq $s1, 3, option_3
    beq $s1, 4, option_4

failure:
    li $v0, 4
    la $a0, error_opt
    syscall
    b menu_prompt

# -----------------------------
# Option 1: Change dimensions
# -----------------------------
option_1:
    li $v0, 4
    la $a0, msg_nrows
    syscall

    li $v0, 5
    syscall
    move $t6, $v0       # $t6 = new target rows

    ble $t6, $zero, failure_opt1_row
    bgt $t6, $s0, failure_opt1_row

    li $v0, 4
    la $a0, msg_ncols
    syscall

    li $v0, 5
    syscall
    move $t7, $v0       # $t7 = new target columns

    ble $t7, $zero, failure_opt1_col
    bgt $t7, $s0, failure_opt1_col

    # Validate total allocation count fits safely within storage limit (<= 400)
    mul $t2, $t6, $t7
    bgt $t2, $s0, failure_bound_overflow

    # Persist dimension structural changes to RAM layout safely
    sw $t6, numRows
    sw $t7, numCols
    b while

failure_opt1_row:
    li $v0, 4
    la $a0, error_nrows
    syscall
    b while

failure_opt1_col:
    li $v0, 4
    la $a0, error_ncols
    syscall
    b while

failure_bound_overflow:
    li $v0, 4
    la $a0, error_dim
    syscall
    b while

# ------------------------------------
# Option 2: Swap two elements
# ------------------------------------
option_2:
    # Processing Base Target Element 1 (row1, col1)
    li $v0, 4
    la $a0, msg_i
    syscall
    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = row1
    blt $t0, $zero, failure_opt1_row
    bge $t0, $t8, failure_opt1_row

    li $v0, 4
    la $a0, msg_j
    syscall
    li $v0, 5
    syscall
    move $t1, $v0       # $t1 = col1
    blt $t1, $zero, failure_opt1_col
    bge $t1, $t9, failure_opt1_col

    # Processing Base Target Element 2 (row2, col2)
    li $v0, 4
    la $a0, msg_r
    syscall
    li $v0, 5
    syscall
    move $t2, $v0       # $t2 = row2
    blt $t2, $zero, failure_opt1_row
    bge $t2, $t8, failure_opt1_row

    li $v0, 4
    la $a0, msg_s
    syscall
    li $v0, 5
    syscall
    move $t3, $v0       # $t3 = col2
    blt $t3, $zero, failure_opt1_col
    bge $t3, $t9, failure_opt1_col

    # Resolve address index location for Element 1: (row1 * numCols + col1) * 4
    mul $t4, $t0, $t9
    addu $t4, $t4, $t1
    sll $t4, $t4, 2
    lw $t6, mat($t4)    # $t6 = extracted value1

    # Resolve address index location for Element 2: (row2 * numCols + col2) * 4
    mul $t5, $t2, $t9
    addu $t5, $t5, $t3
    sll $t5, $t5, 2
    lw $t7, mat($t5)    # $t7 = extracted value2

    # Execute symmetric value swap directly back to RAM targets
    sw $t7, mat($t4)
    sw $t6, mat($t5)
    b while

# --------------------------------------
# Option 3: Sum perimeter elements
# --------------------------------------
option_3:
    move $t2, $zero     # $t2 = perimeterSum accumulator = 0
    move $t0, $zero     # r = 0
loop_3_r:
    move $t1, $zero     # c = 0
loop_3_c:
    # Perimeter boundary conditional matching check: (r == 0 || r == numRows - 1 || c == 0 || c == numCols - 1)
    beq $t0, $zero, add_to_perimeter
    addi $t3, $t8, -1   # numRows - 1
    beq $t0, $t3, add_to_perimeter
    beq $t1, $zero, add_to_perimeter
    addi $t3, $t9, -1   # numCols - 1
    beq $t1, $t3, add_to_perimeter
    b skip_summation

add_to_perimeter:
    mul $t4, $t0, $t9
    addu $t4, $t4, $t1
    sll $t4, $t4, 2
    lw $t5, mat($t4)
    addu $t2, $t2, $t5

skip_summation:
    addi $t1, $t1, 1
    blt $t1, $t9, loop_3_c
    addi $t0, $t0, 1
    blt $t0, $t8, loop_3_r

    # Print evaluation calculations summary output
    li $v0, 4
    la $a0, msg_sum
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    b menu_prompt

# --------------------------------------------
# Option 4: Max and min of main diagonal
# --------------------------------------------
option_4:
    move $t2, $t8       # bounds Limit = numRows
    blt $t8, $t9, boundary_resolved
    move $t2, $t9       # bounds Limit = numCols (if numCols < numRows)
boundary_resolved:

    lw $t3, mat($zero)   # $t3 = maximum initial value
    lw $t4, mat($zero)   # $t4 = minimum initial value
    
    li $t0, 1           # iterator counter i = 1 
loop_4:
    bge $t0, $t2, end_loop_4
    
    # Mapping coordinates: (i * numCols + i) * 4
    mul $t5, $t0, $t9
    addu $t5, $t5, $t0
    sll $t5, $t5, 2
    lw $t6, mat($t5)    # $t6 = mat[i][i]

    # Evaluate Maximum bounds condition
    ble $t6, $t3, check_min
    move $t3, $t6       # Assign tracking target as New Max
check_min:
    # Evaluate Minimum bounds condition
    bge $t6, $t4, advance_diagonal
    move $t4, $t6       # Assign tracking target as New Min

advance_diagonal:
    addi $t0, $t0, 1
    b loop_4

end_loop_4:
    # Print calculated tracking extrema outputs
    li $v0, 4
    la $a0, msg_max
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, msg_min
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    b menu_prompt

# ----------------
# Program Exit
# ----------------
end:
    li $v0, 4
    la $a0, msg_end
    syscall

    li $v0, 10          # Environment environment teardown execution call
    syscall
.data
num1_low:   .word 0xFFFFFFFF      
num1_high:  .word 0x00000001      
num2_low:   .word 0x00000002      
num2_high:  .word 0x00000000     

result_low: .word 0
result_high:.word 0

    .text
    .globl main
    .globl add64

add64:
    add a0, a0, a2          
    sltu t0, a0, a2         
    add a1, a1, a3         
    add a1, a1, t0          
    jr ra                  

main:
    lw a0, num1_low, t0
    lw a1, num1_high, t0

    lw a2, num2_low, t0
    lw a3, num2_high, t0

    jal ra, add64

    sw a0, result_low, t0
    sw a1, result_high, t0

    li a7, 10
    ecall

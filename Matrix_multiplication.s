        .text
        .globl matrixMultiply
matrixMultiply:
        addi sp, sp, -32
        sw ra, 28(sp)
        sw s0, 24(sp)
        sw s1, 20(sp)
        sw s2, 16(sp)
        sw s3, 12(sp)
        sw s4, 8(sp)
        sw s5, 4(sp)
        sw s6, 0(sp)

        mv   s0, a0
        mv   s1, a1
        mul  t0, s0, s0
        slli t0, t0, 2
        add  s2, s1, t0
        add  s3, s2, t0
        li   s4, 0

outer_i:
        beq  s4, s0, done_mm
        li   s5, 0

outer_j:
        beq  s5, s0, next_row
        mul  t1, s4, s0
        slli t1, t1, 2
        add  a2, s1, t1
        slli t2, s5, 2
        add  a3, s2, t2
        mv   a0, s0
        jal  ra, innerProduct
        mul  t3, s4, s0
        add  t3, t3, s5
        slli t3, t3, 2
        add  t3, s3, t3
        sw   a0, 0(t3)
        addi s5, s5, 1
        j    outer_j

next_row:
        addi s4, s4, 1
        j    outer_i

done_mm:
        lw ra, 28(sp)
        lw s0, 24(sp)
        lw s1, 20(sp)
        lw s2, 16(sp)
        lw s3, 12(sp)
        lw s4, 8(sp)
        lw s5, 4(sp)
        lw s6, 0(sp)
        addi sp, sp, 32
        ret

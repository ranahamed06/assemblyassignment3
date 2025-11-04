        .text
        .globl innerProduct
innerProduct:
        addi sp, sp, -16
        sw ra, 12(sp)
        sw t0, 8(sp)
        sw t1, 4(sp)
        sw t2, 0(sp)

        li   t0, 0
        li   t1, 0

loop_inner:
        beq  t1, a0, done_inner
        lw   t2, 0(a2)
        lw   t3, 0(a3)
        mul  t4, t2, t3
        add  t0, t0, t4
        addi a2, a2, 4
        slli t5, a0, 2
        add  a3, a3, t5
        addi t1, t1, 1
        j    loop_inner

done_inner:
        mv   a0, t0
        lw ra, 12(sp)
        lw t0, 8(sp)
        lw t1, 4(sp)
        lw t2, 0(sp)
        addi sp, sp, 16
        ret

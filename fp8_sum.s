        .text
        .globl fp8_sum
fp8_sum:
        andi t0, a0, 0x80
        andi t1, a1, 0x80
        srli t2, a0, 4
        andi t2, t2, 0x07
        srli t3, a1, 4
        andi t3, t3, 0x07
        andi t4, a0, 0x0F
        andi t5, a1, 0x0F
        li t6, 16
        add t4, t4, t6
        add t5, t5, t6
        beq t2, t3, exp_equal
align_loop:
        blt t2, t3, align_a
        blt t3, t2, align_b
        j exp_equal
align_a:
        srl t4, t4, 1
        addi t2, t2, 1
        blt t2, t3, align_a
        j exp_equal
align_b:
        srl t5, t5, 1
        addi t3, t3, 1
        blt t3, t2, align_b
exp_equal:
        beq t0, t1, same_sign
        bnez t0, a_neg
        sub t4, t4, t5
        j combine
a_neg:
        sub t4, t5, t4
        mv t0, t1
        j combine
same_sign:
        add t4, t4, t5
combine:
        beqz t4, zero_ret
normalize:
        bge t4, t6, norm_done
        sll t4, t4, 1
        addi t2, t2, -1
        j normalize
norm_done:
        addi t4, t4, -16
        andi t4, t4, 0x0F
        slli t2, t2, 4
        or t2, t2, t4
        or a0, t2, t0
        ret
zero_ret:
        mv a0, x0
        ret

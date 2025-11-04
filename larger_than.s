       .text
        .globl larger_than
larger_than:

        
        srli t0, a0, 23         
        andi t0, t0, 1          
        srli t1, a1, 23
        andi t1, t1, 1          

        bne  t0, t1, diff_signs

        srli t2, a0, 24
        andi t2, t2, 0xFF       
        srli t3, a1, 24
        andi t3, t3, 0xFF       

        andi t4, a0, 0x7FFFFF   
        andi t5, a1, 0x7FFFFF   

        beqz t0, both_positive
both_negative:
        blt  t2, t3, return1     
        bgt  t2, t3, return0
        blt  t4, t5, return1     
        j    return0

both_positive:
        bgt  t2, t3, return1
        blt  t2, t3, return0
        bgt  t4, t5, return1
        j    return0
diff_signs:
        beqz t0, return1         
        j    return0            

return1:
        li   a0, 1
        ret
return0:
        li   a0, 0
        ret

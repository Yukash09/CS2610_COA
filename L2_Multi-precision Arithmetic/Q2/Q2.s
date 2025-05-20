.section .data
n1a:     .dword   0x1234567887654321
n1b:     .dword   0x1234567887654321
n2c:     .dword   0x8765432112345678
n2d:     .dword   0x8765432112345678

.section .text
.global main

main:
    addi sp , sp , -256
    ld t0 , n1a
    ld t1 , n1b 
    ld t2 , n2c
    ld t3 , n2d
    mul t4 , t1 , t3
    mulhu t5 , t1 , t3 
    sd   t4 , 0(sp)  # @ sp + 0 = b*d
    sd   t5 , 8(sp)
    mul  t4 , t1 , t2
    mulhu t5 , t1 , t2 
    sd   t4 , 16(sp)  # @ sp + 16 = b*c
    sd   t5 , 24(sp)
    mul  t4 , t0, t2
    mulhu t5 , t0, t2 
    sd   t4 , 32(sp)  # @ sp + 32 = a*c
    sd   t5 , 40(sp)
    mul  t4 , t0, t3
    mulhu t5 , t0, t3 
    sd   t4 , 48(sp)  # @ sp + 48 = a*d
    sd   t5 , 56(sp)

    ld  t0 , 16(sp)
    ld  t1 , 48(sp)
    add t2 , t0 , t1   # t2 - first half of ad+bc
    sltu t3 , t2 , t1
    sd  t2 , 64(sp)  # first half of ad+bc at sp+64
    ld  t0 , 24(sp)
    ld  t1 , 56(sp)
    add t4 , t0 , t1   # t4 - second half
    add t4 , t4 , t3
    sd   t4 , 72(sp)
    sltu s0 , t4 , t0  # s0 - carry over from ad+bc last part

    ld  t0 , 40(sp)

    ld t0 , 0(sp) ;
    sd t0 , 200(sp)  # lower bd at 200 + sp
    ld t0 , 64(sp)
    ld t1 , 8(sp)
    add t2 , t0 , t1 
    sd t2 , 208(sp)  # upper bd + lower(ad + bc) at 208 + sp
    sltu s1 , t2 , t0  # s1 - carry over from upper bd

    ld t0 , 32(sp)
    ld t1 , 72(sp)
    add t2 , t0 , s1
    add t2 , t2 , t1
    sltu s2 , t2 , t0   # s2 - carry over from lower ac + upper(ad + bc)
    sd t2 , 216(sp) # lower ac at 216 + sp

    ld t0 , 40(sp)
    add t1 , t0 , s0
    add t2 , t1 , s2
    sd t2 , 224(sp)
    sltu s3 , t2 , t0 

    sd t3 , 232(sp)

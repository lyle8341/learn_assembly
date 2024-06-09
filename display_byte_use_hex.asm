;十六进制形式在屏幕中间显示给定的byte型数据
;先将一个byte的高4位和低4位分开，显示对应的数码字符
; 方案1：比较指令，转移指令
; 方案2：0~9和字符 '0'~'9',映射关系 数值+30H=对应的ASCII字符值
;       10~15和'A'~'F'，映射关系，数值+37H=对应字符的ASCII字符值
; 方案3：建立一张表
; table db '0123456789ABCDEF' 字符表


assume cs:code
code segment
    start:   mov  al, 2bh                   ;待显示
             call showbyte
             mov  ax, 4c00h
             int  21h
    showbyte:
             jmp  short show
    table    db   '0123456789ABCDEF'        ;字符表
    show:    push bx
             push es
             push cx

             mov  ah, al
             mov  cl, 4
             shr  ah, cl                    ;右移4位，ah中得到高4位的值
             and  al, 00001111b             ; al中为低4位的值

    ;用高4位的值作为相对于table的偏移
             mov  bl, ah
             mov  bh, 0
             mov  ah, table[bx]
    ;取得对应的字符并显示
             mov  bx, 0b800h
             mov  es, bx
             mov  es:[160*12+40*2], ah
    ;用低4位的值al作为相对于table的偏移
             mov  bl, al
             mov  bh, 0
             mov  al, table[bx]

    ;取得对应的字符
             mov  es:[160*12+40*2+2], al

             pop  cx
             pop  es
             pop  bx
             ret
code ends
end start
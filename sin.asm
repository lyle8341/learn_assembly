


assume cs:code
code segment
    start:  
            mov  al, 60                                        ;求sin(60)
            call showsin
            mov  ax, 4c00h
            int  21h
    showsin:
            jmp  short show
    ;字符串偏移地址表
    table   dw   ag0, ag30, ag60, ag90, ag120, ag150, ag180    ;下面标号的地址
    ag0     db   '0',0                                         ;sin(0)对应的字符串
    ag30    db   '0.5',0                                       ;sin(30)对应的字符串
    ag60    db   '0.866',0                                     ;sin(60)对应的字符串
    ag90    db   '1',0                                         ;sin(90)对应的字符串
    ag120   db   '0.866',0                                     ;sin(120)对应的字符串
    ag150   db   '0.5',0                                       ;sin(150)对应的字符串
    ag180   db   '0',0                                         ;sin(180)对应的字符串

    show:   
            push bx
            push es
            push si

            mov  bx, 0b800h
            mov  es bx

            mov  ah, 0
            mov  bl, 30
            div  bl                                            ;用角度值/30作为相对于table的偏移量
            mov  bl, al                                        ;商放到bl中
            mov  bh , 0
            add  bx, bx                                        ;因为table是字，双倍的下标
            mov  bx, table[bx]                                 ; 取得对应字符串的偏移地址放在bx中

            mov  si, 160*12+40*2
    shows:  mov  ah, cs:[bx]
            cmp  ah, 0
            je   showret
            mov  es:[si], ah
            inc  bx
            add  si, 2
            jmp  shows

    showret:
            pop  si
            pop  es
            pop  bx
            ret
code ends
end start
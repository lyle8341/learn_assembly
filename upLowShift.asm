;大小写转换
; 第一个字符串：小写字母转换为大写字母
; 第二个字符串：大写字母转换为小写字母
; 逻辑与指令: and dest, src

assume cs:codesg, ds:datasg
datasg segment
           db 'BaSiC'
           db 'iNfOrMaTiOn'
datasg ends
codesg segment
    start: 
           mov  ax, datasg       ;
           mov  ds, ax

    ;第一个字符串
           mov  bx, 0
           mov  cx, 5
    s:     mov  al, [bx]
           and  al, 11011111b    ;与运算-->小写转大写
           mov  [bx], al
           inc  bx
           loop s
    ;第二个字符串
           mov  bx, 5
           mov  cx, 11
    s0:    mov  al, [bx]
           or   al, 00100000b
           mov  [bx], al
           inc  bx
           loop s0

           mov  ax, 4c00h
           int  21h
codesg ends
end start
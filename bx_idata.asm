; 用[bx+idata]方式进行数组的处理

assume cs:codesg, ds:datasm
datasm segment
           db 'BaSiC'
           db 'MinIX'
datasm ends

codesg segment
    start: 
           mov  ax, datasm
           mov  ds, ax
           mov  bx, 0
           mov  cx, 5
    s:     mov  al, [bx]
           and  al, 11011111b
           mov  [bx], al

           mov  al, [bx+5]
           or   al, 00100000b
           mov  [5+bx], al
           inc  bx
           loop s

           mov  ax, 4c00h
           int  21h
codesg ends
    end start
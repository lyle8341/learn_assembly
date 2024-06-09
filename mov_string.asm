; cld 将标志寄存器的DF位设置为0（clear）
; std 将标志寄存器的DF位设置为1（setup）


assume cs:code
data segment
         db 'Welcome to masm!'
         db 16 dup(0)
data ends
code segment
    start:mov ax, data
          mov ds, ax
          mov si, 0
          mov es, ax
          mov di, 16
          cld              ; 将DF位设置为0
          mov cx, 16
    
          rep movsb
    ;下面两行等价于上面这行
    ; s:    movsb
    ;       loop  s




          mov ax, 4c00h
          int 21h
code ends
end start
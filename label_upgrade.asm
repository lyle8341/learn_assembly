; 描述内存单元的标号
; label.asm 升级版本
; 后面没有冒号的标号，同时描述内存地址和单元长度

assume cs:code
code segment
    a     db   1,2,3,4,5,6,7,8    ;a代表地址为code:0，长度为字节的内存
    b     dw   0                  ;b代表地址为code:8，长度为字的内存单元
    start:mov  si, 0
          mov  cx, 8
    s:    mov  al, a[si]          ; si+a地址
          mov  ah , 0
          add  b, ax              ;b的偏移地址
          inc  si
          loop s
          mov  ax, 4c00h
          int  21h
code ends
end start
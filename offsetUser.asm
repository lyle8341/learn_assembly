;将s处的一条指令复制到s0处


assume cs:codeseg
codeseg segment
    s:      mov ax, bx
            mov si, offset s
            mov di, offset s0

    ;逻辑 mov ax, bx指令长度为两个字节，即一个字
            mov ax, cs:[si]
            mov cs:[di], ax


    s0:     nop
            nop                  ; nop的机器码占一个字节，起“占位”作用

codeseg ends
end
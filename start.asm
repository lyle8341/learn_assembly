;验证代码块是否必须用名为"start"标号
;随便起名



assume cs:codeseg, ds: data
data segment
         db 80 dup(0)
data ends
codeseg segment
    s:      mov ax, bx
            mov si, offset s
            mov di, offset s0

    s0:     
            nop

            mov ax, 4c00h
            int 21h
codeseg ends
end s
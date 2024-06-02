;

assume cs:codeseg
codeseg segment
    start:  
            mov ax, offset start    ;相当于 mov ax, 0
    s:      mov ax, offset s        ; 相当于 mov ax, 3 因为前一个指令是三字节指令

            mov ax, 4c00h
            int 21h
codeseg ends
end start


;有问题：下面写法在debug调试没有问题。通过汇编代码编译则会出问题
;结论: 常量作为偏移地址时，前面需要加上段寄存器 如： mov al, ds:[0]

ASSUME cs:codesg_custom
codesg_custom SEGMENT
                  mov ax, 2000h
                  mov ds, ax
                  mov al, [0]      ;被误解析为 mov al, 00
                  mov bl, [1]      ;被误解析为 mov bl, 01
                  mov cl, [2]      ;被误解析为 mov cl, 02
                  mov dl, [3]      ;被误解析为 mov dl, 03

    ;正确如下
    ;   mov al, ds:[0]
    ;   mov bl, ds:[1]
    ;   mov cl, ds:[2]
    ;   mov dl, ds:[3]

                  mov ax, 4c00h
                  int 21h
codesg_custom ENDS
END
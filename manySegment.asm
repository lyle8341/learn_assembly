; 将数据、代码、栈放入不同段
; 栈段和数据段需要初始化段寄存器

assume cs:code, ds:data, ss:stack

data segment
         dw 0123H, 0456H,0789H,0abcH, 0defH, 0fedH, 0cbaH, 0987H
data ends
stack segment
          dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack ends
code segment
    start:

          mov  ax, stack
          mov  ss, ax
          mov  sp, 20h
          mov  ax, data
          mov  ds, ax

    ;入栈
          mov  bx, 0
          mov  cx, 8
    s:    push [bx]         ; 默认是ds段
          add  bx, 2
          loop s

    ;出栈
          mov  bx, 0
          mov  cx, 8
    s0:   pop  [bx]         ; 默认是ds段
          add  bx, 2
          loop s0

          mov  ax, 4c00h
          int  21h
code ends
end start
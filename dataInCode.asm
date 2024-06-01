; 变成计算一下8个数据的和，结果存在ax寄存器中

assume cs:code
code segment

          dw   0123H, 0456H,0789H,0abcH, 0defH, 0fedH, 0cbaH, 0987H

    ; start定义一个标号，指示代码开始的位置
    start:mov  bx, 0
          mov  ax, 0
          mov  cx, 8

    s:    add  ax, cs:[bx]
          add  bx, 2
          loop s

          mov  ax, 4c00h
          int  21h

code ends
end start

; end的作用，除了通知编译器程序结束外，还可以通知编译器程序的入口在什么地方
; 程序加载后，CS:IP指向要执行的第一条指令在start处
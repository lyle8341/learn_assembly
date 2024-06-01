; 利用栈，将程序中定义的数据逆序存放

; 栈需要的内存空间，在程序中通过定义"空"数据来取得

assume cs:code
code segment

            dw   0123H, 0456H,0789H,0abcH, 0defH, 0fedH, 0cbaH, 0987H
            dw   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0                           ;多定义了几个

      start:
            mov  ax, cs
            mov  ss, ax
            mov  sp, 30h                                                   ;8个字空间+16个字栈空间=24个字=48字节=30H字节


            mov  cx, 8
            mov  bx, 0
      ;入栈
      pushS:push cs:[bx]
            add  bx, 2                                                     ;
            loop pushS

      ;出栈
            mov  cx, 8
            mov  bx, 0
      popS: pop  cs:[bx]
            add  bx, 2                                                     ;
            loop popS

            mov  ax, 4c00h
            int  21h
code ends
end  start; start定义一个标号，指示代码开始的位置
;两重循环问题处理方法2
;用栈保存数据

assume cs:code, ds:data, ss:stack
stack segment
            dw 0,0,0,0,0,0,0,0
stack ends
data segment
           db 'ibm             '
           db 'dec             '
           db 'dos             '
           db 'vax             '
data ends
code segment
      start:
            mov  ax, stack
            mov  ss , ax
            mov  sp 16

            mov  ax, data
            mov  ds, ax
            mov  bx,0
            mov  cx, 4
      s0:   mov  push cx            ;将外层循环的cx值保存到栈
            mov  si,0
            mov  cx, 3
      s:    mov  al,[bx+si]
            and  al, 11011111b
            mov  [bx+si], al
            inc  si
            loop s
            add  bx, 16
            mov  pop cx             ;从栈顶弹出原cx的值恢复cx
            loop s0

            mov  ax, 4c00h
            int  21h
code ends
end start



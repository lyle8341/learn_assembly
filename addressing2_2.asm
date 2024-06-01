;两重循环问题处理方法2
;用固定内存空间保存数据
;存在的问题：

assume cs:code, ds:data
data segment
           db 'ibm             '
           db 'dec             '
           db 'dos             '
           db 'vax             '
data ends

code segment
      start:
            mov  ax, data
            mov  ds, ax
            mov  bx,0
            mov  cx, 4
      s0:   mov  ds:[40H], cx       ;将外层循环的cx值保存在ds:[40H]单元中
            mov  si,0
            mov  cx, 3
      s:    mov  al,[bx+si]
            and  al, 11011111b
            mov  [bx+si], al
            inc  si
            loop s
            add  bx, 16
            mov  cx, ds:[40H]       ;用ds:[40H]中存放的外层循环的计数值恢复cx
            loop s0

            mov  ax, 4c00h
            int  21h
code ends
end start



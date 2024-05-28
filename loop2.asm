; 计算 ffff:0006字节单元中的数乘以3，结果存储在dx中---> 连加三次
; 汇编源程序中，数据不能以字母开头，要在ffff前面加0

assume cs:code
code segment
         mov  ax, 0ffffh
         mov  ds, ax
         mov  bx, 6
         mov  al, [bx]
         mov  ah, 0

         mov  dx, 0
         mov  cx, 3
    s:   add  dx, ax
         loop s

         mov  ax, 4c00h
         int  21h
code ends
end
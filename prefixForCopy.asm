; 将内存ffff:0~ffff:b中的数据拷贝到0:200~0:20b单元中

assume cs:code
code segment
         mov  ax, 0ffffh
         mov  ds, ax
         mov  ax, 0020h
         mov  es, ax

         mov  bx, 0
         mov  cx, 12

    s:   mov  dl, [bx]
         mov  es:[bx], dl
         inc  bx
         loop s

         mov  ax, 4c00h
         int  21h
code ends
ends
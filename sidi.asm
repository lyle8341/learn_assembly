;用寄存器SI和DI实现将字符串'welcome to masm!' 复制到它后面的数据区中


assume cs:code, ds:data
data segment
         db 'welcome to masm!'
         db '................'

data ends
code segment
    start:
          mov  ax, data
          mov  ds, ax

          mov  si, 0
          mov  di, 16
          mov  cx, 8        ;每次复制一个字

    s:    mov  ax, [si]
          mov  [di], ax
          add  si, 2
          add  di, 2
          loop s

          mov  ax, 4c00h
          int  21h
code ends
end start
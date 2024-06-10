;将以0结尾的字符转化为大写
;参数： ds:si指向字符串的首地址

assume cs:code
data segment
         db 'conversation',0
data ends
code segment
    start:mov ax, data
          mov ds, ax
          mov si, 0
          int 7ch
          mov ax, 4c00h
          int 21h
code ends
end start
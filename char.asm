;处理字符问题
;汇编程序中，用'.....'的方式指明数据是以字符的形式给出的，编译器将把他们转化为相应的ASCII码
; DS:0，即程序开始的地址，隔过100H程序段前缀，就是data数据开始
; 小写字母的ASCII码值比大写字母的ASCII码值大20H

assume cs:code, ds:data
data segment
         db 'unIX'
         db 'foRK'
data ends

code segment
    start:
          mov al, 'a'
          mov bl, 'b'
          mov ax, 4c00h
          int 21h
code ends
end start
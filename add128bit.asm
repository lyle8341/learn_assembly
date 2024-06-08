;128位数据相加 128位需要8个字
; 两个逆序存放的128位数据相加

assume cs:code, ds:data
data segment
            dw 0A452H,0A8F5H,78E6H,0A8EH,8B7AH,54F6H,0F04H,671EH
            dw 0E71EH,0EF04H,54F6H,8B7AH,0A8EH,78E6H,58F5H,0452H

data ends
code segment
       start: mov  ax, data
              mov  ds, ax

              mov  si, 0
              mov  di, 16
              mov  cx, 8
              call add128
              mov  ax, 4c00h
              int  21h
       add128:                     ;定义子程序
              push ax              ;保存现场
              push cx
              push si
              push di
              sub  ax, ax          ;使ax值变成0，！！！CF也会变成0（目的）
       s:     mov  ax, [si]
              adc  ax, [di]
              mov  [si], ax

              inc  si
              inc  si
       ;!!!add  si, 2 此处不可以把两次inc替换为+2，因为可能会产生进位

              inc  di
              inc  di
       ;!!!add  id, 2 此处不可以把两次inc替换为+2，因为可能会产生进位
              loop s

              pop  di              ;恢复现场
              pop  si
              pop  cx
              pop  ax
code ends
end start
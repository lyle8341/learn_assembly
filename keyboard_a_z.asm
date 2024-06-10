

assume cs:code
stack segment
            db 128 dup(0)
stack ends
code segment
      start:
            mov  ax, stack
            mov  ss, ax
            mov  sp, 128

      ;显示字符
            mov  ax, 0b800h
            mov  es, ax
            mov  ah, 'a'
      s:    mov  es:[160*12+40*2], ah
            call delay
            inc  ah
            cmp  ah, 'z'
            jna  s

            mov  ax, 4c00h
            int  21h

      delay:
            push ax
            push dx
      ;延时逻辑;
      ;100000h次，用两个16位寄存器存放32位的循环次数
            mov  dx, 10h
            mov  ax, 0
      s1:   sub  ax,1
            sbb  dx, 0
            cmp  ax, 0
            jne  s1
            cmp  dx, 0
            jne  s1

            pop  dx
            pop  ax
            ret

code ends
end start
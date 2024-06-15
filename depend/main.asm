extrn subp:far
assume cs:code, ss:stack

stack segment
          db 16 dup(0)
stack ends
code segment
    start:mov  ax, stack
          mov  ss, ax
          mov  sp, 16
          mov  ax, 1000
          call far ptr subp    ;调用子程序
          mov  ax, 4c00h
          int  21h
code ends
end start
; 
assume cs:code, ss:stack
stack segment
          db 16 dup(0)
stack ends
code segment
main PROC
    start:mov  ax, stack
          mov  ss, ax
          mov  sp, 16
          mov  ax, 1000
          call subp
          mov  ax, 4c00h
          int  21h
main ENDP

subp PROC
    s:    add  ax, ax
          ret
subp ENDP
code ends
end start
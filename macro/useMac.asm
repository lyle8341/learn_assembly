; 使用宏库
include asmio.mac
data segment
    string db 'hello world',13,10,'$'
data ends
code segment
          assume cs:code, ds:data
    start:
          mov    ax, data
          mov    ds, ax
          output string
          mov    ah, 4ch
          int    21h
code ends
end start
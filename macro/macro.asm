
assume cs:code
data segment
    n1   dw 1
data ends
code segment
    mproc MACRO p1,p2,p3
        mov ax, p1
        mov cx, p2
        mov dx, p3
    ENDM
    start:mov   ax, data
          mov   ds, ax
          lea   bx, n1
          mproc [bx],bx,100h
          mproc 1, n1, cx
          mov   ax, 4c00h
          int   21h
code ends
end start
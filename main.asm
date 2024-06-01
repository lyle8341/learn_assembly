; codesg_custom 段名
; assume 假设某一段寄存器和程序中的某一个用segment...ends定义的段相关联
assume CS:codesg_custom            ;伪指令，编译器根据伪指令来进行相关的编译工作
codesg_custom SEGMENT              ;伪指令
                  MOV ax, 0123H
                  MOV bx, 0456H
                  add ax, bx
                  add ax, ax


                  mov ax, 4c00h    ;程序结束后将CPU的控制权交还给使它得以运行的程序
                  int 21h
codesg_custom ENDS                 ;伪指令
END                                ;伪指令，汇编程序的结束标记，若不加END， 编译器在编译时，无法知道程序在何处结束

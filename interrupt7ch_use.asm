; 应用举例: 2*3456^2
assume cs:code
code segment
    start:mov ax, 3456
          int 7ch          ;计算ax^2
          add ax, ax       ;低位相加
          adc dx, dx       ;高位相加，带进位
          mov ax, 4c00h
          int 21h
code ends
end start
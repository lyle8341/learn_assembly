;利用除法指令 计算 100001/100
;分析 100001D=186A1H
;需要16位的除法，因为被除数超过16位


;
;
;   mov dx, 1
;   mov ax, 86A1
;   mov bx, 64H
;   div bx
;
; g sa:ea
; t
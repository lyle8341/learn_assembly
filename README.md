# Learn Assembly Language

## 环境

- VSCodeUserSetup-x64-1.68.1
- win8.1

## 指令和数据

- 指令和数据，都是二进制信息
- 二进制信息 1000100111011000 是数据还是指令
  - 1000100111011000 -> 89D8H(数据)
  - 1000100111011000 -> MOV AX,BX(程序)
- 数据如何表示
  - 1000100111011000**B**（二进制）
  - 89D8**H**（十六进制）

    ```
    四位二进制对应一位十六进制位
    1000-1001-1101-1000
    8----9----D----8
    ```
  - 104730**O**（八进制）
  - 35288**D**（十进制）

## 内存地址空间

- 8086CPU的地址总线宽度为20位，寻址能力为1M
- 运算器一次最多处理16位的数据，寄存器最大宽度为16位
- 8086内部处理的、传输、暂存的地址也是16位
- 用两个16位地址（段地址、偏移地址）合成一个20位的物理地址
- 内存并没有分段，段的划分来自于**CPU**

+ **堆栈**是向***低端***地址生长的

## 8086CPU架构

![8086 cpu架构](images/architecture_of_8086.jpg)

## 8086寄存器

8086CPU有14个寄存器

1. 通用寄存器
   1. **AX**(Accumulator Register), and preferred for most operations.
   2. **BX**(Base Register), typically used to hold the address of a procedure or variable.
   3. **CX**(Counter Register), typically used for looping.
   4. **DX**(Data Register), typically used for multiplication and division.
   5. **最大值** FFFFH
2. 变址寄存器
   1. **SI**(Source Index), used for copying strings, segment register varies
   2. **DI**(Destination Index), used for destination for copying strings
3. 指针寄存器
   1. **SP**(Stack Pointer), offset from SS register as to the location of the stack's top
   2. **BP**(Base Pointer), offset from SS register to locate variables on the stack
4. 指令指针寄存器
   1. **IP**(Instruction Pointer), offset from the CS for the next instrunction to excute
5. 段寄存器
   1. **CS**(Code Segment), base location of program code
   2. **SS**(Stack Segment), base location of the stack
   3. **DS**(Data Segment), base location for variables
   4. **ES**(Extra Segment), additional base location for variables in memory
6. 标志寄存器 **PSW**(Program Status Word , also called Flag register)
   1. **Program Status Word** , also called Flag **register**

8086CPU所有寄存器都是***16***位的，可以存放两个***字节***

## 8086内存使用情况

![memory usage](images/memory_usage.png)

## 32位EAX,EBX, ECX, and EDX registers'

> The new registers are prefaced with an “E” to indicate that they are the “Extended” registers.

## 汇编指令(不区分大小写)

mov ax, 18  	寄存器AX = 18

add ax, 8 	AX = AX + 8

mov ax, bx	AX = BX

add ax, bx	AX = AX + BX

备注： 没有指定进制，默认为**十进制**


## DEBUG调试工具

***R*** 							查看寄存器内容

**R 寄存器名（回车）**			改变指定寄存器内容

**R寄存器名（回车）**				改变指定寄存器内容

---

**D**							查看内存中的内容（默认128个字节）

**D 段地址:偏移地址 结尾偏移**		列出内存中指定地址范围内的内容（显示 ***结尾偏移*** + 1 个）

---

**E 段地址:偏移地址 数据1 数据2 ...**	改变内存中的内容

**E 段地址:偏移地址**

* **逐个询问式修改**
* **空格（接受），继续**
* **回车（结束）**

---

**U**							机器指令到汇编指令

eg:

* e 2000:0 b8 23 01 bb 03 00 89 d8 01 d8
* d 2000:0
* u 2000:0

---

**A**							以汇编指令格式写入机器指令

eg:

* a 073f:0100（回车）
* mov ax, 0123
* mov bx, 0003
* mov ax, bx
* add ax, bx
* 回车

---

**T**							执行 ***CS:IP*** 处机器指令

---

**Q**							退出Debug

---

# RISC-V
Somewhat functional RISC-V processor implementation in verilog.

# Description
Pipelined RISC-V processor implementation in Verilog with a hazard detection unit and a forwarding unit.

# The problems
The code is somewhat messy at parts and its not a 100% implementation of the processor, more of a proof of concept.
The .mem file contains instructions already converted to hex for the processor to run.

```
add x2,x1,x0
addi x1,x1,1
and x3,x1,x2
ori x4,x1,1 
sw x4,4(x5)
lw x12,8(x0)  
beq	x18,x0,5c
```

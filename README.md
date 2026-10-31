# 8-bit RISC-V Inspired ALU (Verilog HDL)

## Overview
This repository contains the Verilog HDL implementation and verification environment for an 8-bit Arithmetic Logic Unit (ALU) inspired by the RISC-V base integer instruction set.

The project includes a modular synthesizable RTL design, a self-checking testbench to verify correctness, and a simulation flow using Icarus Verilog and GTKWave.

---

## Directory Structure
```text
riscv-8bit-alu/
├── rtl/
│   └── alu.v            # Synthesizable 8-bit ALU module
├── sim/
│   └── alu_tb.v         # Self-checking testbench
├── .gitignore           # Filters simulation artifacts (.vcd, alu_sim)
└── README.md            # Project documentation
```

---

## Architecture & Specifications

### Top-Level Interface

**Inputs:**
- `a [7:0]`: 8-bit operand A
- `b [7:0]`: 8-bit operand B
- `alu_op [3:0]`: 4-bit operation select control code

**Outputs:**
- `result [7:0]`: 8-bit operation result
- `zero`: High (`1'b1`) when `result == 8'h00`, low (`1'b0`) otherwise
- `overflow`: High (`1'b1`) when arithmetic signed addition/subtraction overflows

### Supported Operations

| Operation Code (`alu_op`) | Operation Name | Description | RISC-V ISA Equivalent |
|---------------------------|----------------|-------------|-----------------------|
| `4'b0000` | ADD | Addition (`a + b`) | `ADD` / `ADDI` |
| `4'b0001` | SUB | Subtraction (`a - b`) | `SUB` |
| `4'b0010` | AND | Bitwise AND (`a & b`) | `AND` / `ANDI` |
| `4'b0011` | OR  | Bitwise OR (`a \| b`) | `OR` / `ORI` |
| `4'b0100` | XOR | Bitwise XOR (`a ^ b`) | `XOR` / `XORI` |
| `4'b0101` | SLT | Set Less Than (signed comparison: `a < b ? 1 : 0`) | `SLT` / `SLTI` |
| `4'b0110` | SLL | Shift Left Logical (`a << b[2:0]`) | `SLL` / `SLLI` |
| `4'b0111` | SRL | Shift Right Logical (`a >> b[2:0]`) | `SRL` / `SRLI` |
| `4'b1000` | SRA | Shift Right Arithmetic (`$signed(a) >>> b[2:0]`) | `SRA` / `SRAI` |

---

## Verification & Simulation

Verification is performed using **Icarus Verilog** (`iverilog`) for compilation and **GTKWave** for waveform analysis. The testbench (`alu_tb.v`) generates directed test vectors covering boundary conditions, zero-flag assertions, overflow flags, and arithmetic edge cases.

### Simulation Steps

1. **Compile the design and testbench:**
   ```bash
   iverilog -o sim/alu_sim rtl/alu.v sim/alu_tb.v
   ```

2. **Run the simulation:**
   ```bash
   vvp sim/alu_sim
   ```

3. **Open waveform in GTKWave:**
   ```bash
   gtkwave alu_waveform.vcd
   ```

---

## Toolchain & Requirements
- **Language:** Verilog HDL (IEEE 1364-2001)
- **Simulator:** Icarus Verilog v11.0+
- **Waveform Viewer:** GTKWave v3.3+
- **OS Environment:** Linux Mint / Ubuntu

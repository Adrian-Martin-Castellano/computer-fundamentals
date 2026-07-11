# Computer Principles (Principios de Computadores)

Undergraduate laboratory assignments and low-level source architecture code developed in **MIPS Assembly** for the Computer Principles university course.

---

## Repository Structure

The project is organized into modular directories representing distinct developmental phases of low-level software engineering:

*   **`assignment-1-matrix-processor/`**: Core foundations of MIPS simulation, console handling, conditional structures, and multi-assignment matrix tracking.
*   **`assignment-2-vector-subroutines/`**: Advanced modular programming utilizing standard stack frame mechanics (`$sp`), nested function linkages (`$ra`), floating-point mathematics, and in-place recursive algorithms.

---

## Key Architectural Concepts Covered

### 1. Subroutines & Calling Conventions
*   Implementation of nested modular blocks passing arguments systematically via `$a0-$a3` and returning evaluations through `$v0` or `$f0`.
*   Strict preservation of callee-saved and caller-saved registers inside the stack pointer lifecycle to guarantee memory safety.

### 2. Low-Level Memory Management
*   Static allocation layouts using `.space`, `.word`, and `.ascii/z` segments.
*   Dynamic index addressing calculations using raw offset multipliers tailored for structural types (4-byte alignment boundaries for `float` elements).

### 3. Floating-Point Processing (FPU Co-processor 1)
*   Isolated execution of Single-Precision Arithmetic instructions (`add.s`, `sub.s`, `mul.s`).
*   Data type conversion protocols (`cvt.s.w`, `mtc1`) to pipe immediate registers onto floating-point pipelines safely.

### 4. Mathematical & Structural Recursion
*   Implementation of in-place matrix and structural array inversions via divide-and-conquer recursive call stacks (`mirror`).

---

## Environment & Tools

All modules contained within this repository are optimized and verified to compile and run seamlessly on:
*   **QtSpim** Lightweight MIPS R2000/R3000 Simulator
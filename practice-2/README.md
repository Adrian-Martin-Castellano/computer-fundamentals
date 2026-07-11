# Assignment 2: MIPS Subroutines & Vector Metrics

## Overview
This project implements an interactive vector manipulation system written in **MIPS Assembly**. It demonstrates advanced low-level programming mechanics, modular programming layouts via standard application calling conventions, and recursive processing.

## Implemented Subroutines
*   **`print_vec`**: Iterates through memory sequences tracking active sizing properties to display vector values separated by spaces.
*   **`change_elto`**: Direct index manipulation interface updating explicit float nodes based on zero-indexed mapping parameters.
*   **`swap`**: Exchanges the positioning of two distinct floating-point memory elements.
*   **`mirror`**: A **recursive implementation** that inverts a vector layout structure in place by recursively shrinking matrix index ranges.
*   **`prod_esc`**: Evaluates coordinate parameters to return mathematical dot product calculations using isolated algorithmic multiply-add pipelines (`mult_add`).

## Execution Instructions
1. Initialize **QtSpim** runtime interface.
2. Load the source file: `vector_subroutines.s`.
3. Assemble (`F3` inside MARS) and run the console script.
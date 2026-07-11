# Assignment 1: MIPS Assembly Matrix Processor

## 📝 Overview
This project implements an interactive matrix manipulation system written in **MIPS Assembly**. It manages a 2D matrix dynamic layout mapped onto a linear contiguous memory range, allowing real-time dimension shifts and geometric attribute calculations via an interactive command-line menu.

## 🛠️ Implemented Features
* **Matrix Visualizer:** Renders the internal state of the matrix matching current dimension attributes.
* **Dimension Modifier (Option 1):** Dynamically resizes rows and columns with boundary allocation safety filters (Max 400 elements).
* **Element Swapper (Option 2):** Exchanges the positioning of two discrete elements given their row-column coordinates.
* **Perimeter Summation (Option 3):** Loops through boundary conditions ($f = 0, f = n-1, c = 0, c = m-1$) to isolate and sum perimeter values.
* **Diagonal Extremes Calculator (Option 4):** Evaluates the main diagonal to find the maximum and minimum values.

## 🚀 Execution
Run this script using **QtSpim**:
1. Load `matrix_processor.s` into the simulator.
2. Assemble and hit **Run**.
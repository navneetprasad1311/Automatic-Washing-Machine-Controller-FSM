# 🚿 Automatic Washing Machine Controller FSM

## 📌 Project Overview
This project implements a **Finite State Machine (FSM)** based controller for a **semi-automatic washing machine** using Verilog HDL. It simulates the sequential stages of the wash cycle and handles input signals like **start**, **pause**, **reset**, and **lid status**, with control outputs for **input valve** and **drain valve**.

---

## ⚙️ Features

- **FSM Stages**:
  - `IDLE → FILL → WASH → RINSE → SPIN → STOP`
- Each stage runs for a fixed time (defined by counters).
- Responds to:
  - `start` – Begins the washing process
  - `pause` – Temporarily halts operation
  - `reset` – Aborts current operation and returns to `IDLE`
  - `lid` – Lid must be closed for certain operations
- Controls:
  - `input_valve` – Lets water in
  - `output_drain` – Drains water out
- `done` output signal goes high when the washing cycle completes.

---

## 🛠️ Specifications

- Software: Vivado ML Edition (Standard) 2024.2
- Hardware: ZedBoard Zynq-7000 ARM / FPGA SoC Development Board

---

## 📥 Inputs

| Signal | Width | Description |
|--------|-------|-------------|
| `clk` | 1-bit | Clock input |
| `reset` | 1-bit | Asynchronous reset |
| `start` | 1-bit | Start washing |
| `pause` | 1-bit | Pause washing |
| `lid` | 1-bit | Lid status (1 = open) |

---

## 📤 Outputs

| Signal | Width | Description |
|--------|-------|-------------|
| `stage` | 3-bit | Current FSM stage |
| `done` | 1-bit | Indicates completion |
| `input_valve` | 1-bit | Controls water intake |
| `output_drain` | 1-bit | Controls water drainage |

---

## 🧠 FSM States

| State | Encoding | Function |
|-------|----------|----------|
| `IDLE` | 111 | Waits for start or resume |
| `FILL` | 000 | Water fills with lid closed |
| `WASH` | 001 | Drum rotates to wash |
| `RINSE` | 010 | Periodic refill and drain |
| `SPIN` | 011 | Water drained and spun |
| `STOP` | 100 | Final stage before done |

---

## 🔁 FSM Transition Logic

- If `pause` is pressed, the system enters `IDLE` and stores the previous state.
- If `lid` is open during **FILL**, system waits until lid is closed.
- In **RINSE**, valve toggles periodically between drain and fill.
- After **SPIN**, system goes to **STOP** and then `done` is asserted.

---

## 🧪 Simulation Demo

🎥 [Demo Video](https://github.com/Akashselvam2302/images/raw/refs/heads/main/Demo.mp4) <- Click here to download and watch our demo video!

📸 **Waveform Screenshot**: ![Image](https://github.com/user-attachments/assets/7f16bc30-de79-435b-8dce-28846760bcf9)

---

## 🔍 Reports

### ⚙️ Schematic Design 

![Image](https://github.com/user-attachments/assets/2b4de1b8-0406-45b2-9ba3-5fb12a0b65f0)

### ⛓️ Resource Utilization (Post-Synthesis)

![Image](https://github.com/user-attachments/assets/7efd2422-77f2-41f0-b151-fd6acbdc69e6)

### ⏱️ Timing Summary

![Image](https://github.com/user-attachments/assets/db1bb2c1-2783-42e5-9f2f-a396b2c2b43a)

---

### ⚡ Power Summary

![Image](https://github.com/user-attachments/assets/fb6b26af-2ec7-4889-b664-cabc2a7413db)

---

## 🔌 Pin Assignment

![Image](https://github.com/user-attachments/assets/404152c0-f07f-4064-9530-d700d08b210f)

---

## 📂 File Structure

![Image](https://github.com/user-attachments/assets/1285c666-c111-4135-9a12-02e9246d665d)

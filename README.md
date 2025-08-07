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
| `lid` | 1-bit | Lid status (1 = closed) |

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

🎥 **Demo Video**: [`washing_machine_demo.mp4`](./video/washing_machine_demo.mp4)  
📸 **Waveform Screenshot**: [`waveform.png`](./waveform/waveform.png)

---

## 🔍 Reports

### ⛓️ Resource Utilization (Post-Synthesis)

| Resource | Usage | Description |
|----------|-------|-------------|
| LUTs | -- | [Auto-fill from synthesis] |
| Flip-Flops | -- | [Auto-fill] |
| IOBs | -- | [Auto-fill] |

### ⏱️ Timing Summary

| Parameter | Value |
|----------|--------|
| Clock Period | x.xx ns |
| Max Frequency | xxx MHz |
| Setup/Hold Violations | None |

### ⚡ Power Summary

| Component | Dynamic (mW) | Static (mW) |
|-----------|--------------|-------------|
| Logic | -- | -- |
| Clock | -- | -- |
| I/O | -- | -- |

> All data above can be generated using Vivado or Quartus.

---

## 🔌 Pin Assignment

| Signal | Pin | Description |
|--------|-----|-------------|
| `clk` | e.g., A1 | Clock input |
| `reset` | e.g., B2 | Reset button |
| `start` | e.g., C3 | Start button |
| `pause` | e.g., D4 | Pause button |
| `lid` | e.g., E5 | Lid sensor |
| `stage[2:0]` | F6–H6 | Stage display (LEDs) |
| `done` | e.g., J7 | Completion indicator |
| `input_valve` | e.g., K8 | Valve control (LED/relay) |
| `output_drain` | e.g., L9 | Drain control (LED/relay) |

> Pin numbers should be updated based on your FPGA board (e.g., Basys 3, DE10-Lite).

---

## 📂 File Structure

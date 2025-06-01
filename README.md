# 💾 Disk Calculator (x86 Assembly)

## 📝 Description
Disk Calculator is a simple DOS-based calculator written in x86 Assembly language. It performs basic arithmetic operations on two-digit integers (00–99). The operations include:

- Addition
- Subtraction
- Multiplication
- Division (with quotient and remainder)

All input/output is handled via DOS interrupts (`int 21h`), and the calculator gracefully handles errors such as invalid input, divide-by-zero, and overflow.

---

## 🛠️ Features

- Interactive text-based menu
- Accepts two-digit number inputs
- Handles negative results in subtraction
- Displays remainder in division
- Detects and reports:
  - Invalid menu options
  - Invalid number input
  - Overflow in addition and multiplication
  - Division by zero
- Clean exit with a thank-you message

---
⌨️ Program Flow
1.Displays a calculator menu.

2.User selects an operation (1–5).

3.Prompts for two-digit number inputs.

4.Performs the selected operation.

5.Displays result or error message.

6.Returns to the main menu unless "Exit" is selected.

--------

⚠️ Error Handling
Invalid Menu Option: Shows error and re-displays the menu

Invalid Number Input: Accepts only numeric digits (0–9)

Addition/Multiplication Overflow: Shows overflow message

Division by Zero: Displays specific divide-by-zero error



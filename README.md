# 🧮 My Calc - Foundry Fuzzing Testing

A Solidity-based project designed to test and validate a calculator smart contract using fuzzing techniques. This project leverages **Foundry** for unit testing and **fuzzing testing**, and **Solidity** for smart contract development, ensuring robust and reliable functionality.

## 📑 Table of Contents
- [🧑‍💻 Features](#-features)
- [🎨 Technology Stack](#-technology-stack)
- [🗂️ Project Structure](#-project-structure)
- [📖 How to Use This Repo](#-how-to-use-this-repo)
- [🧪 Testing with Foundry](#-testing-with-foundry)
- [📜 License](#-license)

## 🧑‍💻 Features
- Perform unit tests for basic calculator operations (addition, subtraction, multiplication, division).
- Validate edge cases using fuzz testing.
- Ensure contract security by testing for reverts and invalid inputs.
- Simulate different user roles (e.g., admin vs. regular user).

## 🎨 Technology Stack

### Key Technologies
| Technology       | Purpose & Advantages                                                                                     |
|------------------|----------------------------------------------------------------------------------------------------------|
| **Solidity**     | A secure and efficient programming language for writing Ethereum-based smart contracts.                  |
| **Foundry**      | A comprehensive development framework for Ethereum, offering fast compilation, testing, fuzzing, and deployment tools. |


### Design Practices
- **Fuzz Testing**: Automatically generate test cases to validate edge cases and unexpected inputs.
- **Role-Based Access Control**: Ensure only authorized users can perform specific actions.
- **Gas Optimization**: Measure and optimize gas usage for contract functions. Snapshots provide a detailed breakdown of gas usage for each function, helping identify areas for optimization.

## 🗂️ Project Structure

The project is organized as follows:

```
src/
├── Calculator.sol        # Smart contract implementation
test/
├── CalculatorTest.t.sol  # Unit and fuzz tests for the calculator
cache/
├── fuzz/                 # Fuzzing test results
├── test-failures         # Cached test failures
├── snapshot/             # Gas usage snapshots
.gas-snapshot             # Detailed gas usage report for tests
```

## 📖 How to Use This Repo

Follow these steps to set up and run the tests:

### ⚙️ Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/my-calc-fuzzing-testing.git
   cd my-calc-fuzzing-testing
   ```
2. Install Foundry:
   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

### 🚀 Running Tests

#### Build the Project:
   ```sh
   forge build
   ```

#### Run Unit and Fuzz Tests:
   ```sh
   forge test
   ```

#### Run Coverage for Quality:
   ```sh
   forge coverage
   ```

#### View Gas Snapshots:
   ```sh
   forge snapshot
   ```

## 🧪 Testing with Foundry

The following table summarizes the tests implemented in this project, their type, and a brief description:

| **Test Name**                | **Type**         | **Description**                                                                 |
|------------------------------|------------------|---------------------------------------------------------------------------------|
| `testAddition`               | Unit Test        | Validates the addition operation of the calculator.                            |
| `testSubstraction`           | Unit Test        | Validates the subtraction operation of the calculator.                         |
| `testMultiplier`             | Unit Test        | Validates the multiplication operation of the calculator (admin only).         |
| `testMultiplierNotAllowed`   | Unit Test        | Ensures only the admin can perform multiplication operations.                  |
| `testDivision`               | Unit Test        | Validates the division operation of the calculator (admin only).               |
| `testDivisionNotAllowed`     | Unit Test        | Ensures only the admin can perform division operations.                        |
| `testDivisionCanNotbyZero`   | Unit Test        | Ensures division by zero is not allowed.                                       |
| `testCount`                  | Unit Test        | Checks the counter for the number of operations performed.                     |
| `testFuzzingAddition`        | Fuzz Test        | Tests the addition operation with random inputs, avoiding overflow.            |
| `testFuzzingSubstraction`    | Fuzz Test        | Tests the subtraction operation with random inputs, avoiding underflow.        |
| `testFuzzingMultiplier`      | Fuzz Test        | Tests the multiplication operation with random inputs, avoiding overflow.      |
| `testFuzzingMultiplierNotAllowed` | Fuzz Test   | Ensures only the admin can perform multiplication operations with random inputs.|
| `testFuzzingDivision`        | Fuzz Test        | Tests the division operation with random inputs, avoiding division by zero.    |
| `testFuzzingDivisionNotAllowed` | Fuzz Test     | Ensures only the admin can perform division operations with random inputs.     |
| `testFuzzingCount`           | Fuzz Test        | Validates the counter functionality with random inputs.                        |

### Coverage Report

Ran 1 test suite in 50.47ms (45.03ms CPU time): 15 tests passed, 0 failed, 0 skipped (15 total tests)

```
╭-------------------------+-----------------+-----------------+---------------+---------------╮
| File                    | % Lines         | % Statements    | % Branches    | % Funcs       |
+=============================================================================================+
| src/Calculator.sol      | 100.00% (21/21) | 100.00% (15/15) | 100.00% (4/4) | 100.00% (6/6) |
╰-------------------------+-----------------+-----------------+---------------+---------------╯
```

## 📜 License

This project is licensed under the GPL-3.0 License. See the `LICENSE` file for details.

# Pipelined Five-Stage RISC-V Core in Verilog HDL

## Overview

This project implements a pipelined five-stage RISC-V processor core in Verilog HDL, designed for educational, research, and embedded system applications. The core currently supports a subset of RV32I instructions (S-type, B-type, I-type, R-type) with modular pipeline stages and a framework for hazard management.  

## Features

- Five-stage pipeline: Fetch, Decode, Execute, Memory, Write-back
- Modular Verilog HDL source code, suitable for simulation and FPGA/ASIC use
- Supports basic RV32I instructions
- Testbench included for behavioral simulation
- Hazard management unit (initial framework, under development)
- MIT licensed

## Getting Started

### Prerequisites

- Any Verilog simulator (Icarus Verilog, ModelSim, etc.)
- Optional: FPGA development tools for synthesis
- Knowledge of Verilog HDL and RISC-V architecture

### Cloning

```
git clone https://github.com/F0ka/Pipelined-Five-Stage-RISC-V-Core-in-Verilog.git
cd Pipelined-Five-Stage-RISC-V-Core-in-Verilog
```

### Simulation

1. Open your simulation tool.
2. Compile and run the testbench (usually in `/tb` directory).
3. View output waveforms to confirm proper pipeline operation.

## Directory Structure

```
*.v # Verilog HDL core pipeline modules
LICENSE # MIT License
README.md # Project documentation
```

## Contributing

Contributions and suggestions are welcome. Please open issues or submit pull requests for improvements or changes.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Author

Farok Albadri  
Department of Computer Engineering, University of Tripoli, Libya  
far.albadri@uot.edu.ly , fo0kaalbadri@gmail.com

---

Give the project a ⭐ if you find it useful or interesting!

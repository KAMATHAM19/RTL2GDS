# RTL2GDS

## 📑 Contents

### [FLAT DESIGN](#flat-design)
1. [Register Transfer Level (RTL)](#register-transfer-level-rtl)
2. [Simulation using VCS and Verdi](#simulation-using-vcs-and-verdi)
3. [Verification](#verification)
   - [Coverage Analysis](#1-coverage-analysis)
   - [SV Methodology](#2-sv-methodology)
4. [Linting – Spyglass](#linting--spyglass)
5. [Logic Synthesis](#logic-synthesis)
   - [Inputs](#logic-synthesis-inputs)
   - [Process](#logic-synthesis-process)
   - [Scripts](#logic-synthesis-scripts-and-flow)
   - [Optimizations](#optimizations)
   - [Outputs](#outputs)
   - [Checks](#checks-performed)
6. [Formality Equivalence Checking](#formality-equivalence-checking)
7. [Physical Design](#physical-design)
8. [Import Design / Netlist](#1-import-design--netlist)
9. [Floorplan](#floorplan)
   - [Objective](#objective)
   - [Inputs](#inputs)
   - [Floorplanning Steps](#floorplanning-steps)
   - [Script](#ports-placement)
   - [Floorplan Optimizations](#floorplan-optimizations)
   - [Outputs](#outputs-1)
   - [Checks](#checks-after-floorplan)
10. [Powerplan](#power-plan)
    - [Objective](#objectives)
    - [Inputs](#inputs-1)
    - [Powerplanning Steps](#process)
    - [Script](#script)
    - [Powerplan Optimizations](#powerplan-optimizations)
    - [Outputs](#outputs-2)
    - [Checks](#checks-1)
11. [Placement](#placement)
    - [Objective](#objectives-1)
    - [Inputs](#inputs-2)
    - [Placement Steps](#placement-process)
    - [Script](#script-1)
    - [Placement Optimizations](#optimizations)
    - [Outputs](#outputs)
    - [Checks](#checks-after-placement)
12. [Clock Tree Synthesis](#clock-tree-synthesis-cts)
    - [Objective](#objectives-2)
    - [Inputs](#inputs-3)
    - [CTS Steps](#process)
    - [Script](#script)
    - [CTS Optimizations](#optimizations-1)
    - [Outputs](#outputs)
    - [Checks](#checks)
13. [Routing](#routing)
    - [Objective](#objectives-3)
    - [Inputs](#inputs-4)
    - [Routing Steps](#process)
    - [Script](#script-2)
    - [Routing Optimizations](#optimizations-2)
    - [Outputs](#outputs-1)
    - [Checks](#checks-2)

---

## 🛠️ Tools

| Tool                             | Purpose        | Command |
|----------------------------------|----------------|---------|
| 1. VCS                           |                |         |
| 2. Verdi                         |                |         |
| 3. Spyglass                      |                |         |
| 4. Synopsys Design Compiler      |                |         |
| 5. Synopsys Formality            |                |         |
| 6. Integrated Circuit Compiler 2 |                |         |
| 7. Library Manager               |                |         |
| 8. PrimeTime                     |                |         |
| 9. Library Compiler              |                |         |

---

## ⚙️ Technology Node
- SAED32 EDK


   


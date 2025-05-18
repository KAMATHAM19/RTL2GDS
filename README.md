# RTL2GDS

## 📑 Contents

### [FLAT DESIGN](#flat-design)
1. [Register Transfer Level (RTL)](#1-register-transfer-level-rtl)  
2. [Simulation using VCS and Verdi](#2-simulation-using-vcs-and-verdi)  
3. [Verification](#3-verification)  
   - [Coverage Analysis](#coverage-analysis)  
   - [SV Methodology](#sv-methodology)  
4. [Linting – Spyglass](#4-linting--spyglass)  
5. [Logic Synthesis](#5-logic-synthesis)  
   - [Inputs](#inputs)  
   - [Process](#process)  
   - [Scripts](#scripts)  
   - [Optimizations](#optimizations)  
   - [Outputs](#outputs)  
   - [Checks](#checks)  
6. [Formality Equivalence Checking](#6-formality-equivalence-checking)  
7. [Physical Design](#7-physical-design)  
8. [Import Design / Netlist](#8-import-design--netlist)  
9. [Floorplan](#9-floorplan)  
   - [Objective](#objective)  
   - [Inputs](#inputs-1)  
   - [Floorplanning Steps](#floorplanning-steps)  
   - [Script](#script)  
   - [Floorplan Optimizations](#floorplan-optimizations)  
   - [Outputs](#outputs-1)  
   - [Checks](#checks-1)  
10. [Powerplan](#10-powerplan)  
    - [Objective](#objective-1)  
    - [Inputs](#inputs-2)  
    - [Powerplanning Steps](#powerplanning-steps)  
    - [Script](#script-1)  
    - [Powerplan Optimizations](#powerplan-optimizations)  
    - [Outputs](#outputs-2)  
    - [Checks](#checks-2)  
11. [Placement](#11-placement)  
    - [Objective](#objective-2)  
    - [Inputs](#inputs-3)  
    - [Placement Steps](#placement-steps)  
    - [Script](#script-2)  
    - [Placement Optimizations](#placement-optimizations)  
    - [Outputs](#outputs-3)  
    - [Checks](#checks-3)  
12. [Clock Tree Synthesis](#12-clock-tree-synthesis)  
    - [Objective](#objective-3)  
    - [Inputs](#inputs-4)  
    - [CTS Steps](#cts-steps)  
    - [Script](#script-3)  
    - [CTS Optimizations](#cts-optimizations)  
    - [Outputs](#outputs-4)  
    - [Checks](#checks-4)  
13. [Routing](#13-routing)  
    - [Objective](#objective-4)  
    - [Inputs](#inputs-5)  
    - [Routing Steps](#routing-steps)  
    - [Script](#script-4)  
    - [Routing Optimizations](#routing-optimizations)  
    - [Outputs](#outputs-5)  
    - [Checks](#checks-5)  

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


   


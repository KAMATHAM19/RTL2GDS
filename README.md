# RTL2GDS

## Contents

### [Flat Design](Flat_Design/README.md#flat-design)

1. [Register Transfer Level (RTL)](Flat_Design/README.md#register-transfer-level-rtl)  
2. [Simulation using VCS and Verdi](Flat_Design/README.md#simulation-using-vcs-and-verdi)  
3. [Verification](Flat_Design/README.md#verification)  
   - [Coverage Analysis](Flat_Design/README.md#1-coverage-analysis)  
   - [SV Methodology](Flat_Design/README.md#2-sv-methodology)  
4. [Linting – Spyglass](Flat_Design/README.md#linting--spyglass)  
5. [Logic Synthesis](Flat_Design/README.md#logic-synthesis)  
   - [Inputs](Flat_Design/README.md#logic-synthesis-inputs)  
   - [Process](Flat_Design/README.md#logic-synthesis-process)  
   - [Scripts](Flat_Design/README.md#logic-synthesis-scripts-and-flow)  
   - [Optimizations](Flat_Design/README.md#optimizations)  
   - [Outputs](Flat_Design/README.md#outputs)  
   - [Checks](Flat_Design/README.md#checks-performed)  
6. [Formality Equivalence Checking](Flat_Design/README.md#formality-equivalence-checking)  
7. [Physical Design](Flat_Design/README.md#physical-design)  
8. [Import Design / Netlist](Flat_Design/README.md#1-import-design--netlist)  
9. [Floorplan](Flat_Design/README.md#floorplan)  
   - [Objective](Flat_Design/README.md#objective)  
   - [Inputs](Flat_Design/README.md#inputs)  
   - [Floorplanning Steps](Flat_Design/README.md#floorplanning-steps)  
   - [Script](Flat_Design/README.md#ports-placement)  
   - [Floorplan Optimizations](Flat_Design/README.md#floorplan-optimizations)  
   - [Outputs](Flat_Design/README.md#outputs-1)  
   - [Checks](Flat_Design/README.md#checks-1)  
10. [Powerplan](Flat_Design/README.md#power-plan)  
    - [Objective](Flat_Design/README.md#objectives)  
    - [Inputs](Flat_Design/README.md#inputs-1)  
    - [Powerplanning Steps](Flat_Design/README.md#process)  
    - [Script](Flat_Design/README.md#script)  
    - [Powerplan Optimizations](Flat_Design/README.md#powerplan-optimizations)  
    - [Outputs](Flat_Design/README.md#outputs-2)  
    - [Checks](Flat_Design/README.md#checks-2)  
11. [Placement](Flat_Design/README.md#placement)  
    - [Objective](Flat_Design/README.md#objectives-1)  
    - [Inputs](Flat_Design/README.md#inputs-2)  
    - [Placement Steps](Flat_Design/README.md#placement-process)  
    - [Script](Flat_Design/README.md#script-1)  
    - [Placement Optimizations](Flat_Design/README.md#optimizations-1)  
    - [Outputs](Flat_Design/README.md#outputs-3)  
    - [Checks](Flat_Design/README.md#checks-3)  
12. [Clock Tree Synthesis](Flat_Design/README.md#clock-tree-synthesis-cts)  
    - [Objective](Flat_Design/README.md#objectives-2)  
    - [Inputs](Flat_Design/README.md#inputs-3)  
    - [CTS Steps](Flat_Design/README.md#process-1)  
    - [Script](Flat_Design/README.md#script-2)  
    - [CTS Optimizations](Flat_Design/README.md#optimizations-2)  
    - [Outputs](Flat_Design/README.md#outputs-4)  
    - [Checks](Flat_Design/README.md#checks-4)  
13. [Routing](Flat_Design/README.md#routing)  
    - [Objective](Flat_Design/README.md#objectives-3)  
    - [Inputs](Flat_Design/README.md#inputs-4)  
    - [Routing Steps](Flat_Design/README.md#process-2)  
    - [Script](Flat_Design/README.md#script-3)  
    - [Routing Optimizations](Flat_Design/README.md#optimizations-3)  
    - [Outputs](Flat_Design/README.md#outputs-5)  
    - [Checks](Flat_Design/README.md#checks-5)  


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


   


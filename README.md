# RTL2GDS

## Contents

### [Flat Design](Flat_Design/README.md#flat-design)

1. [Register Transfer Level (RTL)](Flat_Design/README.md#register-transfer-level-rtl)  
2. [Simulation using VCS and Verdi](Flat_Design/README.md#simulation-using-vcs-and-verdi)  
3. [Verification](Flat_Design/README.md#verification)  
   - [Testbench](Flat_Design/README.md#testbench)  
   - [Coverage Analysis](Flat_Design/README.md#coverage-analysis)  
   - [SV Methodology](Flat_Design/README.md#sv-methodology)  
4. [Linting – Spyglass](Flat_Design/README.md#linting----spyglass)  
5. [Logic Synthesis](Flat_Design/README.md#logic-synthesis)  
   - [Inputs](Flat_Design/README.md#logic-synthesis-inputs)  
   - [Process](Flat_Design/README.md#logic-synthesis-process)  
   - [Scripts](Flat_Design/README.md#logic-synthesis-scripts-and-flow)  
   - [Optimizations](Flat_Design/README.md#logic-synthesis-optimizations)  
   - [Outputs](Flat_Design/README.md#logic-synthesis-outputs)  
   - [Checks](Flat_Design/README.md#logic-synthesis-checks)  
6. [Formality Equivalence Checking](Flat_Design/README.md#formality-equivalence-checking)  
7. [Physical Design](Flat_Design/README.md#physical-design)  
8. [Import Design / Netlist](Flat_Design/README.md#import-design--netlist)  
9. [Floorplan](Flat_Design/README.md#floorplan)  
   - [Objective](Flat_Design/README.md#floorplan-objective)  
   - [Inputs](Flat_Design/README.md#floorplan-inputs)  
   - [Steps](Flat_Design/README.md#floorplanning-steps)  
   - [Script](Flat_Design/README.md#floorplan-script)  
   - [Optimizations](Flat_Design/README.md#floorplan-optimizations)  
   - [Outputs](Flat_Design/README.md#floorplan-outputs)  
   - [Checks](Flat_Design/README.md#floorplan-checks)  
10. [Powerplan](Flat_Design/README.md#power-plan)  
    - [Objective](Flat_Design/README.md#powerplan-objective)  
    - [Inputs](Flat_Design/README.md#powerplan-inputs)  
    - [Steps](Flat_Design/README.md#powerplanning-steps)  
    - [Script](Flat_Design/README.md#powerplan-script)  
    - [Optimizations](Flat_Design/README.md#powerplan-optimizations)  
    - [Outputs](Flat_Design/README.md#powerplan-outputs)  
    - [Checks](Flat_Design/README.md#powerplan-checks)  
11. [Placement](Flat_Design/README.md#placement)  
    - [Objective](Flat_Design/README.md#placement-objective)  
    - [Inputs](Flat_Design/README.md#placement-inputs)  
    - [Steps](Flat_Design/README.md#placement-steps)  
    - [Script](Flat_Design/README.md#placement-script)  
    - [Optimizations](Flat_Design/README.md#placement-optimizations)  
    - [Outputs](Flat_Design/README.md#placement-outputs)  
    - [Checks](Flat_Design/README.md#placement-checks)  
12. [Clock Tree Synthesis (CTS)](Flat_Design/README.md#clock-tree-synthesis-cts)  
    - [Objective](Flat_Design/README.md#cts-objective)  
    - [Inputs](Flat_Design/README.md#cts-inputs)  
    - [Steps](Flat_Design/README.md#cts-steps)  
    - [Script](Flat_Design/README.md#cts-script)  
    - [Optimizations](Flat_Design/README.md#cts-optimizations)  
    - [Outputs](Flat_Design/README.md#cts-outputs)  
    - [Checks](Flat_Design/README.md#cts-checks)  
13. [Routing](Flat_Design/README.md#routing)  
    - [Objective](Flat_Design/README.md#routing-objective)  
    - [Inputs](Flat_Design/README.md#routing-inputs)  
    - [Steps](Flat_Design/README.md#routing-steps)  
    - [Script](Flat_Design/README.md#routing-script)  
    - [Optimizations](Flat_Design/README.md#routing-optimizations)  
    - [Outputs](Flat_Design/README.md#routing-outputs)  
    - [Checks](Flat_Design/README.md#routing-checks)



## Tools

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


   


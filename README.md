# RTL2GDS

## Contents
### [Flat Design](Flat_Design/README.md#flat-design)

1. [Register Transfer Level (RTL)](Flat_Design/README.md#register-transfer-level-rtl)  
2. [Simulation using VCS and Verdi](Flat_Design/README.md#simulation-using-vcs-and-verdi)  
   - [Testbench](Flat_Design/README.md#testbench)  
3. [Verification](Flat_Design/README.md#verification)  
   - [Coverage Analysis](Flat_Design/README.md#coverage-analysis)  
   - [SV Methodology](Flat_Design/README.md#sv-methodology)  
4. [Linting](Flat_Design/README.md#linting)  
5. [Logic Synthesis](Flat_Design/README.md#logic-synthesis)  
   - [Inputs](Flat_Design/README.md#logic-synthesis-inputs)  
   - [Process](Flat_Design/README.md#logic-synthesis-process)  
   - [Scripts](Flat_Design/README.md#logic-synthesis-scripts)  
   - [Optimizations](Flat_Design/README.md#logic-synthesis-optimizations)  
   - [Outputs](Flat_Design/README.md#logic-synthesis-outputs)  
   - [Checks](Flat_Design/README.md#logic-synthesis-checks)  
6. [Formality Equivalence Checking](Flat_Design/README.md#formality-equivalence-checking)  
7. [Physical Design](Flat_Design/README.md#physical-design)  
   - **i) [Import Design / Netlist](Flat_Design/README.md#import-design--netlist)**  
   - **ii) [Floorplan](Flat_Design/README.md#floorplan)**  
     - [Objectives](Flat_Design/README.md#objectives)  
     - [Inputs](Flat_Design/README.md#inputs)  
     - [Floorplanning Steps](Flat_Design/README.md#floorplanning-steps)  
     - [Script](Flat_Design/README.md#script)  
     - [Floorplan Optimizations](Flat_Design/README.md#floorplan-optimizations)  
     - [Outputs](Flat_Design/README.md#outputs)  
     - [Checks](Flat_Design/README.md#checks)  
   - **iii) [Powerplan](Flat_Design/README.md#powerplan)**  
     - [Objectives](Flat_Design/README.md#objectives)  
     - [Inputs](Flat_Design/README.md#inputs)  
     - [Powerplanning Steps](Flat_Design/README.md#powerplanning-steps)  
     - [Script](Flat_Design/README.md#script)  
     - [Powerplan Optimizations](Flat_Design/README.md#powerplan-optimizations)  
     - [Outputs](Flat_Design/README.md#outputs)  
     - [Checks](Flat_Design/README.md#checks)  
   - **iv) [Placement](Flat_Design/README.md#placement)**  
     - [Objectives](Flat_Design/README.md#objectives)  
     - [Inputs](Flat_Design/README.md#inputs)  
     - [Placement Steps](Flat_Design/README.md#placement-steps)  
     - [Script](Flat_Design/README.md#script)  
     - [Placement Optimizations](Flat_Design/README.md#placement-optimizations)  
     - [Outputs](Flat_Design/README.md#outputs)  
     - [Checks](Flat_Design/README.md#checks)  
   - **v) [Clock Tree Synthesis (CTS)](Flat_Design/README.md#clock-tree-synthesis-cts)**  
     - [Objectives](Flat_Design/README.md#objectives)  
     - [Inputs](Flat_Design/README.md#inputs)  
     - [CTS Steps](Flat_Design/README.md#cts-steps)  
     - [Script](Flat_Design/README.md#script)  
     - [CTS Optimizations](Flat_Design/README.md#cts-optimizations)  
     - [Outputs](Flat_Design/README.md#outputs)  
     - [Checks](Flat_Design/README.md#checks)  
   - **vi) [Routing](Flat_Design/README.md#routing)**  
     - [Objectives](Flat_Design/README.md#objectives)  
     - [Inputs](Flat_Design/README.md#inputs)  
     - [Routing Steps](Flat_Design/README.md#routing-steps)  
     - [Script](Flat_Design/README.md#script)  
     - [Routing Optimizations](Flat_Design/README.md#routing-optimizations)  
     - [Outputs](Flat_Design/README.md#outputs)  
     - [Checks](Flat_Design/README.md#checks)  

### [Hierarchical Design](Hierarchical_Design/README.md#hierarchical-design)
1. [RTL](Hierarchical_Design/README.md##1-rtl)  
2. [Simulation](Hierarchical_Design/README.md##2-simulation)  
3. [Verification](Hierarchical_Design/README.md##3-verification)  
4. [Linting](Hierarchical_Design/README.md##4-linting)  
5. [Generation of `.lib` of 4-bit FA](Hierarchical_Design/README.md##5-generation-of-lib-of-4bit-fa)  
6. [Generation of `.db` of 4-bit FA](Hierarchical_Design/README.md##6-generation-of-db-of-4bit-fa)  
7. [Synthesis](Hierarchical_Design/README.md##7-synthesis)  
8. [Formality Equivalence Checking](Hierarchical_Design/README.md##8-formality-equivalence-checking)  
9. [Physical Design](Hierarchical_Design/README.md##9-physical-design)  
   - [Floorplan](Hierarchical_Design/README.md##91-floorplan)  
   - [Powerplan](Hierarchical_Design/README.md##92-powerplan)  
   - [Placement](Hierarchical_Design/README.md##93-placement)  
   - [Clock Tree Synthesis](Hierarchical_Design/README.md##94-clock-tree-synthesis)  
   - [Routing](Hierarchical_Design/README.md##95-routing)  

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


## Technology Node
- SAED32 EDK


   


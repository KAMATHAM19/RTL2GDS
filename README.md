# RTL2GDS

## Contents

### [Flat Design](Flat_Design/README.md#flat-design)

1. [Register Transfer Level (RTL)](Flat_Design/README.md#register-transfer-level-rtl)  
2. [Simulation using VCS and Verdi](Flat_Design/README.md#simulation-using-vcs-and-verdi)  
   - [Testbench](Flat_Design/README.md#testbench)  
3. [Verification](Flat_Design/README.md#verification)  
   - [Coverage Analysis](Flat_Design/README.md#coverage-analysis)  
   - [System Verilog Methodology](Flat_Design/README.md#system-verilog-methodology)  
4. [Linting using Spyglass](Flat_Design/README.md#linting-using-spyglass)  
5. [Logic Synthesis using Design Compiler](Flat_Design/README.md#logic-synthesis-using-design-compiler)  
6. [Logical Equivalence Checking using Synopsys Formality](Flat_Design/README.md#logical-equivalence-checking-using-synopsys-formality)  
7. [Physical Design](Flat_Design/README.md#physical-design)  
   - **[Import Design](Flat_Design/README.md#import-design)**  
   - **[Floorplan](Flat_Design/README.md#floorplan)**  
   - **[Powerplan](Flat_Design/README.md#powerplan)**  
   - **[Placement](Flat_Design/README.md#placement)**  
   - **[Clock Tree Synthesis (CTS)](Flat_Design/README.md#clock-tree-synthesis-cts)**  
   - **[Routing](Flat_Design/README.md#routing)**  
 
---


### [Hierarchical Design](Hierarchical_Design/README.md#hierarchical-design)


1. [RTL](Hierarchical_Design/README.md#1-rtl)  
2. [Simulation](Hierarchical_Design/README.md#2-simulation)  
3. [Verification](Hierarchical_Design/README.md#3-verification)  
4. [Linting](Hierarchical_Design/README.md#4-linting)  
5. [Generation of `.lib` of 4-bit Full Adder](Hierarchical_Design/README.md#5-generation-of-lib-of-4-bit-full-adder)  
6. [Generation of `.db` of 4-bit Full Adder](Hierarchical_Design/README.md#6-generation-of-db-of-4-bit-full-adder)  
7. [Synthesis](Hierarchical_Design/README.md#7-synthesis)  
8. [Formality Equivalence Checking](Hierarchical_Design/README.md#8-formality-equivalence-checking)  
9. [Physical Design](Hierarchical_Design/README.md#9-physical-design)  
   - [Floorplan](Hierarchical_Design/README.md#91-floorplan)  
   - [Powerplan](Hierarchical_Design/README.md#92-powerplan)  
   - [Placement](Hierarchical_Design/README.md#93-placement)  
   - [Clock Tree Synthesis](Hierarchical_Design/README.md#94-clock-tree-synthesis)  
   - [Routing](Hierarchical_Design/README.md#95-routing)  



## Tools

| Tool                             | Purpose                           | Command                                            |
|----------------------------------|-----------------------------------|----------------------------------------------------|
| 1. VCS                           | Logic simulation                  | `vcs -full64 <design_files> -debug_access+all`     |
| 2. Verdi                         | Waveform viewing & debugging      | `verdi -ssf <dump.fsdb>` or `verdi &`              |
| 3. Spyglass                      | Linting and static RTL checks     | `spyglass`                                         |
| 4. Synopsys Design Compiler      | RTL synthesis                     | `dc_shell`  and `start_gui`                        |
| 5. Synopsys Formality            | Formal verification               | `fm_shell`  and `start_gui`                        |
| 6. Integrated Circuit Compiler 2 | Physical design (place nd route)  | `icc2_shell` and `start_gui`                       |
| 7. Library Manager               | Viewing and managing .frame/.lib  | `lm_shell` and `start_gui`                         |
| 8. PrimeTime                     | Static timing analysis (STA)      | `pt_shell`                                         |
| 9. Library Compiler              | Generating .db files from .lib    | `lc_shell`                                         |



## Technology Node
- SAED32 EDK


   


# RTL2GDS

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


   


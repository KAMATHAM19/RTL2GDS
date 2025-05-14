###################################################################

# Created by write_sdc on Wed May 14 22:40:49 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_max_transition 0.2 [current_design]
create_clock [get_ports Clock]  -period 1  -waveform {0 0.5}
set_clock_uncertainty -setup 0.3  [get_clocks Clock]
set_clock_uncertainty -hold 0.1  [get_clocks Clock]
set_max_transition 0.1 -clock_path [get_clocks Clock]
set_input_delay -clock Clock  -max 0.5  [get_ports Clock]
set_input_delay -clock Clock  -max 0.5  [get_ports {A[3]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {A[2]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {A[1]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {A[0]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {B[3]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {B[2]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {B[1]}]
set_input_delay -clock Clock  -max 0.5  [get_ports {B[0]}]
set_input_delay -clock Clock  -max 0.5  [get_ports C_in]
set_output_delay -clock Clock  -max 0.5  [get_ports {SUM[3]}]
set_output_delay -clock Clock  -max 0.5  [get_ports {SUM[2]}]
set_output_delay -clock Clock  -max 0.5  [get_ports {SUM[1]}]
set_output_delay -clock Clock  -max 0.5  [get_ports {SUM[0]}]
set_output_delay -clock Clock  -max 0.5  [get_ports C_out]
set_input_transition -max 0.5  [get_ports {A[3]}]
set_input_transition -min 0.5  [get_ports {A[3]}]
set_input_transition -max 0.5  [get_ports {A[2]}]
set_input_transition -min 0.5  [get_ports {A[2]}]
set_input_transition -max 0.5  [get_ports {A[1]}]
set_input_transition -min 0.5  [get_ports {A[1]}]
set_input_transition -max 0.5  [get_ports {A[0]}]
set_input_transition -min 0.5  [get_ports {A[0]}]
set_input_transition -max 0.5  [get_ports {B[3]}]
set_input_transition -min 0.5  [get_ports {B[3]}]
set_input_transition -max 0.5  [get_ports {B[2]}]
set_input_transition -min 0.5  [get_ports {B[2]}]
set_input_transition -max 0.5  [get_ports {B[1]}]
set_input_transition -min 0.5  [get_ports {B[1]}]
set_input_transition -max 0.5  [get_ports {B[0]}]
set_input_transition -min 0.5  [get_ports {B[0]}]
set_input_transition -max 0.5  [get_ports Clock]
set_input_transition -min 0.5  [get_ports Clock]
set_input_transition -max 0.5  [get_ports C_in]
set_input_transition -min 0.5  [get_ports C_in]

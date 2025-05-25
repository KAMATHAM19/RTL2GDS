# [RTL](#rtl)

```verilog
`include "full_adder.v"

module eight_bit_full_adder (
    input [7:0] A,
    input [7:0] B,
    input C_in,
    input Clock,
    output [7:0] SUM,
    output C_out
);

wire cout1,cout2;
wire [3:0] SUM1,SUM2;


// Instantiate two instances of the four_bit_adder module

full_adder u1 (
    .A(A[3:0]),
   .B(B[3:0]),
   .C_in(C_in),
   .Clock(Clock),
   .SUM(SUM1),
   .C_out(cout1)
);

full_adder u2 (
   .A(A[7:4]),
   .B(B[7:4]),
   .C_in(cout1),
   .Clock(Clock),
   .SUM(SUM2),
   .C_out(cout2)
);


assign SUM = {SUM2,SUM1};
assign C_out = cout2;

endmodule
```

# [Simulation](#simulation)

```verilog
`include "adder.v"
`include "full_adder.v"

module tb_eight_bit_adder;

    // Testbench signals
    reg [7:0] A, B;    // 8-bit input values A and B
    reg Clock, C_in;   // Clock and Carry-in inputs
    wire [7:0] SUM;    // 8-bit sum output
    wire C_out;        // Carry-out output

    // Instantiate the 8-bit adder
    eight_bit_adder uut (
        .A(A), .B(B), 
        .Clock(Clock), .C_in(C_in),
        .SUM(SUM), .C_out(C_out)
    );

    // Clock generation
    always begin
        #5 Clock = ~Clock; // Clock period 10 time units
    end
// Test sequence
    initial begin
        // Initialize signals
        Clock = 0;
        A = 8'b00000000;
        B = 8'b00000000;
        C_in = 0;

	$fsdbDumpfile("dump.fsdb");
	$fsdbDumpvars(0,tb_eight_bit_adder);
        // Display headers
        $display("Time | A       B       C_in | SUM     C_out");
        $display("------------------------------------------------");

        // Apply test vectors
        #10 A = 8'b00000001; B = 8'b00000001; C_in = 0; // 1 + 1
        #20 A = 8'b01010101; B = 8'b01010101; C_in = 0; // 85 + 85
        #20 A = 8'b11111111; B = 8'b00000001; C_in = 0; // 255 + 1
        #20 A = 8'b11001100; B = 8'b10101010; C_in = 1; // 204 + 170 + 1
        #20 A = 8'b10101010; B = 8'b01010101; C_in = 1; // 170 + 85 + 1
        
        // End simulation after some time
        #100 $finish;
    end

    // Monitor output changes
    initial begin
        $monitor("%4t | %b %b %b  | %b %b", $time, A, B, C_in, SUM, C_out);
    end

endmodule
```
```
vcs -sverilog adder_tb.v -full64 -lca -kdb -debug_accesss+all
```
<img width="958" alt="1" src="https://github.com/user-attachments/assets/dce70dc5-3e3d-4ace-a6e0-92a9e3448b60" />

```
./simv -verdi
```
<div align="center">
<img width="959" alt="2" src="https://github.com/user-attachments/assets/8e147b1c-39f1-4ee2-a28e-78786781a4c6" />
</div>
<div align="center">
<img width="358" alt="3" src="https://github.com/user-attachments/assets/e3feb67e-612a-43c5-be67-9ea701534d30" />
</div>
<div align="center">
<img width="617" alt="4" src="https://github.com/user-attachments/assets/6b931069-f3f5-4da3-8ca0-1571496e8bab" />
</div>
<div align="center">
<img width="694" alt="5" src="https://github.com/user-attachments/assets/d93ab962-ecc1-47fe-b590-257773206d5f" />
</div>
<div align="center">
<img width="959" alt="6" src="https://github.com/user-attachments/assets/462dba68-bf28-4729-aff2-3b9b7d45a8c7" />
</div>

# [Verification](#verification)

# [Linting](#linting)

<div align="center">
<img width="959" alt="8" src="https://github.com/user-attachments/assets/bff73d0b-a0b3-4c10-b14b-b5bf4f87cdad" />
</div>

# [Generation of .lib of 4bit Full Adder](#generation-of-lib-of-4bit-full-adder)

```
pt_shell
set link_path /data/pdk/pdk32nm/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_tt0p78vn40c.db
read_verilog ./../ICC2/data/full_adder_routed_netlist.v
link_design
current_design
read_sdc ./../Constraints/full_adder.sdc
read_parasitics ./../ICC2/data/full_adder_func_slow.spef.p1_125.spef
report_timing
extract_model -output final_full_adder -format lib
```
<img width="766" alt="9" src="https://github.com/user-attachments/assets/deee8fd2-2be3-44be-bf34-36fb76fb5f6d" />

# [Generation of .db of 4bit Full Adder](#generation-of-db-of-4bit-full-adder)

```
lc_shell

read_lib ./../PT/final_full_adder.lib
write_lib final_full_adder -output final_full_adder.db -format db

```
<div align="center">
<img width="958" alt="10" src="https://github.com/user-attachments/assets/d1471411-2f4c-4b19-bc07-24fb85ad593f" />
</div>

# [Synthesis](#synthesis)

```
1. common_setup.tcl

set DESIGN_NAME                   "eight_bit_full_adder"  ;#  The name of the top-level design

set PDK_PATH                        "/data/pdk/pdk32nm/SAED32_EDK/"

set ADDITIONAL_SEARCH_PATH        "$PDK_PATH $PDK_PATH/tech/milkyway $PDK_PATH/tech/star_rcxt"

set TARGET_LIBRARY_FILES          "$PDK_PATH/lib/stdcell_rvt/db_ccs/saed32rvt_tt0p78vn40c.db"


set TECH_FILE                     "$PDK_PATH/tech/milkyway/saed32nm_1p9m_mw.tf"  ;

set MAP_FILE                      "saed32nm_tf_itf_tluplus.map"  ;#  Mapping file for TLUplus
set TLUPLUS_MAX_FILE              "saed32nm_1p9m_Cmax.tluplus"  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE              "saed32nm_1p9m_Cmin.tluplus"  ;#  Min TLUplus file

set MIN_ROUTING_LAYER            "M1"   ;# Min routing layer
set MAX_ROUTING_LAYER            "M5"   ;# Max routing layer

# for hierarchy design
set ADDITIONAL_LINK_LIB_FILES     "./../lc/final_full_adder.db"  ;#  Extra link logical libraries not included in TARGET_LIBRARY_FILES

2. dc_setup.tcl

source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl

set_host_options -max_cores 4
set_app_var hdlin_enable_upf_compatible_naming true

3. run_dc.tcl

#Sets the path to the technology library (32nm SAED)
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/

#Sets the variable RTL_SOURCE_FILES to point to your RTL design
set RTL_SOURCE_FILES ./../rtl/eight_bit_adder.v

#Sources the setup script (initializes variables, libraries, and paths)
source -echo -verbose ./rm_setup/dc_setup.tcl

#Defines a design library (WORK) to store intermediate synthesis results
define_design_lib WORK -path ./WORK

#Allows hierarchical design mapping, useful for handling complex designs
set_app_var hdlin_enable_hier_map true

#Parses the RTL code to check for syntax errors
analyze -format verilog ${RTL_SOURCE_FILES}
```
<div align="center">
<img width="718" alt="11" src="https://github.com/user-attachments/assets/e3531ab7-bd2d-47db-a1a7-2d806f62a230" />
</div>

```
#Elaborates the design, resolving the HDL structure into a design database
elaborate ${DESIGN_NAME}
```
<div align="center">
<img width="584" alt="12" src="https://github.com/user-attachments/assets/a5dd56ad-4ad8-4148-add2-88661acdc95e" />
</div>
<div align="center">
<img width="959" alt="13" src="https://github.com/user-attachments/assets/e4f801ba-d90d-41a8-93c6-fe91d2589aae" />
</div>
<div align="center">
<img width="758" alt="14" src="https://github.com/user-attachments/assets/5ee8b94b-ac88-4122-9832-6a00b7199d01" />
</div>

```
report_cell
```
<div align="center">
<img width="623" alt="18" src="https://github.com/user-attachments/assets/febe3432-2626-4589-ba46-ec20846aa0b5" />
</div>

```
#Sets the current working design to the top-level module
current_design

#Sets the top-level design for verification
set_verification_top

#Loads timing constraints from a Synopsys Design Constraints (SDC) file
read_sdc -echo ./../Constraints/full_adder.sdc
```

|   **Setup**   |   **Hold**    |
|---------------|---------------|
| <p align="center"><img width="307" alt="Setup" src="https://github.com/user-attachments/assets/487827a8-ba63-4572-8721-bc5c66419789" /></p> | <p align="center"><img width="305" alt="Hold" src="https://github.com/user-attachments/assets/069edf29-8ff3-4973-8365-34826fec60a4" /></p> |



```
#Synthesizes the RTL into a gate-level netlist based on the target library
compile_ultra
```
<div align="center">
<img width="536" alt="17" src="https://github.com/user-attachments/assets/f2a8f156-37d6-47a6-99fb-a4385a8844eb" />
</div>

```
###### Generate reports #######
report_area -hierarchy > ./reports/area.rpt
report_power -hierarchy > ./reports/power.rpt
report_timing  > ./reports/timing.rpt

### To write results ###
write -format verilog -hierarchy -output ${RESULTS_DIR}/${DCRM_FINAL_VERILOG_OUTPUT_FILE}
write_sdc ./${RESULTS_DIR}/${DCRM_FINAL_SDC_OUTPUT_FILE}
```
# [Logical Equivalence Checking](#logical-equivalence-checking)
# [Physical Design](#physical-design)
# [Floorplan](#floorplan)

```
start_gui
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/
create_lib -ref_libs "$PDK_PATH/lib/stdcell_rvt/ndm/saed32rvt_c.ndm  ./final/lib.ndm" final
read_verilog {./../DC/results/eight_bit_full_adder.mapped.v} -library final -design eight_bit_full_adder -top eight_bit_full_adder
link_block
```
<img width="947" alt="19" src="https://github.com/user-attachments/assets/a66aa38e-4c76-4fb1-91dc-0223020b1948" />

<div align="center">
<img width="336" alt="20" src="https://github.com/user-attachments/assets/d6652641-1e0e-4033-9e7e-97c6260c4cd9" />
</div>

```
current_design
read_tech_lef ./data/final_full_adder.lef

check_netlist
check_design -checks dp_pre_floorplan
check_design -checks {dp_pre_floorplan}
​​​check_design -checks dp_pre_create_placement_abstract
​​​check_design -checks dp_pre_block_shaping
​​​check_design -checks dp_pre_macro_placement
​​​check_design -checks dp_pre_power_insertion
​​​check_design -checks dp_pre_pin_placement
​​​check_design -checks dp_pre_create_timing_abstract
​​​check_design -checks dp_pre_timing_estimation
​​​check_design -checks dp_pre_budgeting
​​check_design -checks dp_floorplan_rules

initialize_floorplan -core_offset 3 -side_length {45 60}
```
<div align="center">
<img width="401" alt="4 1" src="https://github.com/user-attachments/assets/a344bb43-b0ad-4932-be63-8a0b6d8648dd" />
</div>

```
set_attribute -objects [get_cells u1] -name origin -value {8 8}
set_attribute -objects [get_cells u2] -name origin -value {8 32}
set_attribute -objects [get_cells "u1 u2"] -name physical_status -value placed
```
| <p align="center"><img width="254" alt="4" src="https://github.com/user-attachments/assets/5a344f07-4ebb-4a6e-b76b-899bbba26faf" /></p> | <p align="center"><img width="488" alt="5" src="https://github.com/user-attachments/assets/0aa0837e-4858-41fe-aa14-51004aa41500" /></p> |
|:--:|:--:|

```
place_pins -self
```
<div align="center">
<img width="254" alt="6" src="https://github.com/user-attachments/assets/3d30f799-f3f2-4a78-a1fc-e0e27cf5fb53" />
</div>

```
create_keepout_margin u1 -outer {1 1 1 1} -type hard
create_keepout_margin u2 -outer {1 1 1 1} -type hard
```

| <p align="center"><img width="259" alt="7" src="https://github.com/user-attachments/assets/d6e01b69-1d54-48e2-a556-a9972a304146" /></p> | <p align="center"><img width="282" alt="8" src="https://github.com/user-attachments/assets/83aedae4-6ab2-406f-8629-e04d10efe271" /></p> |
|:--:|:--:|

```
check_pin_placement
check_legality
```
# [Powerplan](#powerplan)

```
remove_pg_strategies -all
remove_pg_patterns -all
remove_pg_regions -all
remove_pg_via_master_rules -all
remove_pg_strategy_via_rules -all
remove_routes -net_types {power ground} -ring -stripe -lib_cell_pin_connect

create_port -direction in VDD
create_port -direction in VSS
create_net -power VDD
create_net -ground VSS 
connect_pg_net -automatic -design eight_bit_full_adder -pg -all_blocks
```
<img width="626" alt="5" src="https://github.com/user-attachments/assets/1a44cfc7-1794-416b-9154-ecff78be4025" />

```
create_pg_region pg_0 -block u1
create_pg_region pg_1 -block u2
create_pg_region C1 -core -exclude_regions "pg_0 pg_1"
```
<div align="center">
<img width="260" alt="9" src="https://github.com/user-attachments/assets/ec9fa7dc-71c1-4338-b6b1-94e7272bf4c3" />
</div>

```
create_shape -shape_type rect -layer M7 -boundary {{0.000 13.091} {2.766 13.427}} -port VDD
create_shape -shape_type rect -layer M7 -boundary {{0.000 12.558} {1.679 12.874}} -port VSS
```
| <p align="center"><img width="260" alt="10" src="https://github.com/user-attachments/assets/ae77e2a0-d536-45a3-8805-0598ebee6cda" /></p> | <p align="center"><img width="230" alt="11" src="https://github.com/user-attachments/assets/b7af3c19-861f-400b-bce4-73fbfb379557" /></p> |
|:--:|:--:|

```
create_pg_ring_pattern core_ring_pattern -horizontal_layer M9 -horizontal_width 0.7 -horizontal_spacing 0.4 -vertical_layer M8 -vertical_width 0.6 -vertical_spacing 0.4
set_pg_strategy core_power_ring -core -pattern {{name:core_ring_pattern} {nets:{VDD VSS}} {offset: {0.45 0.45}}}
compile_pg -strategies core_power_ring
```
| <p align="center"><img width="257" alt="12" src="https://github.com/user-attachments/assets/25e50cc8-8848-49bf-8346-01fa671f5366" /></p> | <p align="center"><img width="416" alt="13" src="https://github.com/user-attachments/assets/f902a5b0-219b-48a4-83f3-d5585a3042ef" /></p> |
|:--:|:--:|

```
create_pg_mesh_pattern mesh -layers {{{vertical_layer: M6} {width: 0.34} {spacing: interleaving} {pitch: 1.3} {offset: 0.45}} {{horizontal_layer: M7} {width: 0.38} {spacing: interleaving} {pitch: 1} {offset: 0.45}}}
set_pg_strategy core_mesh -pattern {{name:mesh} {nets:VDD VSS}} -pg_regions C1 -extension {{{side: 234} {direction: T R B}{stop: innermost_ring}}}
compile_pg -strategies core_mesh
```
<div align="center">
<img width="256" alt="14" src="https://github.com/user-attachments/assets/13e0c200-dd0e-4483-aaf3-4e599a2046e7" />
</div>

```
create_pg_std_cell_conn_pattern std_cell_rail -layers M1 -rail_width 0.5
set_pg_strategy rail_strategy -pg_regions C1 -pattern {{name: std_cell_rail} {nets: VDD VSS}}
compile_pg -strategies rail_strategy
```
<div align="center">
<img width="259" alt="15" src="https://github.com/user-attachments/assets/a3ea8b1a-33bb-4675-bba8-2607dea39c9d" />
</div>

```
check_pg_drc
check_pg_missing_vias
check_pg_connectivity
```
| <p align="center"><img width="304" alt="17" src="https://github.com/user-attachments/assets/d4dfade8-a4db-48b3-998c-f5626e560e46" /></p> | <p align="center"><img width="444" alt="18" src="https://github.com/user-attachments/assets/ec5ab85f-6fb6-4f57-ae46-6ba40828a88a" /></p> | <p align="center"><img width="416" alt="16" src="https://github.com/user-attachments/assets/e425451a-133f-409d-b1eb-21993c747f8a" /></p> |
|:--:|:--:|:--:|


# [placement](#placement)

```
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/
set Constraints ./../Constraints/full_adder.sdc
check_hier_design -stage pre_placement

set_app_options -name place.coarse.continue_on_missing_scandef -value true
set_app_options -name place_opt.flow.enable_ccd -value true
set_app_options -name place_opt.flow.clock_aware_placement -value true
set_app_options -name place_opt.place.congestion_effort -value high

#worst-case analysis
set mode1 "func"
set corner1 "slow"
set scenario1 "${mode1}_${corner1}"

create_mode $mode1
create_corner $corner1
create_scenario -name $scenario1 -mode $mode1 -corner $corner1

report_scenarios
set parasitic1 "p1"
set tluplus_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic1
place_opt
```
<img width="587" alt="16" src="https://github.com/user-attachments/assets/2af653b5-39dc-46fa-ba70-b839924cb8e4" />

<img width="473" alt="15" src="https://github.com/user-attachments/assets/ea77e37a-557b-4ffb-86cd-26e194fddb76" />

# [Clock Tree Synthesis](#clock-tree-synthesis)

```
check_hier_design -stage pre_placement 
set_clock_routing_rules -clocks Clock -min_routing_layer M3 -max_routing_layer M4 -default_rule
synthesize_clock_trees
```
<div align="center">
<img width="257" alt="23" src="https://github.com/user-attachments/assets/27c38e10-0cda-4062-8c6b-26afe1b6b15d" />
</div>

```
balanced the skew set app options
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value true

set_clock_tree_options -target_latency 0.3 -target_skew 0.02 -corner $corner1/slow
get_corners
clock_opt
```
<div align="center">
<img width="260" alt="24" src="https://github.com/user-attachments/assets/9e712906-dfbc-42c3-bb0d-f5c9fd9b3dcd" />
</div>

# [Routing](#routing)

```
check_design -checks pre_route_stage

set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value true
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true
et_app_options -name route.detail.timing_driven -value true
set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {ANTENNA ANTENNA2}

set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA_HVT}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA_RVT}

route_global
route_track
```
<div align="center">
<img width="226" alt="27" src="https://github.com/user-attachments/assets/c8030063-44f4-4718-a8e1-e4707be1ee40" />
</div>

```
route_detail
route_opt
```
<div align="center">
<img width="260" alt="24" src="https://github.com/user-attachments/assets/3c52a640-68f3-44a0-9506-6398d77d081b" />
</div>

```
write_verilog ./data/eight_full_adder_routed_netlist.v
write_parasitics -format spef -output ./data/eight_full_adder_func_slow.spef
write_gds -design eight_bit_full_adder   ./data/eight_full_adder_adder.gds
write_def -design eight_bit_full_adder  ./data/eight_full_adder_routing.def
create_frame ./data/eight_full_adder.frame
write_lef -design eight_bit_full_adder ./data/eight_full_adder.lef

check_lvs
check_routes
check_routability
report_design -all
```









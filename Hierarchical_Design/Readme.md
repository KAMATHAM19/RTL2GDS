# RTL

# Simulation

# Verification
   1. Coverage Analysis - Code Coverage
  
   
      
   

# Linting

1. Generate .lib of 4bit FA from primetime

pt_shell
set link_path /data/pdk/pdk32nm/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_tt0p78vn40c.db
read_verilog ./../ICC2/data/final_full_adder_routed_netlist.v
link_design
current_design
read_sdc ./../Constraints/full_adder.sdc
read_parasitics ./../ICC2/data/full_adder_func_slow.spef.p1_125.spef
report_timing
extract_model -output final_full_adder -format lib

2. Generate .db file for 4bit FA

lc_shell

read_lib ./../PT/final_full_adder.lib
write_lib final_full_adder -output final_full_adder.db -format db

3. DC - Synthesis

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


#ffor hierarcy design
set ADDITIONAL_LINK_LIB_FILES     "./../lc/final_full_adder.db"  ;#  Extra link logical libraries not included in TARGET_LIBRARY_FILES

#adiitional
set TARGET_LIBRARY_FILES          "$PDK_PATH/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p75v125c.db 
                                   $PDK_PATH/lib/stdcell_hvt/db_ccs/saed32hvt_ss0p75v125c.db 
								   $PDK_PATH/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p75v125c.db" 

2. dc_setup.tcl

source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl

set_host_options -max_cores 4

set_app_var hdlin_enable_upf_compatible_naming true

set mw_reference_library ${MW_REFERENCE_LIB_DIRS}
set mw_design_library ${DCRM_MW_LIBRARY_NAME}
set mw_site_name_mapping { {CORE unit} {Core unit} {core unit} }


set_app_var target_library ${TARGET_LIBRARY_FILES}
set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"

3. run_dc.tcl#Sets the path to the technology library (32nm SAED)
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

#Elaborates the design, resolving the HDL structure into a design database
elaborate ${DESIGN_NAME}

#Sets the current working design to the top-level module
current_design

#Sets the top-level design for verification
set_verification_top

#Loads timing constraints from a Synopsys Design Constraints (SDC) file
read_sdc -echo ./../Constraints/full_adder.sdc

#Synthesizes the RTL into a gate-level netlist based on the target library
#compile

compile_ultra

#report_timing

###### Generate reports #######
report_area -hierarchy > ./reports/area.rpt
report_power -hierarchy > ./reports/power.rpt
report_timing  > ./reports/timing.rpt

### To write results ###
write -format verilog -hierarchy -output ${RESULTS_DIR}/${DCRM_FINAL_VERILOG_OUTPUT_FILE}

write_sdc ./${RESULTS_DIR}/${DCRM_FINAL_SDC_OUTPUT_FILE}


2. PNR

icc2_shell

1. floorplan
start_gui
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/
create_lib -ref_libs "$PDK_PATH/lib/stdcell_rvt/ndm/saed32rvt_c.ndm  ./final/lib.ndm" final8bit
read_verilog {./../DC/results/eight_bit_full_adder.mapped.v} -library final8bit -design eight_bit_full_adder -top eight_bit_full_adder
link_block
get_designs
current_design
list_blocks
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

​​​check_design -checks dp_floorplan_rules



initialize_floorplan -core_offset 3 -side_ration {45 45} 
get_cells
report_cell
report_design

set_attribute -objects [get_cells u1] -name origin -value {8 8}
set_attribute -objects [get_cells u2] -name origin -value {8 32}
set_attribute -objects [get_cells "u1 u2"] -name physical_status -value placed

set_fixed_objects [get_cells -filter "is_soft_macro"]
get_attribute [get_cells *] is_fixed


create_keepout_margin u1 -outer {1 1 1 1} -type hard
create_keepout_margin u2 -outer {1 1 1 1} -type hard

get_attribute [get_ports *] physicl_status fixed
get_attribute [get_ports *] is_fixed
set_fixed_objects [get_ports *] -unfix

set_individual_pin_constraints -sides 2  -ports [get_ports "Clock C_in"] -pin_spacing 5
place_pins -ports {Clock C_in}
set_individual_pin_constraints -sides 1  -ports [remove_from_collection [all_inputs] "Clock C_in"] -pin_spacing 5
place_pins -ports [all_inputs]
set_individual_pin_constraints -sides {3} -ports [all_outputs] -pin_spacing 5
place_pins -ports [all_outputs]


check_pin_placement
check_legality 

2. powerplan

remove_pg_strategies -all
remove_pg_patterns -all
remove_pg_regions -all
remove_pg_via_master_rules -all
remove_pg_strategy_via_rules -all
remove_routes -net_types {power ground} -ring -stripe -lib_cell_pin_connect

#To enable the compile_pg, create_pg_strap and create_pg_vias commands to validate the DRC correctness of power straps and vias with respect to signal routes
set_app_options -name plan.pgroute.honor_signal_route_drc -value true

#command merges overlapping shapes for via connection. By default, the tool does not merge the overlapping shapes
set_app_options -name plan.pgroute.merge_shapes_for_via_creation -value true  

create_pg_region pg_0 -block u1
create_pg_region pg_1 -block u2
create_pg_region C1 -core -exclude_regions "pg_0 pg_1"


#create_pg_region C1 -core -exclude_macros "u1 u2" for hard macros
remove_pg_regions region1
report_pg_regions

create_port -direction in VDD
create_port -direction in VSS
create_net -power VDD
create_net -ground VSS 

connect_pg_net -automatic -design eight_bit_full_adder -pg -all_blocks

report_timing
get_ports *
all_inputs

create_shape -shape_type rect -layer M7 -boundary {{0.000 12.499} {1.988 12.928}} -port VDD
create_shape -shape_type rect -layer M7 -boundary {{0.000 14.112} {0.992 14.535}} -port VSS

create_pg_ring_pattern core_ring_pattern -horizontal_layer M9 -horizontal_width 0.5 -horizontal_spacing 0.5 -vertical_layer M8 -vertical_width 0.5 -vertical_spacing 0.5
set_pg_strategy core_power_ring -core -pattern {{name:core_ring_pattern} {nets:{VDD VSS}} {offset: {1 1}}}
compile_pg -strategies core_power_ring

create_pg_mesh_pattern mesh -layers {{{vertical_layer: M6} {width: 0.5} {spacing: interleaving} {pitch: 2} {offset: 1}} {{horizontal_layer: M7} {width: 0.5} {spacing: interleaving} {pitch: 2} {offset: 1}}}

set_pg_strategy core_mesh  -pg_regions C1 -pattern { {pattern:mesh} {nets: VDD VSS}} -extension {{{side: 234} {direction: T B R}{stop: innermost_ring}}}

compile_pg -strategies core_mesh

create_pg_std_cell_conn_pattern std_cell_rail -layers M1 -rail_width 0.19
set_pg_strategy rail_strategy -pg_regions C1 -pattern {{name: std_cell_rail} {nets: VDD VSS}}
compile_pg -strategies rail_strategy

create_pg_std_cell_conn_pattern std_cell_rail -layers M1 -rail_width 0.19
set_pg_strategy rail_strategy -core -pattern {{name: std_cell_rail} {nets: VDD VSS}}
compile_pg -strategies rail_strategy

get_shapes -of_objects [get_layers M7]
remove_shapes RECT_23_*



change_selection [get_shapes PATH_11*]
gui_add_missing_vias -min_layer M1 -max_layer M8

remove_shapes PATH_11_*

/ve/po_home/b22o_venkat_621/RTL2GDS/flat/ICC2/FA_LIB1/full_adder_route/frame.ndm


placement

set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/
set Constraints ./../Constraints/full_adder.sdc

check_hier_design -stage pre_placement 

set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK
read_sdc ./../Constraints/full_adder.sdc
set_app_options -name place.coarse.continue_on_missing_scandef -value true
set_app_options -name place_opt.flow.enable_ccd -value true
set_app_options -name place_opt.flow.clock_aware_placement -value true
set_app_options -name place_opt.place.congestion_effort -value high

set mode1 "func"
set corner1 "slow"
set scenario1 "${mode1}_${corner1}"
create_mode $mode1
create_corner $corner1
create_scenario -name $scenario1 -mode $mode1 -corner $corner1

set parasitics "p1"
read_parasitic_tech -tlup "/data/pdk/pdk32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus" -layermap "/data/pdk/pdk32nm/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map" -name p1
source $Constraints

set_early_data_check_policy -policy strict
set_early_data_check_policy -checks hier.block.missing_frame_view -policy tolerate
create_placement -effort high
set_app_options -name top_level.continue_flow_on_check_hier_design_errors -value true


set_parasitic_parameters -late_spec $parasitics -early_spec $parasitics
set_dont_use [get_lib_cells /*FADD*]
set_dont_use [get_lib_cells /*HADD*]
set_dont_use [get_lib_cells /*NAND*]
set_dont_use [get_lib_cells /*OR*]
set_scenario_status func_slow -hold true -setup true -leakage_power true -max_capacitance true -min_capacitance true -dynamic_power true -max_transition true -active true

place_opt


get_design_checks

check_design -checks pre_clock_tree_stage

set_clock_routing_rules -default_rule -clocks Clock

synthesize_clock_trees
report_cell
get_cells "reg* c_in* C_out* SUM*"
change_selection [get_cells " " ]

balanced the skew set app options
set_app_options -name cts.compile.enable_local_skew -value true

set_app_options -name cts.optimize.enable_local_skew -value true

set_app_options -name cts.compile.enable_global_route -value true

set_clock_tree_options -target_latency 0.3 -target_skew 0.02 -corner $corner1/slow
get_corners

clock_opt



check_design -checks pre_route_stage

set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value true
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true

set_app_options -name route.detail.timing_driven -value true

set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {ANTENNA ANTENNA2}

set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA_HVT}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value  {*/ANTENNA_RVT}

route_global
route_track
route_detail
route_opt

write_verilog ./results/full_adder_routed.v
write_parasitics -format spef -output ./results/full_adder_func_slow.spef

save_lib
report_timing

check_lvs
check_routes
check_routability


report_design -all






create_lib -ref_libs "$PDK_PATH/lib/stdcell_rvt/ndm/saed32rvt_c.ndm ./FA_LIB1/lib.ndm ./frame.ndm" EIGHT_BIT_FULL_ADDER_LIB3
tech/milkyway/saed32nm_1p9m_mw.tf


create_shape -shape_type rect -layer M7 -boundary {{0.000 4.341} {4.003 4.924}} -port VDD
create_shape -shape_type rect -layer M7 -boundary {{0.000 12.312} {2.205 12.590}} -port VSS


create_pg_ring_pattern core_ring_pattern -horizontal_layer M9 -horizontal_width 0.4 -horizontal_spacing 0.7 -vertical_layer M8 -vertical_width 0.4 -vertical_spacing 0.7
set_pg_strategy core_power_ring -core -pattern {{name:core_ring_pattern} {nets:{VDD VSS}} {offset: {1.5 1.5}}}
compile_pg -strategies core_power_ring

create_pg_mesh_pattern mesh -layers {{{vertical_layer: M6} {width: 0.4} {spacing: interleaving} {pitch: 2} {offset: 1}} {{horizontal_layer: M7} {width: 0.4} {spacing: interleaving} {pitch: 2} {offset: 1}}}

set_pg_strategy core_mesh -pattern {{name: mesh} {nets: VDD VSS}} -core -pattern { {pattern:mesh} {nets: VDD VSS}} -extension {stop:innermost_ring}

compile_pg -strategies core_mesh

create_pg_std_cell_conn_pattern std_cell_rail -layers M1 -rail_width 0.25

set_pg_strategy rail_strategy -core -pattern {{name: std_cell_rail} {nets: VDD VSS}}

compile_pg -strategies rail_strategy



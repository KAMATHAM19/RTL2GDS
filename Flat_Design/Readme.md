# Register Transfer Level (RTL)

`Register Transfer Level` - RTL is a design abstraction in digital circuit design that explains how data flows between registers and the combinational logic that processes it.

```
always @(posedge clk) begin
  if (enable)
    out_reg <= in_data + 1;
end

in_data + 1 is the combinational logic part.
out_reg <= is the register transfer.
The data transfer happens on the rising edge of the clock (clk).
```
## Four-Bit Full Adder

```
/*four_bit_full_Adder_module */

module full_adder (
input [3:0] A, B,
input Clock, C_in,
output reg [3:0] SUM,
output reg C_out 
); 

reg [3:0] reg1, reg2, sum_i;
reg c_in, c_out;

always @ (posedge Clock)
        begin
                reg1 <= A;
                reg2 <= B;
                c_in <= C_in;
        end

always @ (posedge Clock)
        begin
                SUM <= sum_i;
                C_out <= c_out;
        end

always @ *
        begin
                {c_out, sum_i} = reg1 + reg2 + c_in;
        end

endmodule

```

### Testbench

```
module testbench;
    
    reg [3:0] A, B;
    reg Clock, C_in;
    wire [3:0] SUM;
    wire C_out;

    full_adder dut (
        .A(A),
        .B(B),
        .Clock(Clock),
        .C_in(C_in),
        .SUM(SUM),
        .C_out(C_out)
    );

    always #5 Clock = ~Clock;

    initial begin
	$fsdbDumpfile("testbench.fsdb");
        $fsdbDumpvars(0,testbench);
        A <= 0;
        B <= 0;
        C_in <= 0;
        Clock <= 0;

        #20 A <= 4'b0001; B <= 4'b0001; C_in <= 0; // 1 + 1 = 2 (binary: 10)
$display("A = %b, B = %b, C_in = %b, SUM = %b, C_out = %b", A, B, C_in, SUM, C_out);

        #20 A <= 4'b0110; B <= 4'b1010; C_in <= 1; // 6 + 10 + 1 = 17 (binary: 10001)
$display("A = %b, B = %b, C_in = %b, SUM = %b, C_out = %b", A, B, C_in, SUM, C_out);

        #20 A <= 4'b1000; B <= 4'b1111; C_in <= 1; // 8 + 15 + 1 = 24 (binary: 11000)
$display("A = %b, B = %b, C_in = %b, SUM = %b, C_out = %b", A, B, C_in, SUM, C_out);

#100 $finish;
    end

endmodule

```


# Simulation

VCS 

```
vcs -sverilog full_adder.v full_adder_tb.sv -full64 -lca -kdb -debug_access+all 

```

-sverilog switch
-full64  64bit Architecture
-lca     internal switches to vcs
-kdb     kernel debugger
-debug_access+all  debug all the execution process



<img width="959" alt="1" src="https://github.com/user-attachments/assets/18c5974a-182a-483e-a0eb-93bdfd004d0d" />


To run the design

```
./simv

```


<img width="953" alt="2" src="https://github.com/user-attachments/assets/75f5d21a-8e62-4de4-b8bd-894bd578f036" />

Schematic View of Design


<img width="943" alt="fa sch" src="https://github.com/user-attachments/assets/ea96937e-1af5-4864-b6cc-846ad414eb6b" />

<img width="959" alt="fa sch1" src="https://github.com/user-attachments/assets/90c992c8-8bfc-4a6e-9578-94db549edd2a" />


Veridi - Waveform debug

<img width="959" alt="verdi" src="https://github.com/user-attachments/assets/a1c04dc2-ec00-4075-a4d3-bc635d89edce" />




# Verification
   1. Coverage Analysis 
   2. System Verilog Methodology

1. Coverage Analysis - The generic term for measuring progress in completing design verification

   Code coverage – how much of the HDL code has been exercised

   Functional coverage – how well the design's intended behaviour has been tested

   Assertion coverage – how many assertions have been triggered or checked

Code Coverage

1. Coverpoint - the number of specific points we check or monitor in the testbench or stimulus.
2. Covergroups – collections of coverpoints grouped to track and measure coverage in one place.
3. Bins – specific stimulus cases or input scenarios defined to track how often they occur during simulation.
4. Ignore bins – specific coverage points that are intentionally excluded from coverage tracking by marking them as ignore bins.
5. Cross coverage – defined between coverpoints or variables to measure combinations of their values during simulation.


1st sample covering all possible combinations
```
/*four_bit_full_Adder_module full_adder (A,B,C_in,Clock,SUM,C_out)*/
module full_adder (
input [3:0] A, B,
input Clock, C_in,
output reg [3:0] SUM,
output reg C_out 
); 

reg [3:0] reg1, reg2, sum_i;
reg c_in, c_out;

always @ (posedge Clock)
        begin
                reg1 <= A;
                reg2 <= B;
                c_in <= C_in;
        end

always @ (posedge Clock)
        begin
                SUM <= sum_i;
                C_out <= c_out;
        end

always @ *
        begin
                {c_out, sum_i} = reg1 + reg2 + c_in;
        end
// Coverage Group: Track all possible combinations of inputs and outputs
	covergroup cg_full_adder;

        // Coverpoint for the input 'A'
        coverpoint A { bins A_values = {4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111}; }

	// Coverpoint for the input 'B'
        coverpoint B { bins B_values = {4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111}; }

	// Coverpoint for the input 'Cin'
	coverpoint C_in { bins C_in_values = {1'b0, 1'b1}; }

	// Coverpoint for the sum output
	coverpoint SUM { bins SUM_values = {4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111}; }

	// Coverpoint for the carry output
	coverpoint C_out { bins C_out_values = {1'b0, 1'b1}; }
        endgroup

	// Instantiate the coverage group
         cg_full_adder cg_inst = new();

	//coverage
     always @ (A | B | C_in | SUM | C_out)
     cg_inst.sample();
    
endmodule

```

```
vcs -sverilog full_adder.v full_adder_tb.sv -full64 -lca -kdb -debug_access+all -cmline+fsm+tgl+cond

```

```
./simv
```

<img width="815" alt="cov" src="https://github.com/user-attachments/assets/2a9d329b-58c7-4d87-b7ac-514dc7de868c" />


```
Verdi -cov -covdir simv.vdb
```

<img width="959" alt="3" src="https://github.com/user-attachments/assets/f1bf87b3-12c9-409b-979d-5ddcdb368238" />

2nd sample covering 3 possible combinations
```
/*four_bit_full_Adder_module full_adder (A,B,C_in,Clock,SUM,C_out)*/
module full_adder (
input [3:0] A, B,
input Clock, C_in,
output reg [3:0] SUM,
output reg C_out 
); 

reg [3:0] reg1, reg2, sum_i;
reg c_in, c_out;

always @ (posedge Clock)
        begin
                reg1 <= A;
                reg2 <= B;
                c_in <= C_in;
        end

always @ (posedge Clock)
        begin
                SUM <= sum_i;
                C_out <= c_out;
        end

always @ *
        begin
                {c_out, sum_i} = reg1 + reg2 + c_in;
        end

covergroup cg_full_adder;
        coverpoint A;         // Coverpoint for A
        coverpoint B;         // Coverpoint for B
        coverpoint C_in;      // Coverpoint for Carry-in
        coverpoint SUM;       // Coverpoint for the SUM
        coverpoint C_out;     // Coverpoint for Carry-out
        // You can also add cross-coverage between different signals
        cross A, B, C_in;     // Coverage for combinations of A, B, and C_in
        cross SUM, C_out;     // Coverage for different SUM and C_out combinations
    endgroup

    // Create coverage object
    cg_full_adder full_adder_cov;

	//initialize coverage at the beginning
	initial begin
	full_adder_cov = new(); //create the coverage object
	end
  
	//update coverage during simulation
	always @ (A | B | C_in | SUM | C_out)
	begin
 		full_adder_cov.sample();
	end

endmodule
```
```
vcs -sverilog full_adder.v -full64 -lca -kdb -debug_access+all -cmline+fsm+tgl+cond

```

```
./simv
```
Verdi -cov -covdir simv.vdb

<img width="950" alt="4" src="https://github.com/user-attachments/assets/c7b2a71b-5657-4905-9da5-b4702cbad332" />


2. SV Methodology

	
# Linting
spyglass

<img width="336" alt="6" src="https://github.com/user-attachments/assets/1d150771-8c4e-4d98-b21c-7404919d87e5" />

Steps:
1. Add RTL files
2. Read the design
3. Set up the goal
4. Run the goal
5. Analyse the results
    

read_file -type verilog full_adder.v
current_goal Design_Read -alltop
link_design -force

<img width="959" alt="5" src="https://github.com/user-attachments/assets/49513bce-d73d-417b-81fc-2addbca290a9" />

 run_goal

 <img width="959" alt="7" src="https://github.com/user-attachments/assets/98b7d293-138d-4895-a7fb-667a3d5ed8ba" />


# Logic Synthesis
    Translating RTL code into an optimised gate-level netlist using a specific logic library
    
inputs

1. RTL
2. SDC
3. .lib
4. 
    
Process
   
   1. Create the RTL files
   2. Define the libraries – link library, target library, symbol library, and synthetic library
   3. Load the design, analyse it, and elaborate it
   4. Set design constraints – Design rule constraints and optimisation constraints
   5. Run synthesis and optimise the design
   6. Extract the synthesizable netlist
   7. Generate reports – power, performance, and area
   8. Save the design database – write the mapped netlist
    
Link Library

Target Library

Symbol Library

Synthetic Library

Analyze

Elaborate


Constraints

 1. Design Rule
 2. Optimizations

Scripts

rm_setup - common_setup.tcl

```


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
```
rm_setup - dc_setup.tcl
```
source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl
```
run script

```
#Sets the path to the technology library (32nm SAED)
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/

#Sets the variable RTL_SOURCE_FILES to point to your RTL design
set RTL_SOURCE_FILES ./../rtl/eight_bit_adder.v

echo $link_library
echo $target_library
echo $symbol_library
echo $synthetic_library
echo $search_path

```

<img width="958" alt="1" src="https://github.com/user-attachments/assets/90004d32-1d17-4430-b4a7-ff84405420d9" />

```
#Sources the setup script (initializes variables, libraries, and paths)
source -echo -verbose ./rm_setup/dc_setup.tcl

echo $link_library
echo $target_library
echo $symbol_library
echo $synthetic_library
echo $search_path

```

<img width="950" alt="2" src="https://github.com/user-attachments/assets/de78170c-7a42-4201-8b09-4dae5bbf1337" />

```
get_libs

```

<img width="952" alt="3 1" src="https://github.com/user-attachments/assets/5c8c8339-7689-4302-af70-d065a4399a85" />

```
#Defines a design library (WORK) to store intermediate synthesis results
define_design_lib WORK -path ./WORK

#Allows hierarchical design mapping, useful for handling complex designs
set_app_var hdlin_enable_hier_map true

#Parses the RTL code to check for syntax errors
analyze -format verilog ${RTL_SOURCE_FILES}

```

<img width="722" alt="3" src="https://github.com/user-attachments/assets/a327feca-1320-4818-bd59-81773db9488d" />

```

#Elaborates the design, resolving the HDL structure into a design database
elaborate ${DESIGN_NAME}
```

<img width="607" alt="4" src="https://github.com/user-attachments/assets/7a8a24e0-cc95-4df0-a998-c1e26ec79d67" />

<img width="958" alt="5" src="https://github.com/user-attachments/assets/a893daeb-2253-471b-891d-5ff99960c0d5" />

<img width="349" alt="6" src="https://github.com/user-attachments/assets/c8e29f87-3040-4bb3-92fe-614f57412af2" />

```

#Sets the current working design to the top-level module
current_design

#Sets the top-level design for verification
set_verification_top

# Don't use cells in the design
set_dont_use [get_lib_cells */FADD*]
set_dont_use [get_lib_cells */HADD*]
set_dont_use [get_lib_cells */MUX*]
set_dont_use [get_lib_cells */AO*]
set_dont_use [get_lib_cells */OA*]
set_dont_use [get_lib_cells */NAND*]
set_dont_use [get_lib_cells */XOR*]
set_dont_use [get_lib_cells */NOR*]
set_dont_use [get_lib_cells */XNOR*]

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
```



    Optimizations
    Outputs
    Checks

# Floorplan
    inputs
    Process
    Optimizations
    Outputs
    Checks
    
# Powerplan
    inputs
    Process
    Optimizations
    Outputs
    Checks
    
# Placement
    inputs
    Process
    Optimizations
    Outputs
    Checks
    
# Clock Tree Synthesis

    inputs
    Process
    Optimizations
    Outputs
    Checks

# Routing

    inputs
    Process
    Optimizations
    Outputs
    Checks

# Static Timing Analysis
    inputs
    Process
    Optimizations
    Outputs
    Checks

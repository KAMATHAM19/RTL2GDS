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

```
vcs -sverilog full_adder.v full_adder_tb.sv -full64 -lca -kdb -debug_access+all -cmline+fsm+tgl+cond

```

```
./simv
```

```
Verdi -cov -covdir simv.vdb
```

2. SV Methodology

	
# Linting

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


    

    Script
    
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

# [Register Transfer Level (RTL)](#register-transfer-level-rtl)

## Register Transfer Level (RTL)

`Register Transfer Level` (RTL) is a design abstraction in digital circuit design that explains how data flows between **registers** and the **combinational logic** that processes it.

### Example:

```verilog
always @(posedge clk) begin
  if (enable)
    out_reg <= in_data + 1;
end
```
- in_data + 1 is the combinational logic part.
- out_reg <= is the register transfer.
- The data transfer happens on the rising edge of the clock (clk).

## Four-Bit Full Adder

```verilog
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


# [Simulation using VCS and Verdi](#simulation-using-vcs-and-verdi)

- VCS - Functional Verification Compiler Suite tool

## [Testbench](#testbench)

Testbench - To verify the functionality of the design.

```verilog
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

```
vcs -sverilog full_adder.v full_adder_tb.sv -full64 -lca -kdb -debug_access+all 

```
```bash
-sverilog              # Enable SystemVerilog support
-full64                # 64-bit architecture 
-lca                   # Internal switches to VCS
-kdb                   # enables Kernel debugger
-debug_access+all      # Allows full signal visibility in waveform viewers 
```

<img width="959" alt="1" src="https://github.com/user-attachments/assets/18c5974a-182a-483e-a0eb-93bdfd004d0d" />
<br><br>

To run the design


```
./simv

```

<img width="953" alt="2" src="https://github.com/user-attachments/assets/75f5d21a-8e62-4de4-b8bd-894bd578f036" />
<br><br>

Schematic View of Design

<img width="943" alt="fa sch" src="https://github.com/user-attachments/assets/ea96937e-1af5-4864-b6cc-846ad414eb6b" />
<br><br>

<img width="959" alt="fa sch1" src="https://github.com/user-attachments/assets/90c992c8-8bfc-4a6e-9578-94db549edd2a" />
<br><br>


- Verdi - Debugging tool, waveform viewer

<img width="959" alt="verdi" src="https://github.com/user-attachments/assets/a1c04dc2-ec00-4075-a4d3-bc635d89edce" />
<br><br>

# [Verification](#verification)

## [Coverage Analysis](#coverage-analysis)
Coverage analysis is a general way to track how much of the design verification is done. It includes:
- `Code coverage` – How much of the HDL code has been tested.
- `Functional coverage` – How much of the design’s expected behavior has been checked.
- `Assertion coverage` – How many assertions have been activated or verified.

#### Code Coverage Components

### Coverage Terms

- **Coverpoint**  
  A specific thing we watch or check in the testbench or input.

- **Covergroups**  
  Groups of coverpoints collected together to measure coverage easily.

- **Bins**  
  Particular input cases or situations we count during simulation.

- **Ignore bins**  
  Coverage cases we choose not to include in the coverage results.

- **Cross coverage**  
  Checking how different coverpoints or variables combine and happen together during simulation.

- First example showing all possible combinations

```verilog
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
./simv
```
```
## Coverage Checks

| Coverage Type | Description                                                         | Command Option  |
|---------------|---------------------------------------------------------------------|---------------- |
| **Line**      | Checks whether each line in the code was executed.                  |  `-line`        |
| **Toggle**    | Checks whether each bit of each register/wire toggled (0→1 or 1→0). |  `-tgl`         |
| **Condition** | Checks all boolean sub-expressions in IF/CASE/TERNARY conditions.   |  `-cond`        |
| **FSM**       | Checks all states and transitions if your design has FSMs.          |  `-fsm`         |

### Example Usage

```bash
-line   # Line coverage
-fsm    # FSM coverage
-tgl    # Toggle coverage
-cond   # Condition coverage
```
<img width="815" alt="cov" src="https://github.com/user-attachments/assets/2a9d329b-58c7-4d87-b7ac-514dc7de868c" />
<br><br>

```
Verdi -cov -covdir simv.vdb
```

<img width="959" alt="3" src="https://github.com/user-attachments/assets/f1bf87b3-12c9-409b-979d-5ddcdb368238" />
<br><br>

- Second example covering 3 possible combinations
  
```verilog
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
vcs -sverilog full_adder.v full_adder_tb.v -full64 -lca -kdb -debug_access+all -cmline+fsm+tgl+cond
./simv
Verdi -cov -covdir simv.vdb
```

<img width="950" alt="4" src="https://github.com/user-attachments/assets/c7b2a71b-5657-4905-9da5-b4702cbad332" />
<br><br>

## [SV Methodology](#sv-methodology)

<div align="center">
<img width="524" alt="30" src="https://github.com/user-attachments/assets/280126e5-fead-43eb-b3a8-279d2d26525c" />
</div>

### Packet
```
class packet;
   bit [3:0] A, B;
   bit Clock, C_in;
   bit [3:0] SUM;
   bit C_out;
endclass
```

### Generator

```
class generator;
  packet pkt;
  mailbox gen2drv;
  
  function new(mailbox mbx);
    this.gen2drv = mbx;
  endfunction
  
  task run;
    repeat(10)
   begin
      pkt = new();
      pkt.randomize();
      gen2drv.put(pkt);
     #10;
    end
  endtask
endclass
```

### Driver

```
class driver;
  packet pkt;
  virtual intf vif;
  mailbox gen2drv;
  function new(virtual intf arg_vif, mailbox mbx);
    this.vif = arg_vif;
    this.gen2drv = mbx;
  endfunction
  
  
  task run;
    repeat(5) 
      
      begin
        packet pkt;
      gen2drv.get(pkt);
      vif.A    <= pkt.A;
      vif.B    <= pkt.B;
      vif.C_in <= pkt.C_in;
      @(posedge vif.Clock);
    end
  endtask
endclass
```

### Interface

```
interface intf();

  logic [3:0] A, B;
  logic Clock, C_in;
  logic [3:0] SUM;
  logic C_out;

endinterface
```
### Monitor

```
class monitor;
   mailbox mon2scr;
   packet pkt;
   virtual intf vif;
  
 function new(virtual intf arg_vif, mailbox arg_mbx1);
    this.vif = arg_vif;
    this.mon2scr = arg_mbx1; 
  endfunction
  
 task run;
      repeat(5) begin
      pkt = new();
      pkt.A     = vif.A;
      pkt.B     = vif.B;
      pkt.C_in  = vif.C_in;
      pkt.SUM   = vif.SUM;
      pkt.C_out = vif.C_out;
      mon2scr.put(pkt);
      #10;
    end
  endtask
endclass
```

### Scoreboard

```
class scoreboard;
  mailbox mon2scr;
  packet pkt;

  function new(mailbox arg_mbx);
    this.mon2scr = arg_mbx;
  endfunction
 
 task run;
    bit [4:0] expected_sum;
    repeat (5) begin
    mon2scr.get(pkt);
    expected_sum = pkt.A + pkt.B + pkt.C_in;
    if ((pkt.SUM !== expected_sum[3:0]) || (pkt.C_out !== expected_sum[4])) begin
      $display("[FAIL] Got: SUM=%0d, C_out=%0d | Expected: SUM=%0d, C_out=%0d",
               pkt.SUM, pkt.C_out, expected_sum[3:0], expected_sum[4]);
    end else begin
      $display("[PASS]");
      pkt.print();
    end
  end
endtask
      
endclass
```

### TOP

```
`include "interface.sv"
`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

module top;

  bit clk;
  intf inf();

    full_adder dut (
    .A(inf.A),
    .B(inf.B),
    .Clock(clk),
    .C_in(inf.C_in),
    .SUM(inf.SUM),
    .C_out(inf.C_out)
  );

  always #5 clk = ~clk;
  
  mailbox mon2scr = new;
  mailbox gen2drv = new;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scr;

  initial begin
  #10 inf.A = 4'b0000; inf.B = 4'b0000; inf.C_in = 0;  // 0 + 0 + 0 = 0
  #10 inf.A = 4'b0001; inf.B = 4'b0001; inf.C_in = 0;  // 1 + 1 = 2
  #10 inf.A = 4'b0101; inf.B = 4'b0011; inf.C_in = 1;  // 5 + 3 + 1 = 9
  #10 inf.A = 4'b1111; inf.B = 4'b0001; inf.C_in = 0;  // 15 + 1 = 16 
 
    gen = new(gen2drv);
    drv = new(inf, gen2drv);
    mon = new(inf, mon2scr);
    scr = new(mon2scr);

    fork
      gen.run();
      drv.run();
      mon.run();
      scr.run();
    join
  end
  
  initial
    $monitor("$time", "clk = %b, A = %b, B = %b, C_in = %b, SUM = %b, C_out = %b", clk, inf.A, inf.B, inf.C_in, inf.SUM, inf.C_out);
  initial begin
   
	$fsdbDumpfile("dump.fsdb");
	$fsdbDumpvars(0,top);
  end
  initial
    #100 $finish;
endmodule

```

VCS

```
vcs -sverilog full_adder.v top.sv -full64 -lca -kdb -debug_access+all
```
<div align="center">
<img width="359" alt="21" src="https://github.com/user-attachments/assets/b6b37695-c97f-48eb-98a3-bcaf85122e70" />
</div> <br> <br>

```
./simv -verdi
```

```
$timeclk = 0, A = xxxx, B = xxxx, C_in = x, SUM = xxxx, C_out = x
$timeclk = 1, A = xxxx, B = xxxx, C_in = x, SUM = xxxx, C_out = x
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = xxxx, C_out = x
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = xxxx, C_out = x
$timeclk = 0, A = 0001, B = 0001, C_in = 0, SUM = xxxx, C_out = x
$timeclk = 1, A = 0001, B = 0001, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 0, A = 0101, B = 0011, C_in = 1, SUM = 0000, C_out = 0
$timeclk = 1, A = 0101, B = 0011, C_in = 1, SUM = 0010, C_out = 0
[FAIL] Got: SUM=2, C_out=0 | Expected: SUM=0, C_out=1
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 0010, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 1001, C_out = 0
[FAIL] Got: SUM=9, C_out=0 | Expected: SUM=0, C_out=0
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 1001, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
[PASS]
[PKT] A=0 B=0 C_in=0 => SUM=0 C_out=0
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
[PASS]
[PKT] A=0 B=0 C_in=0 => SUM=0 C_out=0
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
[PASS]
[PKT] A=0 B=0 C_in=0 => SUM=0 C_out=0
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 0, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$timeclk = 1, A = 0000, B = 0000, C_in = 0, SUM = 0000, C_out = 0
$finish called from file "testbench.sv", line 58.
$finish at simulation time                  100
Simulation complete, time is 100.
testbench.sv, 58 :     #100 $finish;
```

<div align="center">
<img width="959" alt="23" src="https://github.com/user-attachments/assets/9fab2f20-97a9-496e-a606-ee28c7620970" />
</div>

### Schematic view

<p align="center">
  <img src="https://github.com/user-attachments/assets/1fce8bba-d374-4297-bda1-736824655ca7" width="311" alt="26" />
  <img src="https://github.com/user-attachments/assets/94170a84-c615-4007-8556-373d344870d4" width="273" alt="25" />
</p>

### Waveform

<img width="950" alt="27" src="https://github.com/user-attachments/assets/9820aeaa-5880-4790-bdd6-56961edcffa6" />



# [Linting](#linting)

**`Linting`** is the process of analyzing HDL code to detect potential errors, coding standard violations, and design issues early in the development cycle.

**`Spyglass`** is a widely used linting tool for static RTL analysis in ASIC and FPGA design flows.

## Key Features of Spyglass:

- **Static RTL checks** – Detects syntax errors, undefined signals, latch inference, etc.
- **Coding standard compliance** – Verifies adherence to predefined or custom coding guidelines.
- **Clock domain crossing (CDC) analysis** – Identifies potential CDC issues.
- **Reset domain crossing (RDC) checks** – Validates reset synchronization across domains.
- **Design for Test (DFT) readiness** – Highlights scan-related violations and testability issues.
- **Naming conventions and styles** – Ensures consistent signal and module naming.
  
<div align="center">
  <img width="336" alt="6" src="https://github.com/user-attachments/assets/1d150771-8c4e-4d98-b21c-7404919d87e5" />
</div>
<br><br>


## Benefits:

- Early detection of logic issues before simulation.
- Helps enforce design best practices.
- Improves code maintainability and readability.
- Saves time in the verification and integration phases.

## Spyglass Linting Steps

1. **Add RTL files**  
   Provide all the Verilog/SystemVerilog source files that need to be linted.

2. **Read the design**  
   Spyglass parses and elaborates the design hierarchy from the RTL.
```
read_file -type verilog full_adder.v
 ```
4. **Set up the goal**  
   Define the linting goal (e.g., `lint/lint_rtl`) and configure necessary rules or constraints.
```
current_goal Design_Read -alltop
link_design -force
```
6. **Run the goal**  
   Execute the linting goal to perform static checks and analyze the RTL.
```
run_goal
```
6. **Analyse the results**  
   Review reports and fix issues like unused signals, coding violations, inferred latches, etc.

<img width="959" alt="5" src="https://github.com/user-attachments/assets/49513bce-d73d-417b-81fc-2addbca290a9" />
<br><br>
<img width="959" alt="7" src="https://github.com/user-attachments/assets/98b7d293-138d-4895-a7fb-667a3d5ed8ba" />
<br><br>

# [Logic Synthesis](#logic-synthesis)

 `Logic synthesis` is the process of translating RTL code into an **`optimised gate-level netlist`** using a specific technology or logic library.
    
## [Inputs](#logic-synthesis-inputs)

<div align="center">
<pre>
+-----------------------------------------+
|                 Inputs                  |
+-----------------------------------------+
| 1. RTL (.v)                             |
| 2. SDC (constraints)                    |
| 3. .lib (Liberty format)                |
| 4. .tf (Technology file)                |
| 5. TLU+ files (Cmax/Cmin extraction)    |
| 6. Map file (TLU+ mapping file)         |
+-----------------------------------------+
</pre>
</div>

    
## [Process](#logic-synthesis-process)

1. **Create the RTL files**  
   Write the Verilog or SystemVerilog code for your design.

2. **Define the libraries**  
   Set up the link library, target library, symbol library, and synthetic library.

3. **Load the design, analyze, and elaborate**  
   Use synthesis tools to parse and understand the RTL hierarchy.

4. **Set design constraints**  
   Apply design rule constraints and optimization constraints (timing, area, power).

5. **Run synthesis and optimize the design**  
   Generate an optimized gate-level representation of the RTL.

6. **Extract the synthesizable netlist**  
   Output the final netlist for implementation and simulation.

7. **Generate reports**  
   Review reports for power, performance, and area (PPA analysis).

8. **Save the design database**  
   Write out the mapped netlist and final design state for further use.

## [Scripts](#logic-synthesis-scripts)

This section provides a detailed synthesis flow using Synopsys tools with SAED 32nm PDK.

#### `rm_setup/common_setup.tcl`

```tcl
set DESIGN_NAME                   "full_adder"  ;# Top-level design name

set PDK_PATH                      "/data/pdk/pdk32nm/SAED32_EDK/"

set ADDITIONAL_SEARCH_PATH        "$PDK_PATH $PDK_PATH/tech/milkyway $PDK_PATH/tech/star_rcxt"

set TARGET_LIBRARY_FILES          "$PDK_PATH/lib/stdcell_rvt/db_ccs/saed32rvt_tt0p78vn40c.db"

set TECH_FILE                     "$PDK_PATH/tech/milkyway/saed32nm_1p9m_mw.tf"

set MAP_FILE                      "saed32nm_tf_itf_tluplus.map"
set TLUPLUS_MAX_FILE              "saed32nm_1p9m_Cmax.tluplus"
set TLUPLUS_MIN_FILE              "saed32nm_1p9m_Cmin.tluplus"

set MIN_ROUTING_LAYER             "M1"
set MAX_ROUTING_LAYER             "M5"
```
### `rm_setup/dc_setup.tcl`
```tcl
source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl
```

**The `link_library`** is the set of all libraries that Design Compiler uses to resolve references to cells and modules in the design hierarchy — including black-boxes, macros, DesignWare components, and the standard cells themselves.

- It ensures that every instance in the RTL or any hierarchical module has a known and defined representation.
- It includes:
  - The `target_library` (usually referred to using `*`)
  - Macro libraries (e.g., SRAMs, ROMs)
  - DesignWare libraries (e.g., `dw_foundation.sld`)

**The `target_library`** in Synopsys Design Compiler is the set of technology-specific logic cells (usually from a standard cell `.db` file) that the tool uses to map and implement the synthesized design.

- Only the cells listed in the `target_library` will be used during technology mapping — the process of converting RTL code into gates.
  - These are typically libraries provided by the technology vendor.
  - **Examples:** Inverter, NAND, MUX, D flip-flop, etc.

**The `symbol_library`** is used for graphical representation of cells in Synopsys GUI tools like **Design Vision**.

- It contains symbolic icons or schematic views for each cell (like AND gate, DFF, etc.) to show block diagrams or gate-level schematics.
  - **File extension:** `.slib`
  - **Used only for visualization**, not for synthesis
  - **Not mandatory** unless you're using a GUI like *Design Vision*

**The `synthetic_library`** contains generic (technology-independent) cells used during the early stages of synthesis and for **DesignWare** components.

- It is **required** to analyze high-level constructs (like multipliers, adders, dividers) before they’re mapped to real gates in the `target_library`.

```
# Set the PDK path
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/

# Point to your RTL file
set RTL_SOURCE_FILES ./../rtl/eight_bit_adder.v

# Display library and path variables
echo $link_library
echo $target_library
echo $symbol_library
echo $synthetic_library
echo $search_path
```
 <img width="958" alt="1" src="https://github.com/user-attachments/assets/90004d32-1d17-4430-b4a7-ff84405420d9" /> 
<br><br>

```tcl
# Source the full setup
source -echo -verbose ./rm_setup/dc_setup.tcl

# Echo library paths
echo $link_library
echo $target_library
echo $symbol_library
echo $synthetic_library
echo $search_path
```
<img width="950" alt="2" src="https://github.com/user-attachments/assets/de78170c-7a42-4201-8b09-4dae5bbf1337" /> 
<br><br>

```tcl
get_libs

```
 <img width="952" alt="3 1" src="https://github.com/user-attachments/assets/5c8c8339-7689-4302-af70-d065a4399a85" /> 
<br><br>

**`Analyze`** – This command in Synopsys Design Compiler:

- **Reads** the HDL (Verilog) source files.
- **Checks for syntax and semantic errors** in the code.
- **Does not build** the generic logic model of the design yet.
- **Creates** an HDL library and stores intermediate results.
- Uses the **PRESTO (HDLC) compiler** for parsing and analysis.

```
#Defines a design library (WORK) to store intermediate synthesis results
define_design_lib WORK -path ./WORK

#Allows hierarchical design mapping, useful for handling complex designs
set_app_var hdlin_enable_hier_map true

#Parses the RTL code to check for syntax errors
analyze -format verilog ${RTL_SOURCE_FILES}

```
<img width="722" alt="3" src="https://github.com/user-attachments/assets/a327feca-1320-4818-bd59-81773db9488d" /> 
<br><br>

**`Elaborate`** – This command in Synopsys Design Compiler:

- **Builds the design hierarchy** from the analyzed HDL files.
- **Resolves all module references**, instantiations, and connections.
- **Creates a generic logic model** of the design in memory.
- **Translates the design into a technology-independent representation** (called **GTECH**).
- Is a **prerequisite step** before synthesis can begin.
- Reports **unresolved references** or missing modules.
- Enables the tool to understand the full **design structure and connectivity**.

```
#Elaborates the design, resolving the HDL structure into a design database
elaborate ${DESIGN_NAME}
```
<img width="607" alt="4" src="https://github.com/user-attachments/assets/7a8a24e0-cc95-4df0-a998-c1e26ec79d67" /> <br> <br> <img width="958" alt="5" src="https://github.com/user-attachments/assets/a893daeb-2253-471b-891d-5ff99960c0d5" />  <br> <br><div align="center"><img width="349" alt="6" src="https://github.com/user-attachments/assets/c8e29f87-3040-4bb3-92fe-614f57412af2" /> </div> <br> <br>

```tcl
current_design
set_verification_top

# Disable use of certain cells
set_dont_use [get_lib_cells */FADD*]
set_dont_use [get_lib_cells */HADD*]
set_dont_use [get_lib_cells */MUX*]
set_dont_use [get_lib_cells */AO*]
set_dont_use [get_lib_cells */OA*]
set_dont_use [get_lib_cells */NAND*]
set_dont_use [get_lib_cells */XOR*]
set_dont_use [get_lib_cells */NOR*]
set_dont_use [get_lib_cells */XNOR*]
```
```
# Create primary clock with 1ns period
create_clock -period 1 [get_ports Clock]

# Set input delays and transitions
set_input_delay -max 0.5 -clock Clock [all_inputs]
set_input_transition 0.5 [all_inputs]

# Set output delay
set_output_delay -max 0.5 -clock Clock [all_outputs]

# Clock uncertainties
set_clock_uncertainty -setup 0.300 [get_clocks Clock]
set_clock_uncertainty -hold 0.100 [get_clocks Clock]

# Transition constraints
set_max_transition 0.2 [current_design]
set_max_transition -clock_path 0.1 [get_clocks Clock]
```
```
# Load SDC constraints
read_sdc -echo ./../Constraints/full_adder.sdc
```

| Pre-Setup       | Pre-Hold        |
|-----------------|----------------|
| <img width="350" src="https://github.com/user-attachments/assets/30a36868-c741-4355-979e-85b8316f2d2d" /> | <img width="350" src="https://github.com/user-attachments/assets/058b6869-0a9c-4109-814e-d5c41cd488d6" /> | <br><br>

The **`compile`**:
- **Maps the design** from a generic (GTECH) representation to technology-specific gates (from the `target_library`).
- **Applies timing and area optimization** based on the constraints defined (e.g., clock, delay, area).
- **Performs logic transformations** and gate-level optimizations to meet design goals.
- Supports **flattening or preserving hierarchy** as configured.
- Suitable for **less complex designs** or when ultra-optimizations are not required.
  
```
#Synthesizes the RTL into a gate-level netlist based on the target library
compile
```
<div align="center"> <img width="526" alt="compile" src="https://github.com/user-attachments/assets/e213353c-6f70-4bb0-a05a-72b4599b1cfa" /></div> <br><br>

| Post-Setup       | Post-Hold     |
|-----------------|----------------|
| <img width="371" alt="setup" src="https://github.com/user-attachments/assets/b3e6d221-e336-4067-84e5-6c17c0102619" /> | <img width="373" alt="hold" src="https://github.com/user-attachments/assets/aaf63465-15ef-4061-8393-f516aa3b263d" /> | <br><br>

The **`compile_ultra`** :
- Builds on `compile`, but uses **more aggressive optimizations** and **advanced algorithms**.
- Enables:
  - **Retiming**
  - **Register balancing**
  - **Path-based optimization**
  - **Duplication for timing closure**
- Designed for **high-performance, area- and power-optimized** synthesis.
- Often used in production-level synthesis or critical-path designs.

```
compile_ultra

```
<div align="center"><img width="898" alt="10" src="https://github.com/user-attachments/assets/38ea5642-d30e-43ff-a279-1ec2f788f7a3" /></div>

| Post-Setup       | Post-Hold     |
|-----------------|----------------|
| <img width="320" alt="11" src="https://github.com/user-attachments/assets/00210e7d-893e-41be-8382-3586e7a50094" /> | <img width="344" alt="12" src="https://github.com/user-attachments/assets/b7b2e0c0-175b-4bb5-a5ab-f63ce0d2ff3e" /> | <br><br>

| Command         | Description                                       | Use Case                       |
|------------------|---------------------------------------------------|--------------------------------|
| `compile`        | Standard synthesis (basic optimization)           | Simple designs or initial runs |
| `compile_ultra`  | Aggressive synthesis (advanced optimizations)     | Final timing closure, PPA tuning |

<br><br>

```tcl
#Generate reports 
report_area -hierarchy > ./reports/area.rpt
report_power -hierarchy > ./reports/power.rpt
report_timing  > ./reports/timing.rpt

### To write results ###
write -format verilog -hierarchy -output ${RESULTS_DIR}/${DCRM_FINAL_VERILOG_OUTPUT_FILE}
write_sdc ./${RESULTS_DIR}/${DCRM_FINAL_SDC_OUTPUT_FILE}
```
## [Optimizations](#logic-synthesis-optimizations)

During synthesis, Design Compiler performs various optimizations to improve performance, area, and power:

- **Logic Optimization**
  - Boolean simplification
  - Constant propagation
- **Technology Mapping**
  - Mapping generic logic (GTECH) to technology-specific library cells
- **Retiming**
  - Moving flip-flops across logic gates to balance timing
- **Resource Sharing**
  - Reusing hardware resources (e.g., adders, multipliers) to save area

## [Outputs](#logic-synthesis-outputs)

<div align="center">
<pre>
+----------------------------------+
|         Outputs                  |
+----------------------------------+
| 1. Gate level netlist (.v)       |
| 2. Mapped SDC constraints        |
| 3. Reports - Area/Power/Timing   |
+----------------------------------+
</pre>
</div>

## [Checks](#logic-synthesis-checks)

To ensure correctness and meet design goals, several checks are carried out:

1. **Logical Equivalence Check (LEC)**  
   ➤ Ensures that the synthesized **netlist** matches the original **RTL behavior**  
   ➤ Typically performed using **Synopsys Formality**

2. **Timing Analysis (Pre-Layout)**  
   ➤ Uses **Static Timing Analysis (STA)** based on defined **SDC constraints**  
   ➤ Validates setup and hold timing across all paths

3. **Design Rule Checks (DRCs)**  
   ➤ Detects logic or structural violations  
   ➤ Ensures compliance with technology-specific rules

4. **Linting (Optional)**  
   ➤ Checks for code quality, coding style, and common issues  
   ➤ Helps detect synthesis warnings or unintentional logic

5. **Tool-Specific Checks (Design Compiler)**  
   - `check_design`: Confirms proper connectivity, hierarchy, and constraints  
   - `check_timing`: Validates timing constraints are correctly defined and met


# [Formality Equivalence Checking](#formality-equivalence-checking)

## What is Equivalence Checking?

Equivalence checking is a formal verification technique used to **mathematically prove** that two versions of a design (typically the **RTL** and the **synthesized netlist**) behave **identically**. Unlike simulation-based functional verification, equivalence checking doesn't require test vectors — making it **faster** and **more exhaustive**.

### Why Use Equivalence Checking?

- Verifies if a design remains functionally the same after:
  - **Synthesis**
  - **Engineering Change Orders (ECOs)**
  - **Optimization passes**
- **Catches bugs** that simulation might miss due to limited input coverage.

### How Does It Work?

Equivalence checking generally follows three key steps:

1. **Setup**  
   ➤ Load both designs: the original **reference (RTL)** and the **revised (netlist)**.

2. **Mapping**  
   ➤ Match corresponding elements (e.g., ports, outputs) between the two designs.

3. **Compare**  
   ➤ Formally check if the mapped elements behave identically (or are logically equivalent/inverted).

<div align="center"><img width="367" alt="fec" src="https://github.com/user-attachments/assets/371cdf8d-2b09-4f65-a6d5-ab3b69877bc4" /></div>


### Why Is It Important?

Modern chip development involves many tools and transformation steps. These can introduce **unintended changes** to design behavior. Simulation alone can miss these.

Equivalence checking provides:
- Confidence that synthesis or optimization did not alter functionality  
- Safety against overlooked bugs  
- Improved design quality and verification coverage

### Benefits

- **Faster** than exhaustive simulation  
- **Mathematically complete** (covers all cases)  
- **Finds hidden mismatches** in logic or structure  
- **Improves reliability** before tape-out

### Reference

[Synopsys: What is Equivalence Checking?](https://www.synopsys.com/glossary/what-is-equivalence-checking.html)

### Input Files 
 
<div align="center">
<pre>
+----------------------------------------+
|               Inputs                   |
+----------------------------------------+
| 1. RTL Source Code: full_adder.v       |
| 2. Standard Cell Library:              |
|    saed32rvt_tt0p78vn40c.db (Liberty)  |
| 3. Synthesized Netlist:                |
|    full_adder.mapped.v                 |
| 4. TCL Script for Formality:           |
|    formality_script.tcl                |
+----------------------------------------+
</pre>
</div>

## Script 

Command to open tool
```
formality
```
1. Reference Design

```tcl
#Read RTL into reference container
read_verilog -container r -libname WORK -01 {./full_adder.v}
```

2. library file
   
```tcl
# Load the standard cell library for mapping
read_db {/data/pdk/pdk32nm/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_tt0p78vn40c.db}
```
3. Implementation Design

```
# Read synthesized netlist into implementation container
read_verilog -container i -libname WORK -01 {./full_adder.mapped.v}
```
4. Match
```
# Match design structures
match
```
5. Verify
```
# verify design
verify
```
6. Debug
   
# [Physical Design](#physical-design)

## What is Physical Design?

**Physical Design** is the process of turning a digital design (like Verilog code) into a physical layout that can be manufactured.

### Main Steps in Physical Design:
1. **Floorplanning** – Decide where each block goes on the chip.
2. **Power Planning** – Add power and ground lines to ensure all parts get power.
3. **Placement** – Place all logic cells in the right positions.
4. **Clock Tree Synthesis (CTS)** – Spread the clock signal evenly to all parts.
5. **Routing** – Connect all components using metal wires.
6. **Timing and Power Analysis** – Check that the chip is fast and power-efficient.
7. **DRC (Design Rule Check)** – Make sure the layout follows manufacturing rules.

### Goal:
To create a chip layout that works correctly, uses power efficiently, and is ready for manufacturing.

## 1. [Import Design / Netlist](#import-design--netlist)

The first step in the physical design flow involves loading all necessary files into the tool and performing initial checks to ensure everything is correctly set up.

### What to Import

- **Gate-level netlist** (from synthesis)  
- **Timing constraints** (SDC file)  
- **Power intent** (UPF or CPF)  
- **Standard cell libraries** (logic and physical views)  
- **IP blocks** used in the design  
- **Floorplan files** (DEF)  
- **Technology file**  
- **TLUPLUS** (resistance/capacitance info)  

### Checks After Import

- Check for errors or warnings during file loading, especially for netlist, constraints, and power files  
- Ensure no empty modules or duplicate blocks (check uniquification)  
- Run low-power checks for multi-voltage designs  
- Identify `assign` or `tri` statements that might cause issues later  
- Perform a quick timing check to spot early violations (WNS/TNS)  

### Why Timing Checks Are Important

Timing results may differ between synthesis and physical tools (like ICC or Innovus) due to tool differences or constraint mismatches. Early timing checks help avoid surprises later and ensure a smoother design flow.

### TCL Script for ICC2 Physical Implementation

```tcl
# Start ICC2 GUI
start_gui

# Set the PDK path
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/

# Create a design library referencing the standard cell library
create_lib -ref_libs $PDK_PATH/lib/stdcell_rvt/ndm/saed32rvt_c.ndm final

# Read the synthesized gate-level netlist into the final library and specify the top module
read_verilog {./../DC/results/full_adder.mapped.v} -library final -design full_adder -top full_adder
````
<img width="896" alt="0" src="https://github.com/user-attachments/assets/94b22a64-6639-41f4-bd98-7cc4e82cd659" />

```
# Link the design blocks
link_block
```
<p align="center">
<img width="529" alt="0 1" src="https://github.com/user-attachments/assets/829d38f3-58b1-4201-9d2c-ccac6044a91d" />
</p>
<p align="center">
<img width="674" alt="1" src="https://github.com/user-attachments/assets/60071abd-bdda-40d1-960e-b2d690dc09bd" />
</p>

```
# Run netlist checks for errors and warnings
check_netlist
```
<p align="center">
<img width="322" alt="3" src="https://github.com/user-attachments/assets/738c6e79-d49c-473b-9896-70c200ac276b" />
</p>

```
# Run pre-floorplan design checks
check_design -checks dp_pre_floorplan
```
<p align="center">
  <img width="787" alt="4" src="https://github.com/user-attachments/assets/14ce4a85-9572-41f2-baa7-8a55d5a40b08" />
</p>


# [Floorplan](#floorplan) 

The **Floorplan** is the initial and crucial step in physical design. It defines the rough layout of the chip, including block shape, core area, pin placements, power domains, and macro positions — laying the foundation for the rest of the PnR (Place and Route) flow.

### [Objectives](#objectives)

Choose the right shape and place all standard cells, macros, and IOs efficiently inside the **core area** to meet timing, area, and power goals.

### [Inputs](#inputs)

<div align="center">
<pre>
+-----------------------------------------+
|                 Inputs                  |
+-----------------------------------------+
| 1. Mapped Netlist (.v)                  |
| 2. Library File (.ndm)                  |
| 3. SDC (Timing Constraints)             |
| 4. Floorplan TCL Script (.tcl)          |
| 5. Technology File (optional)           |
+-----------------------------------------+
</pre>
</div>

### [**Floorplanning Steps**](#floorplanning-steps)

1. **Define Core Size & Shape** (based on utilization)
2. **Create Voltage Areas** (for multi-voltage designs)
3. **IO Pin Placement** (inputs/outputs around the periphery)
4. **Standard Cell Row Creation** (for placing standard cells)
5. **Macro Placement** (for SRAMs, ROMs, etc.)
6. **Add Blockages** (optional, to guide placement and routing)

#### **Area Estimation Formula**

Core Area = Standard Cell Area / Core Utilization

For a square floorplan, use:

```tcl
initialize_floorplan -core_utilization 0.65 -side_ratio {19.95 19.95} -core_offset {3}
```
<p align="center">
  <img width="283" alt="1 1" src="https://github.com/user-attachments/assets/af30460c-1642-46da-bf4a-ea1b100e9020" />
  <img width="409" alt="2" src="https://github.com/user-attachments/assets/e67f9fae-5b1e-4fa9-b639-dc3194f107a1" />
</p>

Ports Placement 
```
# Pin Constraints
set_individual_pin_constraints -sides 1  -ports [remove_from_collection [all_inputs] "Clock C_in"] -pin_spacing 5
place_pins -ports [all_inputs]
set_individual_pin_constraints -sides 2  -ports [get_ports "C_in"] -pin_spacing 5
place_pins -ports {Clock C_in}
set_individual_pin_constraints -sides 4  -ports [get_ports "Clock"] -pin_spacing 5
place_pins -ports {Clock C_in}
set_individual_pin_constraints -sides {3} -ports [all_outputs] -pin_spacing 5
place_pins -ports [all_outputs]
```
<p align="center">
<img width="404" alt="3" src="https://github.com/user-attachments/assets/33e72d1d-e379-406f-90d8-e330416643f3" />
</p>

### [Floorplan Optimizations](#floorplan-optimizations)

Effective floorplanning sets the stage for meeting timing, area, and power goals. Below are key optimization strategies used during the floorplanning stage:

- **Minimize Congestion**  
  Place macros and IO pins in a way that reduces dense routing areas, especially in critical regions. Use blockages if necessary to guide placement.

- **Macro Alignment**  
  Align and group macros (like SRAMs, IPs) based on functionality, power domains, and routing ease. This improves accessibility and signal integrity.

- **Utilization Balance**  
  Maintain a balanced core utilization across the floorplan. Over-utilized areas can cause routing failures and timing violations later in the flow.

- **Timing-Aware Planning**  
  Place high-speed and critical-path logic close together to reduce delay. Keep clocked elements and key data paths short and direct for better performance.

### [Outputs](#outputs)

<div align="center">
<pre>
+-----------------------------------------+
|               Outputs                   |
+-----------------------------------------+
| 1. Floorplan Database (.def)            |
| 2. Pin Placement Report (.rpt)          |
| 3. Area and Utilization Report          |
| 4. Updated Design Library               |
+-----------------------------------------+
</pre>
</div>

 ### [Checks](#checks)

After completing the floorplan stage, several essential checks are performed to ensure the design is legal, efficient, and ready for placement.

### Checks

| Check Command              | Purpose                                                                 |
|----------------------------|-------------------------------------------------------------------------|
| `check_legality`           | Ensures cells/macros follow legal placement rules (no overlaps, gaps).  |
| `check_pin_placement`      | Verifies that input/output pins are correctly placed and constrained.   |
| `check_floorplan`          | Checks for unplaced macros, missing core rows, and blockages.           |
| `report_utilization`       | Summarizes cell area, core area, and utilization.                       |
| `report_area`              | Reports area breakdown for logic, macros, etc.                          |
| `check_power_domains`      | Validates correctness of MV (multi-voltage) power domain definitions.   |
| `check_mv_design`          | Checks isolation, level shifters, and power intent consistency.         |
| `report_floorplan`         | Gives detailed info on block shape, area, margins, and pin access.      |
| `report_clock_domains`     | Ensures clock-related partitions are defined and reachable.             |
| Visual inspection (GUI)    | Manual review of macro placement, congestion hotspots, and pin access.  |


#  [Powerplan](#powerplan)

**Power planning** is a **pre-routing** step in the physical design flow. It ensures a stable and reliable power supply across the chip by building a **Power Delivery Network (PDN).**

### [Objectives](#objectives)

1. **Uniform power distribution** – All cells in the design should get the right amount of power.
2. **Minimize IR drop** – Reduce voltage loss across the chip.
3. **Prevent electromigration** – Avoid metal damage due to high current density.
4. **Ensure reliability** – Ensure the IC functions safely and efficiently under all conditions.

### [Inputs](#inputs)

<div align="center">
<pre>
+-------------------------------+
|         Inputs                |
+-------------------------------+
| 1. Floorplan Database (.def)  |
| 2. Powerplan Scripts (.tcl)   |
+-------------------------------+
</pre>
</div>

### [Powerplanning Steps](#powerplanning-steps)

#### 1. Create Core Power Rings  
**Purpose:** Carry power (VDD/VSS) from the chip's I/O pads around the core.  
**Structure:** Wide metal loops, typically on top layers (e.g., M8, M9), that enclose the core area.  
**Function:** Act as the main entry point for power into the core.

#### 2. Create Power Mesh / Straps / Stripes  
**Purpose:** Distribute power from the rings evenly across the core.  
**Description:** A grid of vertical and horizontal metal lines (e.g., on M6 and M7).  
**Function:** Ensures stable and uniform power delivery throughout the block.

#### 3. Create Standard Cell Rails  
**Purpose:** Provide direct power to the standard cells (logic gates, flip-flops, etc.).  
**Description:** Narrow VDD/VSS rails, usually on lower layers (like M1 or M2).  
**Function:** Connect to the power mesh above via vias to supply power to logic cells.

<table align="center">
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="250" alt="6" src="https://github.com/user-attachments/assets/831f71aa-5f41-4440-8c89-4a59df010be2" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="292" alt="7" src="https://github.com/user-attachments/assets/33f12633-7f30-4129-b0f5-2ad05fc70779" />
    </td>
  </tr>
</table>

### [Script](#script) 

```tcl
# Clean previous PG strategies and routes
remove_pg_strategies -all
remove_pg_patterns -all
remove_pg_regions -all
remove_pg_via_master_rules -all
remove_pg_strategy_via_rules -all
remove_routes -net_types {power ground} -ring -stripe -lib_cell_pin_connect

# Create power/ground ports and nets
create_port -direction in VDD
create_port -direction in VSS
create_net -power VDD
create_net -ground VSS
connect_pg_net -pg -design full_adder -automatic -all_blocks
```
<div align="center">
<img width="638" alt="4" src="https://github.com/user-attachments/assets/d21a93c7-f103-4881-8e98-3a6f79e9f3d6" />
</div>

```
create_shape -shape_type rect -layer M7 -boundary {{0.000 8.759} {1.991 9.242}} -port VDD
create_shape -shape_type rect -layer M7 -boundary {{0.000 9.757} {0.996 10.229}} -port VSS
```
<div align="center">
<img width="412" alt="3 1" src="https://github.com/user-attachments/assets/d88abafb-c779-4e64-9f64-783f35c46af2" />
</div>

```
# Define core ring
create_pg_ring_pattern core_ring_pattern -horizontal_layer M9 -horizontal_width 0.5 -horizontal_spacing 0.5 -vertical_layer M8 -vertical_width 0.5 -vertical_spacing 0.5
set_pg_strategy core_power_ring -core -pattern {{name:core_ring_pattern} {nets:{VDD VSS}} {offset: {1 1}}}
compile_pg -strategies core_power_ring
```
<div align="center">
<img width="343" alt="8" src="https://github.com/user-attachments/assets/b9ae751b-b6eb-4077-8bb1-d9a3e8af62ac" />
</div>

```
# Define mesh pattern
create_pg_mesh_pattern mesh -layers {{{vertical_layer: M6} {width: 0.5} {spacing: interleaving} {pitch: 2} {offset: 1}} {{horizontal_layer: M7} {width: 0.5} {spacing: interleaving} {pitch: 2} {offset: 1}}}
set_pg_strategy core_mesh -pattern {{name:mesh} {nets:VDD VSS}} -core -extension {stop:innermost_ring}
compile_pg -strategies core_mesh
```
<div align="center">
<img width="339" alt="11" src="https://github.com/user-attachments/assets/7b658fc0-4ac2-48a8-9a73-e8fc961bd509" />
</div>

```
# Standard cell rail connection
create_pg_std_cell_conn_pattern std_cell_rail -layers M1 -rail_width 0.19
set_pg_strategy rail_strategy -core -pattern {{name: std_cell_rail} {nets: VDD VSS}}
compile_pg -strategies rail_strategy
```
<div align="center">
<img width="353" alt="12" src="https://github.com/user-attachments/assets/6c462008-7286-4096-916c-60ecc1b7c857" />
</div>

```
check_pg_drc
```
<div align="center">
<img width="455" alt="13" src="https://github.com/user-attachments/assets/b70ba5a8-09cc-4888-9631-4ca92e9675f1" />
</div>

```
check_pg_connectivity
```
<div align="center">
<img width="453" alt="15" src="https://github.com/user-attachments/assets/84d1275f-2a9d-4b2a-98f0-67e4c189159f" />
</div>

```
check_pg_missing_vias
```
<div align="center">
<img width="344" alt="14" src="https://github.com/user-attachments/assets/ee5866cb-0422-4b59-bd38-fb9284ac9467" />
</div>

```
report_power_domains
```
<div align="center">
<img width="334" alt="16" src="https://github.com/user-attachments/assets/ac488972-b74f-470a-9481-5a7caff916f8" />
</div>

```
analyze_power_plan -report_track_utilization_only
```
<div align="center">
<img width="473" alt="17" src="https://github.com/user-attachments/assets/897246ce-c887-4cdb-8261-35f0fc1370f1" />
</div>

```
report_utilization
```
<div align="center">
<img width="776" alt="18" src="https://github.com/user-attachments/assets/5a77356d-4499-42b7-9de7-bdbbf6f68e79" />
</div>

### [Powerplan Optimizations](#powerplan-optimizations)

- Minimize IR drop by adjusting stripe width, pitch, and metal layer usage.
- Balance power distribution across metal layers.
- Place macros close to critical blocks to ensure they get clean and stable power.

### [Outputs](#outputs)

<div align="center">
<pre>
+-----------------------------------------+
|               Outputs                   |
+-----------------------------------------+
| 1. Powerplan Database (.def)            |
| 2. PG Connectivity Reports (.rpt)       |
| 3. Power Analysis Reports               |
+-----------------------------------------+
</pre>
</div>

### [Checks](#checks) 

| Check                  | Purpose                                               |
|------------------------|------------------------------------------------------ |
| `check_pg_drcs`        | Ensure PG-related DRCs are not violated               |
| `check_pg_connectivity`| Confirm VDD/VSS nets are fully connected to all cells |
| `check_pg_missing_vias`| Identify any missing vias in power/ground connections |

# [Placement](#placement)

**Placement** is the process of assigning physical locations to all the standard cells inside a chip’s core area.

### [**Objectives**](#objectives)

- Place all cells inside the core without overlaps
- Optimize timing (WNS/TNS), power, and area
- Minimize wirelength and congestion
- Ensure legality and design rule compliance

### [Inputs](#inputs)

<div align="center">
<pre>
+-------------------------------+
|            Inputs             |
+-------------------------------+
| 1. Powerplan Database (.def)  |
| 2. Library File (.lib)        |
| 3. SDC (Timing Constraints)   |
| 4. Placement Script (.tcl)    |
| 5. MCMM Setup File            |
| 6. TLUPLUS File               |
| 7. Layer Map (MAP File)       |
+-------------------------------+
</pre>
</div>

### [Placement Steps](#placement-steps)

1. **Pre-Placement Checks**
   - No floating nets or cells
   - Pins and macros placed and fixed
   - Power grid routes are free of DRCs

2. **Initial Coarse Placement**
   - Cells roughly placed based on congestion and timing
   - Wirelength is minimized
   - Better RC improves early timing

3. **High Fanout Net Buffering**
   - Buffers inserted to handle nets with many loads

4. **Initial Optimization**
   - First pass of timing fixing
   - Improve WNS, reduce TNS
   - Move cells to meet constraints

5. **Final Placement**
   - Tool performs timing-driven placement

6. **Final Optimization**
   - Focus on optimizing for power, area, and final timing closure

### [Script](#script) 

```tcl
set PDK_PATH /data/pdk/pdk32nm/SAED32_EDK/
set Constraints ./../Constraints/full_adder.sdc

# Pre-placement checks
check_design -checks pre_placement_stage
set_app_options -name place.coarse.continue_on_missing_scandef -value true

# Remove existing scenarios
remove_mode -all
remove_corner -all
remove_scenario -all

# Define a new scenario
set mode1 "func"
set corner1 "slow"
set scenario1 "${mode1}_${corner1}"

create_mode $mode1
create_corner $corner1
create_scenario -name $scenario1 -mode $mode1 -corner $corner1
report_scenarios

# Setup parasitics
set parasitic1 "p1"
set tluplus_filep1 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_filep1 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic1

# Apply constraints and scenarios
source $Constraints
set_scenario_status func_fast -hold false -setup true -leakage_power true -dynamic_power true -max_capacitance true -min_capacitance false -max_transition true -active true
report_timing
report_timing -delay_type min
```
| Post-Setup       | Post-Hold     |
|-----------------|----------------|
| <img width="337" alt="21 1" src="https://github.com/user-attachments/assets/930a459e-d4de-401e-a968-829d37fc1844" /> | <img width="350" alt="22 1" src="https://github.com/user-attachments/assets/5dcffb72-f2c6-4819-be56-8ca1a6d57bf4" /> | <br><br>

<div align="center">
<img width="910" alt="51" src="https://github.com/user-attachments/assets/74c614c3-bfe8-4464-9800-422f07ce23a0" />
</div> 

```
# Perform placement
place_opt
legalize_placement
```
<div align="center">
<img width="335" alt="26 1" src="https://github.com/user-attachments/assets/c94b21d5-f7cf-4aa5-b536-9b9106ad2116" />
</div> <br> <br>

<table align="center">
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="667" alt="26 2" src="https://github.com/user-attachments/assets/254d2169-ba87-4fdf-8f70-596c24263ed4" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="501" alt="26" src="https://github.com/user-attachments/assets/1828a104-8106-48f8-b615-b61c5fa8a237" />
    </td>
  </tr>
</table>

```
# Reports
report_congestion
```
<div align="center">
<img width="485" alt="31" src="https://github.com/user-attachments/assets/ddb69058-8a61-43eb-b794-90c5f262f24f" />
</div> <br> <br>

```
report_placement
```
<div align="center">
<img width="596" alt="29" src="https://github.com/user-attachments/assets/f2360b79-10e3-48a0-b5ca-bf3fc54a98dc" />
</div> <br> <br>

```
report_utilization
```
<div align="center">
<img width="616" alt="29 1" src="https://github.com/user-attachments/assets/f6d3ae61-b3d1-4ac2-a5c5-b21fa9ed47dc" />
</div> <br> <br>

```
report_global_timing
```
<div align="center">
<img width="271" alt="30" src="https://github.com/user-attachments/assets/dee4ef71-8c24-40b1-89fa-039c5c0f7c59" />
</div> <br> <br>

```
check_legality
```
<table align="center">
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="526" alt="30 1" src="https://github.com/user-attachments/assets/2dfcbc53-503b-4441-a222-80670e630e0a" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="543" alt="30 2" src="https://github.com/user-attachments/assets/0b5c86df-67b1-438b-9a68-df0f5e12bceb" />
    </td>
  </tr>
</table>
<br><br>

<table align="center">
  <thead>
    <tr>
      <th>Cell Density</th>
      <th>Pin Density</th>
    </tr>
  </thead>
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="344" alt="27 - Cell Density" src="https://github.com/user-attachments/assets/135d3214-b59d-4b0e-b2ed-c3475d6e5f1a" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="341" alt="28 - Pin Density" src="https://github.com/user-attachments/assets/ed9403de-656f-482b-b7ca-da90e09dfa3e" />
    </td>
  </tr>
</table>


### [Placement Optimizations](#placement-optimizations)

- **Timing-Driven Placement**  
  Improve setup/hold slack by adjusting cell locations based on timing analysis.

- **Clustering**  
  Group related logic together to reduce interconnect delays and improve routing efficiency.

- **Power-Aware Placement**  
  Minimize dynamic power by shortening high-activity nets and strategically placing power-hungry cells.

### [Outputs](#outputs)

<div align="center">
<pre>
+-------------------------------+
|           Outputs            |
+-------------------------------+
| 1. Placement DB (.def)       |
| 2. Congestion Maps           |
| 3. Timing Reports            |
| 4. Pin and Cell Density Data |
+-------------------------------+
</pre>
</div>
<br><br>

### [Checks](#checks)

| Check Command             | Purpose                                           |
|---------------------------|---------------------------------------------------|
| `check_legality -verbose` | Ensure cells are not overlapping or misaligned    |
| `report_utilization`      | Shows core usage percentage                       |
| **Timing Checks**         | Check setup and hold violations                   |
| `report_congestion`       | Identify areas with dense routing                 |
| **DRC Checks**            | Ensure spacing and layout rules are followed      |


    
# [Clock Tree Synthesis (CTS)](#clock-tree-synthesis-cts)

**Clock Tree Synthesis (CTS)** is the process of building and optimizing the clock network in a chip. It distributes the clock signal from the source (like a PLL or clock port) to all sequential elements (flip-flops, latches) with minimal **skew** and controlled **insertion delay**.


### [Objectives](#objectives)

- Distribute the clock signal efficiently across the chip.
- Minimize **clock skew** (difference in clock arrival times).
- Control **insertion delay** (delay from source to sinks).
- Balance setup and hold timing paths.

### [Inputs](#inputs)

<div align="center">
<pre>
+---------------------------------+
|         Inputs                  |
+---------------------------------+
| 1. Placement DB (.def)          |
| 2. Tech File (.tf)              |
| 3. Logical Library (.lib)       |
| 4. Physical Library (.lef/.ndm) |
| 5. TLUPLUS Files (.tlu)         |
| 6. CTS Script (.tcl)            |
+---------------------------------+
</pre>
</div>

### [**CTS Steps**](#cts-steps)

### 1. Classic CTS Flow
- Clock tree is built **independent** of data path.
- Main goal is **skew minimization**.
- Produces a **balanced**, often symmetric clock tree.
- Data timing is optimized **after** clock tree synthesis.

### 2. Concurrent Clock and Data (CCD) Flow
- Clock tree is built **with data path knowledge**.
- Focuses on **meeting timing (setup/hold)** during CTS.
- Clock and data paths are co-optimised in iterations.


### [Script](#script)

```tcl
check_design -checks pre_clock_tree_stage
synthesize_clock_trees
```
<div align="center">
<img width="343" alt="32" src="https://github.com/user-attachments/assets/3436795b-8cc1-4c0a-9862-695b65c0f3e0" />
</div>

<h3 align="center">PRE-CTS</h3>

<table align="center">
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="104" alt="34" src="https://github.com/user-attachments/assets/32ea64b3-05ff-43c2-b32d-43509f9e6232" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="403" alt="35" src="https://github.com/user-attachments/assets/913aaeb0-8f0d-44be-8f4e-5d5880450622" />
    </td>
  </tr>
</table>


```
# Enable local skew optimization
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value true

# Set latency and skew targets
get_corners
set_clock_tree_options -target_latency 0.3 -target_skew 0.02 -corner $corner1

# Run clock optimisation
clock_opt
```
<div align="center">
<img width="344" alt="39" src="https://github.com/user-attachments/assets/0b645126-1fa7-42f3-b625-14a3f6695472" />
</div> 


<h3 align="center">POST-CTS</h3>

<table align="center">
  <tr>
    <td align="center" style="padding: 10px;">
      <img width="419" alt="38" src="https://github.com/user-attachments/assets/21ec1223-e0f2-4f61-b52e-fef823218437" />
    </td>
    <td align="center" style="padding: 10px;">
      <img width="730" alt="41" src="https://github.com/user-attachments/assets/b4aadbbd-253c-4b64-a68d-2a0aaf2c91fd" />
    </td>
  </tr>
</table>

### [CTS Optimizations](#cts-optimizations)

- **Skew Balancing**  
  Equalize the arrival time of the clock signal to all flip-flops and latches to avoid timing violations.

- **Latency Minimization**  
  Reduce the total delay from the clock source to the sinks (registers) to improve timing performance.

- **Buffer/Repeater Insertion**  
  Insert buffers or inverters to strengthen the clock signal, meet transition constraints, and drive long-distance nets effectively.

### [Outputs](#outputs)

<div align="center">
<pre>
+-----------------------------------------+
|                 Outputs                 |
+-----------------------------------------+
| 1. CTS Updated DB (.def)                |
| 2. Clock Tree Reports (.rpt)            |
| 3. Skew and Latency Data                |
| 4. Power Report for Clock Tree          |
+-----------------------------------------+
</pre>
</div>

### [Checks](#checks) 

| **Check Command**                 | **Purpose**                                                   |
|----------------------------------|----------------------------------------------------------------|
| `report_clock_tree`              | Shows clock buffers, sinks, fanout levels, and structure.      |
| `report_timing`                  | Verifies setup and hold timing after clock tree insertion.     |
| `report_clock_skew`              | Confirms clock skew is within the allowed range.               |
| `report_clock_latency`           | Measures delay from clock source to clock sinks.               |
| `report_power -net_type clock`   | Reports power consumption of the entire clock network.         |



# [Routing](#routing)

**Routing** is the process of creating physical metal connections between all cells and components in the design, while following foundry-specific design rules.

### [**Objectives**](#objectives)

- Perform pre-routing checks and setup
- Route signal nets efficiently
- Optimize routed design for performance and area
- Fix DRC (Design Rule Check) violations after routing

### [**Inputs**](#inputs)

<div align="center">
<pre>
+---------------------------------+
|            Inputs               |
+---------------------------------+
| 1. CTS Database (.def)          |
| 2. Tech File (.tf)              |
| 3. Logical Library (.lib)       |
| 4. Physical Library (.lef/.ndm) |
| 5. TLUPLUS Files (.tluplus)     |
| 6. Routing Script (.tcl)        |
+---------------------------------+
</pre>
</div>

### [**Routing Steps**](#routing-steps)

1. **Clock Nets Routed Already**  
   Clock nets are typically routed during CTS.

2. **Signal Net Routing**  
   All remaining connections are routed without moving cells.

3. **Post-Route Optimization**  
   Improves timing, area, and fixes any violations.


### [**Script**](#script)

```tcl
check_design -checks pre_route_stage

# Enable timing and crosstalk awareness
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value true
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true
set_app_options -name route.detail.timing_driven -value true
set_app_options -name route.detail.antenna -value true

# Antenna effect fixing using diodes
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value {*/ANTENNA}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value {*/ANTENNA_HVT}
set_app_options -block [current_block] -name route.detail.diode_libcell_names -value {*/ANTENNA_RVT}

# Routing commands
route_global
route_track
route_detail
route_opt

# Reports and Exports
report_timing
report_design -all
check_lvs
check_routes
check_routability

# Export final files
write_verilog ./data/eight_bit_full_adder_routed_netlist.v
write_parasitics -format spef -output ./data/eight_bit_full_adder_func_slow.spef
write_gds -design eight_bit_full_adder ./data/eight_bit_full_adder.gds
write_def -design eight_bit_full_adder ./data/eight_bit_full_adder_routing.def
create_frame ./data/eight_bit_full_adder.frame
write_lef -design eight_bit_full_adder ./data/eight_bit_full_adder.lef

```
### [**Routing Optimizations**](#routing-optimizations)

- **Reduce Coupling Capacitance:**  
  Lower interference between nearby wires to avoid crosstalk and signal integrity issues.

- **Meet Timing Constraints (Setup/Hold):**  
  Ensure all signal paths meet required setup and hold time margins for reliable operation.

- **Minimize IR Drop and Electromigration (EM):**  
  Use proper metal width and routing strategies to avoid voltage drop and prevent long-term metal degradation.

- **Ensure Design Rule Compliance (DRC):**  
  Follow foundry-specific spacing, width, and density rules to ensure the chip is manufacturable.

- **Reduce Noise and Power Issues:**  
  Optimize routes to minimize switching noise and unnecessary dynamic/static power consumption.

- **Compact Routing to Save Area:**  
  Efficiently utilize routing resources to reduce overall chip area and improve yield.

### [**Outputs**](#outputs)

  <div align="center">
<pre>
+----------------------------------------------+
|                  Outputs                     |
+----------------------------------------------+
|  1. Final Routed Design (DEF/GDSII)          |
|  2. Parasitic Extraction File (SPEF)         |
|  3. Final Timing Reports                     |
|  4. Congestion Maps                          |
|  5. LVS-Ready Netlist                        |
+----------------------------------------------+
</pre>
</div>

### [**Checks**](#checks) 

| Check               | Purpose                                        |
|---------------------|------------------------------------------------|
| `check_routability` | Verifies that all nets can be routed cleanly   |
| `check_lvs`         | Ensures layout vs schematic consistency        |
| `check_routes`      | Detects any open or short connections          |
| `report_timing`     | Validates that timing requirements are met     |
| `report_congestion` | Highlights congested areas in the design       |
| `report_drc`        | Ensures no DRCs exist in final routed layout   |






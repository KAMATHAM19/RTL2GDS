# RTL

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



# Simulation

# Verification
   1. System Verilog Methodology
   2. Coverage Analysis
      i) Code Coverage
      ii) Functional Coverage

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

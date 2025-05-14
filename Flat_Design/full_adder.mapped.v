/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP4
// Date      : Wed May 14 22:40:47 2025
/////////////////////////////////////////////////////////////


module full_adder ( A, B, Clock, C_in, SUM, C_out );
  input [3:0] A;
  input [3:0] B;
  output [3:0] SUM;
  input Clock, C_in;
  output C_out;
  wire   c_in, c_out, n3, n4, n5, n6, n7, n8, n9, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82;
  wire   [3:0] reg1;
  wire   [3:0] reg2;
  wire   [3:0] sum_i;

  DFFX1_RVT \reg1_reg[3]  ( .D(A[3]), .CLK(Clock), .Q(reg1[3]) );
  DFFX1_RVT \reg1_reg[2]  ( .D(A[2]), .CLK(Clock), .Q(reg1[2]), .QN(n7) );
  DFFX1_RVT \reg2_reg[3]  ( .D(B[3]), .CLK(Clock), .Q(reg2[3]) );
  DFFX1_RVT \reg2_reg[2]  ( .D(B[2]), .CLK(Clock), .Q(reg2[2]), .QN(n5) );
  DFFX1_RVT \reg2_reg[0]  ( .D(B[0]), .CLK(Clock), .Q(reg2[0]), .QN(n82) );
  DFFX1_RVT c_in_reg ( .D(C_in), .CLK(Clock), .Q(c_in), .QN(n78) );
  DFFX1_RVT \SUM_reg[2]  ( .D(sum_i[2]), .CLK(Clock), .Q(SUM[2]) );
  DFFX1_RVT \SUM_reg[1]  ( .D(sum_i[1]), .CLK(Clock), .Q(SUM[1]) );
  DFFX1_RVT \SUM_reg[0]  ( .D(sum_i[0]), .CLK(Clock), .Q(SUM[0]) );
  DFFX1_RVT \reg2_reg[1]  ( .D(B[1]), .CLK(Clock), .Q(reg2[1]), .QN(n80) );
  DFFX1_RVT \reg1_reg[1]  ( .D(A[1]), .CLK(Clock), .Q(reg1[1]), .QN(n79) );
  DFFX1_RVT \reg1_reg[0]  ( .D(A[0]), .CLK(Clock), .Q(reg1[0]), .QN(n81) );
  DFFX1_RVT C_out_reg ( .D(c_out), .CLK(Clock), .Q(C_out) );
  DFFX1_RVT \SUM_reg[3]  ( .D(sum_i[3]), .CLK(Clock), .Q(SUM[3]) );
  INVX1_RVT U5 ( .A(n24), .Y(n3) );
  AND3X2_RVT U6 ( .A1(n4), .A2(n38), .A3(n75), .Y(n41) );
  OR2X1_RVT U7 ( .A1(n37), .A2(n36), .Y(n4) );
  INVX1_RVT U8 ( .A(n5), .Y(n6) );
  INVX1_RVT U9 ( .A(n7), .Y(n8) );
  OR2X1_RVT U10 ( .A1(n8), .A2(reg2[2]), .Y(n9) );
  INVX0_RVT U11 ( .A(n73), .Y(n22) );
  INVX0_RVT U12 ( .A(n67), .Y(n29) );
  INVX1_RVT U13 ( .A(n48), .Y(n45) );
  INVX0_RVT U14 ( .A(n68), .Y(n28) );
  INVX0_RVT U15 ( .A(n38), .Y(n40) );
  INVX0_RVT U16 ( .A(n55), .Y(n54) );
  INVX0_RVT U17 ( .A(n64), .Y(n70) );
  INVX1_RVT U18 ( .A(n53), .Y(n44) );
  INVX0_RVT U19 ( .A(n31), .Y(n63) );
  INVX0_RVT U20 ( .A(n76), .Y(n30) );
  AND2X1_RVT U21 ( .A1(n19), .A2(n77), .Y(c_out) );
  OR3X1_RVT U22 ( .A1(n76), .A2(n21), .A3(n20), .Y(n19) );
  INVX0_RVT U23 ( .A(n4), .Y(n20) );
  OR2X1_RVT U24 ( .A1(n37), .A2(n36), .Y(n74) );
  INVX0_RVT U25 ( .A(n75), .Y(n21) );
  AND2X1_RVT U26 ( .A1(reg2[0]), .A2(reg1[0]), .Y(n24) );
  INVX0_RVT U27 ( .A(n72), .Y(n23) );
  INVX0_RVT U28 ( .A(n39), .Y(n27) );
  OR2X1_RVT U29 ( .A1(reg1[0]), .A2(reg2[0]), .Y(n53) );
  AND2X1_RVT U30 ( .A1(n23), .A2(n22), .Y(sum_i[2]) );
  INVX0_RVT U31 ( .A(n25), .Y(n32) );
  AND2X1_RVT U32 ( .A1(n59), .A2(n66), .Y(n60) );
  INVX1_RVT U33 ( .A(n24), .Y(n59) );
  AND2X1_RVT U34 ( .A1(n9), .A2(n42), .Y(n25) );
  OR2X1_RVT U35 ( .A1(n41), .A2(n26), .Y(sum_i[3]) );
  AND2X1_RVT U36 ( .A1(n27), .A2(n40), .Y(n26) );
  AND2X1_RVT U37 ( .A1(n32), .A2(n63), .Y(n75) );
  INVX1_RVT U38 ( .A(n42), .Y(n66) );
  AND2X1_RVT U39 ( .A1(n29), .A2(n28), .Y(n73) );
  AND2X1_RVT U40 ( .A1(n74), .A2(n75), .Y(n39) );
  AND2X1_RVT U41 ( .A1(reg2[3]), .A2(reg1[3]), .Y(n76) );
  OR2X1_RVT U42 ( .A1(reg1[3]), .A2(reg2[3]), .Y(n77) );
  AND2X1_RVT U43 ( .A1(n30), .A2(n77), .Y(n38) );
  AND2X1_RVT U44 ( .A1(reg2[1]), .A2(reg1[1]), .Y(n42) );
  OR2X1_RVT U45 ( .A1(reg1[2]), .A2(reg2[2]), .Y(n62) );
  AND2X1_RVT U46 ( .A1(n6), .A2(reg1[2]), .Y(n31) );
  AND2X1_RVT U47 ( .A1(n79), .A2(n80), .Y(n65) );
  INVX0_RVT U48 ( .A(n62), .Y(n33) );
  OR2X1_RVT U49 ( .A1(n65), .A2(n33), .Y(n37) );
  AND2X1_RVT U50 ( .A1(n81), .A2(n82), .Y(n34) );
  OR2X1_RVT U51 ( .A1(n78), .A2(n34), .Y(n35) );
  AND2X1_RVT U52 ( .A1(n59), .A2(n35), .Y(n36) );
  INVX0_RVT U53 ( .A(n65), .Y(n43) );
  AND2X1_RVT U54 ( .A1(n66), .A2(n43), .Y(n47) );
  OR2X1_RVT U55 ( .A1(n78), .A2(n44), .Y(n61) );
  AND2X1_RVT U56 ( .A1(n61), .A2(n3), .Y(n48) );
  AND2X1_RVT U57 ( .A1(n47), .A2(n45), .Y(n46) );
  INVX0_RVT U58 ( .A(n46), .Y(n52) );
  INVX0_RVT U59 ( .A(n47), .Y(n49) );
  AND2X1_RVT U60 ( .A1(n49), .A2(n48), .Y(n50) );
  INVX0_RVT U61 ( .A(n50), .Y(n51) );
  AND2X1_RVT U62 ( .A1(n52), .A2(n51), .Y(sum_i[1]) );
  AND2X1_RVT U63 ( .A1(n3), .A2(n53), .Y(n55) );
  AND2X1_RVT U64 ( .A1(n54), .A2(n78), .Y(n57) );
  AND2X1_RVT U65 ( .A1(c_in), .A2(n55), .Y(n56) );
  OR2X1_RVT U66 ( .A1(n57), .A2(n56), .Y(n58) );
  INVX0_RVT U67 ( .A(n58), .Y(sum_i[0]) );
  AND2X1_RVT U68 ( .A1(n61), .A2(n60), .Y(n68) );
  AND2X1_RVT U69 ( .A1(n63), .A2(n62), .Y(n64) );
  AND2X1_RVT U70 ( .A1(n66), .A2(n65), .Y(n69) );
  OR2X1_RVT U71 ( .A1(n70), .A2(n69), .Y(n67) );
  OR2X1_RVT U72 ( .A1(n69), .A2(n68), .Y(n71) );
  AND2X1_RVT U73 ( .A1(n71), .A2(n70), .Y(n72) );
endmodule


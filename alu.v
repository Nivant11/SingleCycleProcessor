module alu(A, B, OP, Y, C, V, N, Z, BSEL, CSEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP, Y_ADD, Y_SHIFT, Y_LOG, C_ADD, C_SHIFT);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output [7:0]  Y;
  output [7:0]  Y_ADD;
  output [7:0]  Y_SHIFT;
  output [7:0]  Y_LOG;
  output        C;
  output C_ADD;
  output C_SHIFT;
 
  output        V;
  output        N;
  output        Z;

  output BSEL;
  output CSEL; 
  output [1:0] OSEL;
  output SHIFT_LA;
  output SHIFT_LR;
  output LOGICAL_OP;
 
 
  // ADD YOUR CODE BELOW THIS LINE

adder add (
.A(A),
.B((BSEL) ? ~B : B),
.CI(CISEL),
.Y(Y_ADD),
.C(C_ADD),
.V(V)
);

shifter shift (
.A(A),
.LA(SHIFT_LA),
.LR(SHIFT_LR),
.Y(Y_SHIFT),
.C(C_SHIFT)
);

logical log (
.A(A),
.B(B),
.OP(LOGICAL_OP),
.Y(Y_LOG)
);

control con (
.OP(OP),
.BSEL(BSEL),
.CISEL(CISEL),
.OSEL(OSEL),
.SHIFT_LA(SHIFT_LA),
.SHIFT_LR(SHIFT_LR),
.LOGICAL_OP(LOGICAL_OP)
);

wire q = (OSEL == 2'b00);
wire w = (OSEL == 2'b01);
wire e = (OSEL == 2'b10);
assign Y = (q ? Y_ADD : w ? Y_SHIFT : e ? Y_LOG: Y_LOG);
assign C = (OSEL == 2'b00) ? C_ADD : (OSEL == 2'b01) ? C_SHIFT : 2'b0;
assign N = (Y[7:4] > 4'b0111);
assign Z = (Y[7:0]==8'b00000000);


  // ADD YOUR CODE ABOVE THIS LINE


endmodule
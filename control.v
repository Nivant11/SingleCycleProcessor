module control(OP, BSEL, CISEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other inputs and outputs here

// inputs (add others here)
input [2:0] OP;

// outputs (add others here)
output BSEL;
output CISEL;
output [1:0] OSEL;
output SHIFT_LA;
output SHIFT_LR;
output LOGICAL_OP;

// reg and internal variable definitions
wire q = (OP==3'b000 | OP ==3'b001);
wire w = (OP==3'b010 | OP==3'b011 | OP ==3'b100);
wire e = (OP==3'b101 | OP ==3'b110);
assign BSEL = OP[0];
assign CISEL = OP[0];
assign OSEL = (q ? 2'b00 : w ? 2'b01 : e ? 2'b10: q);
assign SHIFT_LA = (OP==3'b010);
assign SHIFT_LR = OP[1];
assign LOGICAL_OP = OP[0];


// implement module here (add other control signals below)


endmodule

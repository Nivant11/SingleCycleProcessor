module registerFile(CLK, SA, SB, LD, DR, D_in, DataA, DataB, RESET);

input CLK;
input RESET;
input [2:0] SA;
input [2:0] SB;
input LD;
input [2:0] DR;
input [7:0] D_in;

output [7:0] DataA;
output [7:0] DataB;

reg [7:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;

//Assigning DataA based on the value of SA
assign DataA = (SA == 3'b0) ? reg0 :
					(SA == 3'b001) ? reg1 :
					(SA == 3'b010) ? reg2 :
					(SA == 3'b011) ? reg3 :
					(SA == 3'b100) ? reg4 :
					(SA == 3'b101) ? reg5 :
					(SA == 3'b110) ? reg6 :
					(SA == 3'b111) ? reg7 : 0;
	
//Assigning DataB based on the value of SB					
assign DataB = (SB == 3'b0) ? reg0 :
					(SB == 3'b001) ? reg1 :
					(SB == 3'b010) ? reg2 :
					(SB == 3'b011) ? reg3 :
					(SB == 3'b100) ? reg4 :
					(SB == 3'b101) ? reg5 :
					(SB == 3'b110) ? reg6 :
					(SB == 3'b111) ? reg7 : 0;

always @(posedge CLK) begin
if(RESET) begin
reg0<=8'b0;
reg1<=8'b0;
reg2<=8'b0;
reg3<=8'b0;
reg4<=8'b0;
reg5<=8'b0;
reg6<=8'b0;
reg7<=8'b0;
end
else if(LD) begin
	case(DR)
		3'b000: reg0<=D_in;
		3'b001: reg1<=D_in;
		3'b010: reg2<=D_in;
		3'b011: reg3<=D_in;
		3'b100: reg4<=D_in;
		3'b101: reg5<=D_in;
		3'b110: reg6<=D_in;
		3'b111: reg7<=D_in;
	endcase
end
end
					
endmodule

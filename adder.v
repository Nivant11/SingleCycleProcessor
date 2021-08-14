module adder(A, B, CI, Y, C, V); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input [7:0] B;
  input CI;

  // outputs
  output  reg [7:0] Y;
  output reg C;
  output reg V;
  reg CI1;
  reg CI2;
  reg CI3;
  reg CI4;
  reg CI5;
  reg CI6;
  reg CI7;
  reg CI8;
 
always @(*)
	begin
		Y[0] = CI ^ A[0] ^ B[0];
		CI1 = (CI & A[0])|(CI & B[0])|(A[0] & B[0]);
		Y[1] = CI1^ A[1] ^ B[1];
		CI2 =(CI1 & A[1])|(CI1 & B[1])|(A[1] & B[1]);
		Y[2] =CI2 ^ A[2] ^ B[2];
		CI3 = (CI2 & A[2])|(CI2 & B[2])|(A[2] & B[2]);
		Y[3] = CI3 ^ A[3] ^ B[3];
		CI4 = (CI3 & A[3])|(CI3 & B[3])|(A[3] & B[3]);
		Y[4] = CI4 ^ A[4] ^ B[4];
		CI5 = (CI4 & A[4])|(CI4 & B[4])|(A[4] & B[4]);
		Y[5] = CI5 ^ A[5] ^ B[5];
		CI6 = (CI5 & A[5])|(CI5 & B[5])|(A[5] & B[5]);
		Y[6] = CI6 ^ A[6] ^ B[6];
		CI7 = (CI6 & A[6])|(CI6 & B[6])|(A[6] & B[6]);
		Y[7] = CI7 ^ A[7] ^ B[7];
		C = (CI7 & A[7])|(CI7 & B[7])|(A[7] & B[7]);
		V = (CI7==C) ? 0:1;
end


endmodule

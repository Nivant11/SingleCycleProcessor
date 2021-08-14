module shifter(A, LA, LR, Y, C);

  // inputs
input [7:0] A;
input LA, LR;
 
  // outputs
output reg [7:0] Y;
output reg C;


  // reg and internal variable definitions

 
  // implement module here
   always @(*)
	begin
		if (LA==0 & LR==1)
			begin
			Y = {1'b0, A[7:1]};
			C = A[0];
			end

	else if (LA==0 & LR==0)
		begin
		Y = {A[6:0], 1'b0};
		C = A[7];
		end

	else
		begin
		Y = {A[7], A[7:1]};
		C = A[0];
		end

	end
endmodule

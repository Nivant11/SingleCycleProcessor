module two_to_one_mux(S0, S1, Q, select);

input [7:0] S0;
input [7:0] S1;
input select;

output [7:0] Q;

assign Q = (select == 0) ? S0 : S1;

endmodule
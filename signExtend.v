module signExtend(S, Q);

input [5:0] S;

output [7:0] Q;

assign Q = {S[5], S[5], S[5:0]};

endmodule
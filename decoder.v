module decoder(INST, DR, SA, SB, IMM, MB, FS, MD, LD, MW, BS, OFF, HALT);

input [15:0] INST;


output reg [2:0] DR;
output reg [2:0] SA;
output reg [2:0] SB;
output reg [5:0] IMM;
output reg [3:0] FS;
output reg [3:0] BS;
output reg [5:0] OFF;
output reg HALT;
output reg MB;
output reg MD;
output reg LD;
output reg MW;

always @(INST) begin

//NOP and HALT instruction
if(INST[15:12] == 4'b0000)begin
//NOP instruction
if(INST[2:0] == 3'b000)begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	IMM <= 6'b0;
	FS <= 3'b0;
	MB <= 1'b0;
	OFF <= 6'bx;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	HALT<=1'b0;
	BS <= 3'b100;
end
//HALT instruction
else if(INST[2:0] == 3'b001)begin
	HALT <= 1'b1;
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	OFF <= 6'bx;
	IMM <= 6'b0;
	FS <= 3'b0;
	MB <= 1'b0;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	BS <= 3'b100;
end
else begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	OFF <= 6'bx;
	IMM <= 6'b0;
	FS <= 3'b0;
	MB <= 1'b0;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	BS <= 3'b100;
	HALT<=1'b0;
end
end	

//I-type
else if(INST[15] == 0 && INST[14:12] != 3'b000)begin //begin I-type

//Load Byte (LB)
if(INST[15:12] == 4'b0010) begin
	IMM <= {INST[5:0]};
	DR <= 	INST[8:6];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'b1;
	LD <= 1'b1;
	MW <= 1'b0;
	BS <= 3'b100;
	OFF <= 6'bx;
	FS <= 3'b0;
	MD <= 1'b1;
	HALT<=1'b0;
end

//Store Byte (SB)
else if(INST[15:12] == 4'b0100) begin
	IMM <= {INST[5:0]};
	DR <= 3'bx;
	SA <= INST[11:9];
	SB <= INST[8:6];
	MB <= 1'b1;
	OFF <= 6'bx;
	LD <= 1'b0;
	MW <= 1'b1;
	FS <= 3'b0;
	MD <= 1'bx;	
	BS <= 3'b100;
	HALT<=1'b0;
end

//Add Immediate (ADDI)
else if(INST[15:12] == 4'b0101) begin
	IMM <= INST[5:0];
	DR <= INST[8:6];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'b1;
	LD <= 1'b1;
	MW <= 1'b0;
	FS <= 3'b0;
	OFF <= 6'bx;
	BS <= 3'b100;
	HALT<=1'b0;
	MD <= 1'b0;
end

//And Immediate (ANDI)
else if(INST[15:12] == 4'b0110) begin
	IMM <= {INST[5:0]};
	DR <= INST[8:6];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'b1;
	OFF <= 6'bx;
	LD <= 1'b1;
	MW <= 1'b0;
	FS <= 3'b101;
	MD <= 1'b0;
	BS <= 3'b100;
	HALT<=1'b0;
end

//Or immediate (ORI)
else if(INST[15:12] == 4'b0111) begin
	IMM <= {INST[5:0]};
	DR <= INST[8:6];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'b1;
	OFF <= 6'bx;
	LD <= 1'b1;
	MW <= 1'b0;
	FS <= 3'b110;
	MD <= 1'b0;
	BS <= 3'b100;
	HALT<=1'b0;
end	

else begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	IMM <= 6'b0;
	FS <= 3'b0;
	MB <= 1'b0;
	OFF <= 6'bx;
	BS <= 3'b100;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	HALT<=1'b0;
end

end //end I-type


//R-type
else if(INST[15:12] == 4'b1111) begin //begin R-type

//ADD
if(INST[2:0] == 3'b0)begin
	FS <= 3'b0;
	IMM <= 6'bx;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= INST[8:6];
	MB <= 1'b0;
	BS <= 3'b100;
	LD <= 1'b1;
	HALT<=1'b0;
	OFF <= 6'bx;
	MW <= 1'b0;
	MD <= 1'b0;
end

//SUB
else if(INST[2:0] == 3'b001) begin
	FS <= 3'b001;
	IMM <= 6'bx;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= INST[8:6];
	MB <= 1'b0;
	OFF <= 6'bx;
	BS <= 3'b100;
	LD <= 1'b1;
	MW <= 1'b0;	
	MD <= 1'b0;
	HALT<=1'b0;
end

//Shift right arithmetic (SRA)
else if(INST[2:0] == 3'b010) begin
	FS <= 3'b010;
	IMM <= 6'bx;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'bx;
	LD <= 1'b1;
	HALT<=1'b0;
	OFF <= 6'bx;
	MW <= 1'b0;
	BS <= 3'b100;
	MD <= 1'b0;
end

//Shift right logical (SRL)
else if(INST[2:0] == 3'b011) begin
	FS <= 3'b011;
	IMM <= 6'bx;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= 3'bx;
	OFF <= 6'bx;
	MB <= 1'bx;
	BS <= 3'b100;
	LD <= 1'b1;
	HALT<=1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
end

//Shift left logical (SLL)
else if(INST[2:0] == 3'b100) begin
	FS <= 3'b100;
	IMM <= 6'bx;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= 3'bx;
	MB <= 1'bx;
	LD <= 1'b1;
	MW <= 1'b0;
	OFF <= 6'bx;
	HALT<=1'b0;
	BS <= 3'b100;
	MD <= 1'b0;
end

//AND
else if(INST[2:0] == 3'b101) begin
	FS <= 3'b101;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= INST[8:6];
	IMM <= 6'bx;
	OFF <= 6'bx;
	MB <= 1'b0;
	LD <= 1'b1;
	MW <= 1'b0;
	MD <= 1'b0;
	BS <= 3'b100;
	HALT<=1'b0;
end

//OR
else if(INST[2:0] == 3'b110) begin
	FS <= 3'b110;
	DR <= INST[5:3];
	SA <= INST[11:9];
	SB <= INST[8:6];
	IMM <= 6'bx;
	OFF <= 6'bx;
	MB <= 1'b0;
	LD <= 1'b1;
	MW <= 1'b0;
	MD <= 1'b0;
	BS <= 3'b100;
	HALT<=1'b0;
end

else begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	IMM <= 6'b0;
	FS <= 3'b0;
	MB <= 1'b0;
	LD <= 1'b0;
	BS <= 3'b100;
	MW <= 1'b0;
	HALT<=1'b0;
	MD <= 1'b0;
	OFF <= 6'b0;
end

end //end R-type

//begin Branches
else if(INST[15:14] == 2'b10) begin

//BEQ - Branch Equal
if(INST[15:12] == 4'b1000) begin
	DR <= 3'bx;
	SA <= INST[11:9];
	SB <= INST[8:6];
	IMM <= 6'bx;
	FS<=3'b001;
	BS<=3'b0;
	HALT<=1'b0;
	MB<=1'b0;
	LD = 1'b0;
	MW = 1'b0;
	MD = 1'b0;
	OFF <= INST[5:0];
end

//BNE - Branch Not Equal
else if (INST[15:12] == 4'b1001) begin
	DR <= 3'bx;
	SA <= INST[11:9];
	SB <= INST[8:6];
	IMM <= 6'bx;
	FS<=3'b001;
	BS<=3'b001;
	HALT<=1'b0;
	MB<=1'b0;
	LD = 1'b0;
	MW = 1'b0;
	MD = 1'b0;
	OFF <= INST[5:0];
end

//BGEZ - Branch greater than or equal to 0 (ALU subtract from 0)
else if(INST[15:12] == 4'b1010) begin
	DR <= 3'bx;
	SA <= INST[11:9];
	SB <= 3'bx;
	IMM <= 6'b0;
	FS<=3'b001;
	BS<=3'b010; //check if it is not negative
	HALT<=1'b0;
	MB<=1'b1;
	LD = 1'b0;
	MW = 1'b0;
	MD = 1'b0;
	OFF <= INST[5:0];
end

//BLTZ - Branch less than zero (ALU subtract from 0)
else if(INST[15:12] == 4'b1011) begin
	DR <= 3'bx;
	SA <= INST[11:9];
	SB <= 3'bx;
	IMM <= 6'b0;
	FS<=3'b001;
	BS<=3'b011;
	HALT<=1'b0;
	MB <=1'b1;
	LD = 1'b0;
	MW = 1'b0;
	MD = 1'b0;
	OFF <= INST[5:0];
end

//latch catch
else begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	IMM <= 6'b0;
	FS <= 3'b0;
	BS <= 3'b0;
	HALT<=1'b0;
	MB <= 1'b0;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	OFF <= 6'b0;
end

end //end branches

else begin
	DR <= 3'b0;
	SA <= 3'b0;
	SB <= 3'b0;
	IMM <= 6'b0;
	FS <= 3'b0;
	BS <= 3'b0;
	HALT<=1'b0;
	MB <= 1'b0;
	LD <= 1'b0;
	MW <= 1'b0;
	MD <= 1'b0;
	OFF <= 6'b0;
end
end 


endmodule

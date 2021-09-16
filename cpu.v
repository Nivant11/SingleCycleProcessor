module cpu(CLK, RESET, EN_L, Iin, Din, PC, NextPC, DataA, DataB, DataC, DataD, MW);
  input         CLK;
  input         RESET;
  input         EN_L;
  input  [15:0] Iin;
  input  [7:0]  Din;
  
  output [7:0]  PC;
  output [7:0]  NextPC;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output        MW;
  
  reg [7:0] PC;
  //reg [7:0] NextPC;
  wire MW;
  
  
  //variables needed for the register file
  wire [2:0] DR;
  wire [2:0] SA;
  wire [2:0] SB;

  //using a separate module for sign extension
  wire [5:0] IMM;
  wire [8:0] IMMext;
  
  //other signals
  wire [2:0] FS;
  wire [2:0] BS;
  wire HALT, MB, MD, LD, H, Z, N, MP; //all the one bit signals
  reg EN_LPrev;
  wire [5:0] OFF;
  wire [7:0] OFFext;
  wire [7:0] OFFshift;
  assign OFFshift = {OFFext[6:0], 1'b0};
  //the value that comes out of the MB mux
  wire [7:0] MBResult;
  
  //Halt Logic
  wire HaltCondition;
  assign HaltCondition = HALT & (!EN_L & EN_LPrev);
  //This is the BS Mux
  assign MP = (BS == 3'b000) ? Z : (BS == 3'b001) ? ~Z : (BS == 3'b010) ? ~N : (BS == 3'b011) ? N : (BS == 3'b100) ? 1'b0:1'b0;
  //deals with incrementation and the EN_L signal
  always @(posedge CLK) begin
  EN_LPrev <= EN_L;
  if(RESET) PC <= 8'b0;
  else PC <= NextPC;
  end
  //This is the PC incrementing MUX
  assign NextPC = (HaltCondition) ? PC : ((MP) ? (PC+2+OFFshift) : (PC+2));

	//the decoder
	decoder decoder (
	.INST(Iin),
	.DR(DR),
	.SA(SA),
	.SB(SB),
	.IMM(IMM),
	.FS(FS),
	.BS(BS),
	.OFF(OFF),
	.HALT(HALT),
	.MB(MB),
	.MD(MD),
	.LD(LD),
	.MW(MW)
	);
	
	//the register file - outputs DataA and DataB
	registerFile regFile (
	.CLK(CLK),
	.SA(SA),
	.SB(SB),
	.LD(LD),
	.DR(DR),
	.D_in(DataC),
	.DataA(DataA),
	.DataB(DataB),
	.RESET(RESET)
	);
	
	//provides the sign extended value for IMM
	signExtend IMMExtend (
	.S(IMM),
	.Q(IMMext)
	);
	
	//provides sign extension for the offset
	signExtend OFFextend(
	.S(OFF),
	.Q(OFFext)
	);
	
	//the MB mux
	two_to_one_mux MBMux(
	.S0(DataB),
	.S1(IMMext),
	.select(MB),
	.Q(MBResult)
	);
	
	//the alu - DataD is passed from the cpu into the data ram from main.v
	alu alu(	
	.A(DataA),
	.B(MBResult),
	.OP(FS),
	.Y(DataD),
	.Z(Z),
	.N(N)
	);	
	
	//the MDMux - Din comes from the dram and is wired into cpu.v in main.v
	two_to_one_mux MDmux (
	.S0(DataD),
	.S1(Din),
	.select(MD),
	.Q(DataC)
	);

endmodule

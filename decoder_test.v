// Prelab 3b test

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps

// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or wires; only internal signals are needed
module decoder_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [15:0] INST;

  // for all of your wire pins, declare them as type wire so ModelSim can display them
  wire [2:0]  DR;
  wire [2:0]  SA;
  wire [2:0]  SB;
  wire [5:0]  IMM;
  wire		    MB;
  wire [2:0]  FS;
  wire 		    MD;
  wire		    LD;
  wire		    MW;

  reg  [2:0]  DR_REF;
  reg  [2:0]  SA_REF;
  reg  [2:0]  SB_REF;
  reg  [5:0]  IMM_REF;
  reg 		    MB_REF;
  reg  [2:0]  FS_REF;
  reg  		    MD_REF;
  reg 		    LD_REF;
  reg 		    MW_REF;

  decoder dec(
      .INST(INST),
      .DR(DR),
      .SA(SA),
      .SB(SB),
      .IMM(IMM),
      .MB(MB),
      .FS(FS),
      .MD(MD),
      .LD(LD),
      .MW(MW)
  );

  // variables for tracking stats
  integer totalTests;
  integer numTestsFailed;

  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin

    numTestsFailed = 0;
    totalTests = 0;
    #100;

    //-------------------------------------------------------------------
    // Test #1
    //-------------------------------------------------------------------
    INST =    16'b0;
    DR_REF =  3'b0;
    SA_REF =  3'b0;
    SB_REF =  3'b0;
    IMM_REF = 6'b0;
    MB_REF =  1'b0;
    FS_REF =  3'b0;
    MD_REF =  1'b0;
    LD_REF =  1'b0;
    MW_REF =  1'b0;

    #100;

    $display("MSIM> NOP INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

    //-------------------------------------------------------------------
    // ADD YOUR OWN TESTS BELOW
    //-------------------------------------------------------------------
	// Test 2
		//This would simulate a subtract instruction (r-type)
		INST = 16'b1111001101101001;
		DR_REF =  3'b101;	//RD
		SA_REF =  3'b001;	//RS
		SB_REF =  3'b101;	//RT
		IMM_REF = 6'bx;
		MB_REF =  1'b0;
		FS_REF =  3'b001; // subtract function
		MD_REF =  1'b0; // use the value coming out of the ALU
		LD_REF =  1'b1; // we are loading into register RD 
		MW_REF =  1'b0; // we are not writing to memory
		#100;

    $display("MSIM> SUBTRACT INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

	 //TEST 3
		//simulate a load byte insTRUCTION
		INST = 16'b0010010110110001;
		DR_REF =  3'b110; //RT
    SA_REF =  3'b010; //RS	
    SB_REF =  3'bx; //Dont care about this
    IMM_REF = 6'b110001; //IMM value (6 rightmost bits)
    MB_REF =  1'b1; // we use the IMM value so MB = 1
    FS_REF =  3'b0; //add function to add the IMM + RS
    MD_REF =  1'b1; //We want the value from memory so MD = 1
    LD_REF =  1'b1; //We are loading into a register, so LD = 1
    MW_REF =  1'b0; //We are not writing to memory, so MW = 0
	 #100;

    $display("MSIM> LOAD BYTE INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

	 //TEST 4
	 //simulate a STORE BYTE insTRUCTION
	 INST = 16'b0100101111001010;	
	 DR_REF =  3'bx; //not storing the Register file, so we dont care
    SA_REF =  3'b101; //this is the register value being added to the immediate in order to get the memory address, RS
    SB_REF =  3'b111; //the register file to reference, RT
    IMM_REF = 6'b001010; //the IMM value specified in the insTRUCTION
    MB_REF =  1'b1; //we are using the immediate value, so MB = 1
    FS_REF =  3'b0; //the Add function
    MD_REF =  1'bx; // we dont care about the value coming out of the memory
    LD_REF =  1'b0; //not storing to the register file
    MW_REF =  1'b1; // we are writing to the memory, so MW = 1
	 
	 #100;

    $display("MSIM> STORE BYTE INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 5
	 //simulate an ADDI instruction 
	 INST = 16'b0101110001110100;
	 DR_REF =  3'b001; //write to RT
    SA_REF =  3'b110; //use RS
    SB_REF =  3'bx; // we are not using any other register, so we dont care
    IMM_REF = 6'b110100; //the given immediate value
    MB_REF =  1'b1; // we are using the immediate, so MB = 1
    FS_REF =  3'b0; //add function
    MD_REF =  1'b0; //not using the memory value
    LD_REF =  1'b1; //we are loading to RT
    MW_REF =  1'b0; //we are not writing to memory
	 #100;

    $display("MSIM> ADDI INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 6
	 //simulate an ANDI instruction 
	 INST = 16'b0110111000101011;
	 DR_REF =  3'b0; //write to RT
    SA_REF =  3'b111; //AND with RS
    SB_REF =  3'bx; //dont care about any other values
    IMM_REF = 6'b101011; //given IMM
    MB_REF =  1'b1; // use the IMM
    FS_REF =  3'b101; // AND function
    MD_REF =  1'b0; //use the value from the ALU
    LD_REF =  1'b1; //we are loading into RT
    MW_REF =  1'b0; //we are not writing to memory
	 #100;

    $display("MSIM> ANDI INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

	 //TEST 7
	 //simulate an ORI instruction
	 INST = 16'b0111100100101101;
	 DR_REF =  3'b100; // store into RT
    SA_REF =  3'b100; //OR with RS
    SB_REF =  3'bx;//dont care about any other values
    IMM_REF = 6'b101101; //given IMM
    MB_REF =  1'b1;//use the IMM
    FS_REF =  3'b110;//OR function
    MD_REF =  1'b0;//Use the value from the ALU
    LD_REF =  1'b1;//loading into RT
    MW_REF =  1'b0;//not writing to memory
	 #100;

    $display("MSIM> ORI INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

	 //TEST 8
	 //simulate an ADD insTRUCTION
	 INST = 16'b1111011110001000;
	 DR_REF =  3'b001; //storing into RD
    SA_REF =  3'b011; //first addend is RS
    SB_REF =  3'b110; //second addend is RT
    IMM_REF = 6'bx; //dont care what the IMM is, not going to use it
    MB_REF =  1'b0; //dont use the IMM
    FS_REF =  3'b0; //ADD function
    MD_REF =  1'b0; //Use the value from the ALU
    LD_REF =  1'b1; //load into the RD register
    MW_REF =  1'b0; //not writing to memory

    #100;

    $display("MSIM> ADD INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 9
	 //simulate a Shift right arithmetic insTRUCTION
	 INST = 16'b1111000110010010;
	 DR_REF =  3'b010; //storing into RD
    SA_REF =  3'b000; //we are shifting RS
    SB_REF =  3'bx; //we dont care about any other register value
    IMM_REF = 6'bx; //we are not using the immediate in a shift
    MB_REF =  1'bx; //dont care which value we pick
    FS_REF =  3'b010; //sra function
    MD_REF =  1'b0; //pick the value from the ALU
    LD_REF =  1'b1; //loading back into RD
    MW_REF =  1'b0; //not writing to memory

    #100;

    $display("MSIM> SRA INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 10
	 //simulate a shift right logical instruction 
	 INST = 16'b1111000110010011;
	 DR_REF =  3'b010; //storing into RD
    SA_REF =  3'b000; //we are shifting RS
    SB_REF =  3'bx; //we dont care about any other register value
    IMM_REF = 6'bx; //we are not using the immediate in a shift
    MB_REF =  1'bx; //dont care which value we pick
    FS_REF =  3'b011; //srl function
    MD_REF =  1'b0; //pick the value from the ALU
    LD_REF =  1'b1; //loading back into RD
    MW_REF =  1'b0; //not writing to memory


    #100;

    $display("MSIM> SRL INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;

	 //TEST 11
	 //simulate Shift left logical instruction 
	 INST = 16'b1111000110010100;
	 DR_REF =  3'b010; //storing into RD
    SA_REF =  3'b000; //we are shifting RS
    SB_REF =  3'bx; //we dont care about any other register value
    IMM_REF = 6'bx; //we are not using the immediate in a shift
    MB_REF =  1'bx; //dont care which value we pick
    FS_REF =  3'b100; //sll function
    MD_REF =  1'b0; //pick the value from the ALU
    LD_REF =  1'b1; //loading back into RD
    MW_REF =  1'b0; //not writing to memory


    #100;

    $display("MSIM> SLL INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 12
	 //simulate AND insTRUCTION
	INST = 16'b1111000110010101;
	 DR_REF =  3'b010; // store in RD
    SA_REF =  3'b000; //first value is in RS
    SB_REF =  3'b110; //second value is in RT
    IMM_REF = 6'bx; //dont use the IMM
    MB_REF =  1'b0; //use the SB value
    FS_REF =  3'b101; //AND function
    MD_REF =  1'b0; //Use the value out of the ALU
    LD_REF =  1'b1; //load into RD
    MW_REF =  1'b0; //not writing to memory

    #100;

    $display("MSIM> AND INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
	 //TEST 13
	 //simulate an OR instruction 
	 INST = 16'b1111001010100110;
	 DR_REF =  3'b100; //store in RD
    SA_REF =  3'b001; //first value is in RS
    SB_REF =  3'b010; //second value is in RT
    IMM_REF = 6'bx; //dont care about IMM
    MB_REF =  1'b0; //use the SB value
    FS_REF =  3'b110; //OR function
    MD_REF =  1'b0; //use the value out of the ALU
    LD_REF =  1'b1; //we are loading
    MW_REF =  1'b0; //not writing to memory

    #100;

    $display("MSIM> OR INSTRUCTION");
    $display("MSIM> #%2d", totalTests);

    // print a different message depending on whether this is a
    // register-to-register (r2r) or immediate (imm) instruction
    if (INST[15] == 1)
      $display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
    else
      $display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);

    $display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
    $display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
    $display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
    $display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
    $display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL");
    $display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL");
    $display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL");
    $display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL");
    $display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL");

    if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF) ||
       (MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
    begin
      numTestsFailed = numTestsFailed + 1;
    end

    totalTests = totalTests + 1;
	 
    //-------------------------------------------------------------------
    // END OF TESTS
    //-------------------------------------------------------------------

    // print final score
    $display("MSIM> ");
    $display("MSIM> Prelab 3a Score: %2d / %2d", totalTests-numTestsFailed, totalTests);

    // Once our tests are done, we need to tell ModelSim to explicitly stop once we are
    // done with all of our test cases.
    $stop;
  end

endmodule

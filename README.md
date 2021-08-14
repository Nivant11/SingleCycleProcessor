# SingleCycleProcessor
This is all of the parts of a standard single cycle processor implemented in verilog.

Some of the modules represent their own components, like the decoder, the register file, etc. Some of the components are just coded into main.v, like the halt logic and PC counter.
This processor has the ability to execute standard I-type and R-type instructions (see the decoder for details).

You can use this code in any way you wish. You do need to create an instruction RAM and a clock signal.

I executed this code on an intel FPGA board.

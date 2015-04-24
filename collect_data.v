module collect_data(clk_adc,enable,reset,finished,data_in,data_out,read_busy);

input clk_adc,enable,reset;
output finished;

input [13:0] data_in;
wire rdreq; // 1 allow for reading
input read_busy;
wire allow_in = ~read_busy && ~rdempty;
assign rdreq = allow_in; // will allow to be read when the reader is currently on and the fifo is not empty


output [7:0] data_out;

fifo myfifo(.data(data_in[13:6]), 
	.wrreq(wrreq), // write enalbe
	.wrclk(clk_adc),
	.wrfull(wrfull), 
	.wrempty(wrempty), 
	.q(data_out), .rdreq(rdreq), .rdclk(clk), .rdempty(rdempty));

// The flash ADC side starts filling the fifo only when it is completely empty,
// and stops when it is full, and then waits until it is completely empty again
reg fillfifo;

always @(posedge clk_adc)
if(~fillfifo) // if it is 0, wich means 
  fillfifo <= wrempty; // start when empty // used in write clock domain: if empty : fillfifo will be 1,
else
  fillfifo <= ~wrfull; // stop when full

assign wrreq = fillfifo; // will allow to be written when it is not full : 



endmodule
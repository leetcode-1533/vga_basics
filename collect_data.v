module collect_data(clk_adc,clk,enable,reset,finished,data_in,data_out,read_busy);

input clk_adc,enable,reset,clk; // enable, reset is not implmented
output finished;//finished is not implemented

input [13:0] data_in;
wire rdreq; // 1 allow for reading
input read_busy;
wire allow_in = ~read_busy && ~rdempty;
assign rdreq = allow_in; // will allow to be read when the reader is currently on and the fifo is not empty


output [7:0] data_out;

wire [7:0] vga_data = (data_in >> 7)-4; // 14 bits to 8 bits: 6 bits to go it rangs from 127 to 0 : going to implement to module here

fifo myfifo(.data(vga_data), 
	.wrreq(wrreq), // write enalbe
	.wrclk(clk_adc),
	.wrfull(wrfull), 
	.wrempty(wrempty), 
	.q(data_out), .rdreq(rdreq), .rdclk(clk), .rdempty(rdempty));

// The flash ADC side starts filling the fifo only when it is completely empty,
// and stops when it is full, and then waits until it is completely empty again
reg fillfifo;

always @(posedge clk_adc)
if(~fillfifo) // if it is 0, wich means not allowed to be wirtten
  fillfifo <= wrempty; // start when empty // used in write clock domain: if empty : fillfifo will be 1,
else
  fillfifo <= ~wrfull; // stop when full

assign wrreq = fillfifo; // will allow to be written when it is not full : 



endmodule
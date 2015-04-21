module clear(CounterX,CounterY,color,clk,lock);

input clk,lock;

output reg [7:0] CounterX,CounterY;
output [11:0] color = {12{rambuffer}};

wire [14:0] address;

wire rambuffer;

wire CounterXmaxed = (CounterX==8'b10011111); // 159
wire CounterYmaxed = (CounterY==8'b01110111); // 119

assign address = CounterX + CounterY * 160;

ram_background ram_entity(
	.address(address),
	.clock(clk),
	.wren(1'b0),
	.q(rambuffer));

//module ram_background (
//	address,
//	clock,
//	data,
//	wren,
//	q);
//
//	input	[14:0]  address;
//	input	  clock;
//	input	[0:0]  data;
//	input	  wren;
//	output	[0:0]  q;


always @(posedge clk)
begin
if(lock == 0)
	CounterX <= 0;
if(CounterXmaxed)
  CounterX <= 0;
else
  CounterX <= CounterX + lock;
end

always @(posedge clk )
begin
if(lock == 0)
	CounterY <= 0;
	
if(CounterXmaxed)
begin
	if(CounterYmaxed)
		CounterY <= 0;
	else
	CounterY <= CounterY + lock;
end
end

endmodule
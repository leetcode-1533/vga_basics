module vga_sin(CounterX,CounterY,color,clk,lock);

input clk;
input lock;

output reg [7:0] CounterX;
output [11:0] color = 12'hFFF;
output [7:0] CounterY;

reg [14:0] address;

wire rambuffer;

wire CounterXmaxed = (CounterX==8'b10011111); // 159

sin_test sin_entity(
	.address(CounterX),
	.clock(clk),
	.wren(1'b0),
	.q(CounterY));
	
	
always @ (posedge clk)
begin
if(lock == 0)
	CounterX <= 0;
	
if(CounterXmaxed)
  CounterX <= 0;
else
  CounterX <= CounterX + lock;
end

endmodule
module vga_sin(CounterX,CounterY,color,clk);

input clk;

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
if(CounterXmaxed)
  CounterX <= 0;
else
begin
  CounterX <= CounterX + 1;
end
end

endmodule
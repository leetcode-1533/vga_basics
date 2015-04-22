module vga_sin(CounterX,CounterY,color,clk,lock,adc);



wire rambuffer;
input clk;
input lock;

input [13:0] adc;

output reg [7:0] CounterX;
output [11:0] color = 12'hF00;
output [7:0] CounterY;
wire CounterXmaxed = (CounterX==8'b10011111); // 159

//sin_test sin_entity(
//	.address(CounterX),
//	.clock(clk),
//	.wren(1'b0),
//	.q(CounterY));
//	
assign CounterY = adc[13:6];

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
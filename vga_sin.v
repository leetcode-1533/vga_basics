// module vga_sin(CounterX,color,clk,enable,reset,finished);
 module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished);
//module vga_sin(CounterX,adc,CounterY,color,clk,enable,reset,finished);

input clk;
input enable,reset;

output finished;
output reg [7:0] CounterX;
output [11:0] color;
 
assign color = 12'hF00; // color to be drawn

wire CounterXmaxed = (CounterX==8'd159); // 159
assign finished = (CounterXmaxed==1);

always @(posedge clk)
begin
	if(reset == 1)
		CounterX <= 0;
	else
	begin
	if(CounterXmaxed)
	  	CounterX <= 0;
	else if(enable == 1)
	  	CounterX <= CounterX + 1;
	 end
end

// endmodule

// output CounterY;
// input [7:0] adc;
// assign CounterY = adc;


output [7:0] CounterY;
sin_test sin_entity(
	.address(CounterX),
	.clock(clk),
	.wren(1'b0),
	.q(CounterY));

endmodule
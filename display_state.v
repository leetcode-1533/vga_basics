module display_state(CounterX,CounterY,color,clk,k);

parameter n = 25000;
input clk;

output reg [7:0] CounterX,CounterY;
output reg [11:0] color;

wire [7:0] CounterX1,CounterY1,CounterX2,CounterY2;
wire [11:0] color1, color2;


//reg clear_state,sin_state;

input k;

clear clear_entity(
	.CounterX(CounterX1),
	.CounterY(CounterY1),
	.color(color1),
	.clk(clk),
	.lock(1));
	
vga_sin sin_entity(
	.CounterX(CounterX2),
	.CounterY(CounterY2),
	.color(color2),
	.clk(clk),
	.lock(1));

always @ (posedge clk)
begin
	if (k == 0)
	begin
		CounterX = CounterX2;
		CounterY = CounterY2;
		color = color2;
	end
	else
	begin
		CounterX = CounterX1;
		CounterY = CounterY1;
		color = color1;
	end		
end

//always @ (clk)
//for(k=0;k < n; k = k+1)
//begin
//if (k <= 19199)
//// clear first 
//begin
//	clear_state = 1;
//	sin_state = 0;
//	CounterX = CounterX1;
//	CounterY = CounterY1;
//	color = color1;
//end
//
//// draw sin_wave
//else if( k < 19359)
//begin
//	clear_state = 0;
//	sin_state = 1;
//	CounterX = CounterX1;
//	CounterY = CounterY1;
//	color = color1;
//end
//
//// do nothing,
//end

endmodule
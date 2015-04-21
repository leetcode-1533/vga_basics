module display_state(CounterX,CounterY,color,clk);

parameter n = 25000000;
input clk;

output [7:0] CounterX,CounterY;
output [11:0] color;


reg clear_state,sin_state;

integer k;

clear_entity clear(
	.CounterX(CounterX),
	.CounterY(CounterY),
	.color(color),
	.clk(clk),
	.lock(clear_state));
	
sin_entity vga_sin(
	.CounterX(CounterX),
	.CounterY(CounterY),
	.color(color),
	.clk(clk),
	.lock(sin_state));
	
always @ (clk)
for(k=0;k < n; k = k+1)
begin
if (k <= 19199)
// clear first 
begin
	clear_state <= 1;
	sin_state <= 0;	
end

// draw sin_wave
else if( k < 19359)
begin
	clear_state <= 0;
	sin_state <= 1;

end

// do nothing,
end

endmodule
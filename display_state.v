module display_state(CounterX,CounterY,color,clk,adc,man_in);

parameter n = 25000;
input clk;
input [13:0] adc;
input man_in;

output reg [7:0] CounterX,CounterY;
output reg [11:0] color;

wire [7:0] CounterX1,CounterY1,CounterX2,CounterY2;
wire [11:0] color1, color2;



//reg clear_state,sin_state;

integer k=0;
reg [1:0] state;
reg clear_lock,sin_lock;

clear clear_entity(
	.CounterX(CounterX1),
	.CounterY(CounterY1),
	.color(color1),
	.clk(clk));
	
vga_sin sin_entity(
	.CounterX(CounterX2),
	.CounterY(CounterY2),
	.color(color2),
	.clk(clk),
	.lock(sin_lock),
	.adc(adc));

always @ (posedge clk)
begin
	if(man_in == 0)
	begin
		k = k + 1;
		if(k >= 500000) //50HZ
			k = 0;
		if(k <= 19199)//draw background
			state <= 2'b00;
		else if(k <= 19359)
			state <= 2'b01;
		else
			state <= 2'b11;
	end
	else
		state <= 2'bzz;
end

always @ (state)
	case(state)
		00:
		begin
			clear_lock <= 1;
			sin_lock <= 0;
			CounterX = CounterX1;
			CounterY = CounterY1;
			color = color1;
		end
		01:
		begin
			clear_lock <= 0;
			sin_lock <= 1;		
			CounterX = CounterX2;
			CounterY = CounterY2;
			color = color2;		
		end
		default:
		begin
			clear_lock <= 0;
			sin_lock <= 0;
			CounterX = 8'bzzzz_zzzz;
			CounterY = 8'bzzzz_zzzz;
			color <= 12'bzzzz_zzzz_zzzz;
		end
	endcase

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
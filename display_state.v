// module display_state(CounterX,CounterY,color,clk,clk_en,rst_n);
module display_state(CounterX,CounterY,color,clk,clk_en,rst_n,adc_data,clk_adc);

input clk;
input clk_en,rst_n;//clk_en is not implemented

output reg [7:0] CounterX,CounterY;
output reg [11:0] color;

// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished);
// module clear(CounterX,CounterY,clk,reset,enable,finished,color);
wire [7:0] CounterX_clear,CounterY_clear,CounterX_sin,CounterY_sin;
wire [11:0] color_clear, color_sin;
reg enable_clear,enable_sin,reset_clear,reset_sin,enable_delay,reset_delay;
wire finished_clear,finished_sin,finished_delay;


clear clear_module(
	.CounterX(CounterX_clear),
	.CounterY(CounterY_clear),
	.color(color_clear),
	.clk(clk),
	.enable(enable_clear),
	.reset(reset_clear),
	.finished(finished_clear));

// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished,clk_adc,adc_data);
input [13:0] adc_data;
input clk_adc;
vga_sin sin_module(
	.CounterX(CounterX_sin),
	.CounterY(CounterY_sin),
	.color(color_sin),
	.clk(clk),
	.enable(enable_sin),
	.reset(reset_sin),
	.finished(finished_sin),
	.clk_adc(clk_adc),
	.adc_data(adc_data));

delay delay_module(
	.clk(clk), 
	.enable(enable_delay),
	.reset(reset_delay), 
	.finished(finished_delay));
//	defparam delay_module.cycle ='d10008;

parameter [1:0] clear_screen = 2'b00, draw_line = 2'b01,do_nothing = 2'b10;
reg [1:0] state,next_state;

initial begin
	state = clear_screen;
end

always @ (posedge clk)
begin
	if(rst_n == 1)
		state <= clear_screen;
	else
		state <= next_state;
end

always @ * // combinational circuit
	case(state)
		clear_screen:
		begin
			reset_clear = 0;
			enable_clear = 1;

			enable_sin = 0;
			reset_sin = 1;

			enable_delay = 0;
			reset_delay = 1;

			CounterX = CounterX_clear;
			CounterY = CounterY_clear;
			color = color_clear;
			if(finished_clear == 0)
				next_state = clear_screen;
			else
				next_state = draw_line;
		end 
		draw_line:
		begin
			reset_sin = 0;
			enable_sin = 1;

			enable_clear = 0;
			reset_clear = 1;
			

			CounterX = CounterX_sin;
			CounterY = CounterY_sin;
			color = color_sin;
			if(finished_sin == 0)
				next_state = draw_line;
			else
				next_state = do_nothing;
		end
		do_nothing:
		begin
			enable_delay = 1;
			reset_delay = 0;

			enable_clear = 0;
			reset_clear = 1;

			enable_sin = 0;
			reset_sin = 1;

			CounterX = 8'bzzzz_zzz;
			CounterY = 8'bzzzz_zzz;
			color = 12'bzzz_zzz_zzz_zzz;
			if(finished_delay == 0)
				next_state = do_nothing;
			else	
				next_state = clear_screen;
		end 
	endcase

endmodule

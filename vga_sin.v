module vga_sin(CounterX,color,clk,enable,reset,finished);
// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished);
// module vga_sin(CounterX,CounterY,color,clk,enable,reset,finished,clk_adc,adc_data);


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

// module collect_data(clk_adc,enable,reset,finished,data_in,data_out,read_busy);
// input clk_adc;
// input [13:0] adc_data;

// output [7:0] CounterY;

// // for the moment, the fifo will read the data when the drawer is off continously until full. The word length is not
// // correct as well, it 128 instead of 120.. Going to implmented the trigger after testing the adc
// //module collect_data(clk_adc,clk,enable,reset,finished,data_in,data_out,read_busy);

// collect_data fifo_entity(
// 	.clk_adc(clk_adc),
// 	.clk(clk),
// 	.data_in(adc_data),
// 	.data_out(CounterY), 
// 	.read_busy(~enable)); //"when enabled it is busy to draw on the screen, usually, enable is the opposite of reset and finifhsed
	
endmodule
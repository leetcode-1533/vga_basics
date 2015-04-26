// module ramfill(clk_adc,enable,reset,finfished,adc_data,vga_data);
module ramfill(clk_adc,enable,reset,finished,adc_data,vga_data,CounterX);

input clk_adc;
input enable,reset;
input [7:0] adc_data;

output finished;
output [7:0] vga_data;

// build a 160 counter
output reg [7:0] CounterX;

wire CounterXmaxed = (CounterX==8'd159); // 159
assign finished = (CounterXmaxed==1);

always @(posedge clk_adc)
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

endmodule
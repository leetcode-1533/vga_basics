module ramfill(clk_adc,enable,reset,finfished,adc_data,vga_data);

input clk_adc;
input enable,reset;
input [7:0] adc_data;

output finished;
output [7:0] vga_data;

reg [7:0] data_reg[159:0];
// build a 160 counter

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

endmodule
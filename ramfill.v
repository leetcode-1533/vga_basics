// module ramfill(clk_adc,enable,reset,finfished,adc_data,vga_data);
module ramfill(clk_adc,enable,reset,r_finished,adc_data,CounterX,clk);

input clk_adc,clk;
input enable,reset;
input [7:0] adc_data;
wire w_finished;

output reg r_finished;

// build a 160 counter
output reg [7:0] CounterX;

wire CounterXmaxed = (CounterX==8'd159); // 159
assign w_finished = (CounterXmaxed==1);

reg prolong_finished = 0;
always @(posedge w_finished)
begin
	prolong_finished = prolong_finished + 1;
end

reg previous_signal;
always @(posedge clk) // flip flop
begin
	r_finished <= previous_signal ^ prolong_finished;
	previous_signal <= prolong_finished;
end



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
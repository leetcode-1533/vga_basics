// module ramfill(clk_adc,enable,reset,finfished,adc_data,vga_data);
module ramfill(clk_adc,enable,reset,r_finished,adc_data,CounterX,clk,write_enable);

input clk_adc,clk;
input enable,reset;
input [13:0] adc_data;
output reg write_enable;
output reg r_finished;


wire last_bit_data = adc_data[13];
reg previous_adc_data;

// wait until trigger happen
always @ (posedge clk_adc)
begin
	previous_adc_data <= last_bit_data;
	if(enable == 1)
	begin
		if(Trigger == 1) // unchanged until enable returns to 0.
			write_enable <= 1;
	end
	else
		write_enable <= 0;
end

reg Threshold1, Threshold2;
always @(posedge clk_adc) Threshold1 <= (adc_data>=14'b10_000_000_000_000);
always @(posedge clk_adc) Threshold2 <= Threshold1;

wire Trigger = Threshold1 & ~Threshold2;  // if positive edge, trigger! 


// sync clocks
reg prolong_finished = 0;
always @(posedge w_finished)
begin
	prolong_finished = prolong_finished + 1;
end

reg previous_signal;
always @(posedge clk) // flip flop
begin
	previous_signal <= prolong_finished; 
	r_finished <= previous_signal ^ prolong_finished;
	// or with its previous value.
end


// build a 160 counter
output reg [7:0] CounterX;

wire CounterXmaxed = (CounterX==8'd159); // 159
wire w_finished;
assign w_finished = (CounterXmaxed==1);


always @(posedge clk_adc)
begin
	if(reset == 1)
		CounterX <= 0;
	else
	begin
	if(CounterXmaxed)
	  	CounterX <= 0;
	else if(write_enable == 1)
	  	CounterX <= CounterX + 1;
	end
end

endmodule
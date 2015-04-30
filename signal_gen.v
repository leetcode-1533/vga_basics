module sign_gen(clk_dac,value,enable,reset,finished,switch);

input clk_dac;
input enable,reset;
output finished;


// 4 ram block with different initial momeory.
sin_test sin_entity(
	.address(CounterX),
	.clock(clk_dac),
	.wren(1'b0), 
	.q(val1));

sin_test1 sin_entity1(
	.address(CounterX),
	.clock(clk_dac),
	.wren(1'b0), 
	.q(val2));

sin_test2 sin_entity2(
	.address(CounterX),
	.clock(clk_dac),
	.wren(1'b0), 
	.q(val3));

sin_test3 sin_entity3(
	.address(CounterX),
	.clock(clk_dac),
	.wren(1'b0), 
	.q(val4));




input switch;
reg [1:0] re_switch;

wire [13:0] val1,val2,val3,val4;
output reg [13:0] value;

initial
begin
	re_switch <= 'b00;
end

always @ (posedge switch)
	re_switch <= re_switch + 1'b1;

always @ *
	case(re_switch)
	'b00:
	value = val1;
	'b01:
	value = val2;
	'b10:
	value = val3;
	'b11:
	value = val4;
	endcase






reg [9:0] CounterX;
// a 1024 counter
// module vga_sin(CounterX,color,clk,enable,reset,finished,read_CounterX,time_division);
wire CounterXmaxed = (CounterX=='d1023); // samples 1024
wire finished;
assign finished = (CounterXmaxed==1);


always @(posedge clk_dac)
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
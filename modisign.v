module modisign(adc_data,vga_data);

input [13:0] adc_data;
output [7:0] vga_data;

assign vga_data = (adc_data >> 7)-4;

endmodule
function signal_generator(outfname)
%105.3khz

% Depth is 2014, word length is  2^14.
% The DAC frequency is 108Mhz.
dac_freq = 100*10^6;
display(['for length of ',num2str(1024),'the frequency is ',num2str(dac_freq/1024)])
t = linspace(0,2*pi,1024);
y = gen_y(t)  - 0.01;

y = y./max(abs(y)); % in the range of -1 to 1


shift = 2^13-1;
y = int32(y*shift);
y = y + shift;

%0->8191*2

rows = length(y);

fid = fopen(outfname,'w');

fprintf(fid,'-- %3ux%d 1bit sine values\n\n',rows,ceil(log2(double(max(y)))));
fprintf(fid,'WIDTH = %d;\n',ceil(log2(double(max(y)))));
fprintf(fid,'DEPTH = %4u;\n\n',rows);
fprintf(fid,'ADDRESS_RADIX = UNS;\n');
fprintf(fid,'DATA_RADIX = UNS;\n\n');
fprintf(fid,'CONTENT BEGIN\n');
count = 0;
for r = 1:rows
    fprintf(fid,'%4u : %4u;\n',count, y(r));
    count = count + 1;
end
fprintf(fid,'END;');
fclose(fid);

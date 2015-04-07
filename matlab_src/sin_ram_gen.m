function sin_ram_gen(outfname)

t = linspace(0,2*pi,160);
y = sin(t);
y = int16(y*59);
y = y + 59;	%0->158

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

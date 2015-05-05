% code for generating initialzing file from image
function imgscaled = miffilegen(infile, outfname, numrows, numcols)
%miffilegen('photo.jpg','test.mif',120,160) generate black and white image.

img = imread(infile);
bw = im2bw(img,0.5);

imgresized = imresize(bw, [numrows numcols]);

[rows, cols, ~] = size(imgresized);

imgscaled = imgresized;
imshow(imgscaled*16);

fid = fopen(outfname,'w');

fprintf(fid,'-- %3ux%3u 1bit image color values\n\n',rows,cols);
fprintf(fid,'WIDTH = 1;\n');
fprintf(fid,'DEPTH = %4u;\n\n',rows*cols);
fprintf(fid,'ADDRESS_RADIX = UNS;\n');
fprintf(fid,'DATA_RADIX = UNS;\n\n');
fprintf(fid,'CONTENT BEGIN\n');
imshow(imgscaled);
count = 0;
for r = 1:rows
    for c = 1:cols
%         red = uint16(imgscaled(r,c,1));
%         green = uint16(imgscaled(r,c,2));
%         blue = uint16(imgscaled(r,c,3));
%         color = red*(256) + green*16 + blue;
        fprintf(fid,'%4u : %4u;\n',count, imgscaled(r,c));
        count = count + 1;
    end
end
fprintf(fid,'END;');
fclose(fid);

return

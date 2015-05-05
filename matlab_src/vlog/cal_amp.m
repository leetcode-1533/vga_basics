function amp = cal_amp(shift,num)
% code for calculating amplitude

switch shift
    case '0000'
        fb = 7;
    case '0001'
        fb = 8;
    case '0010'
        fb = 9;
    case '0011'
        fb = 10;
    case '0100'
        fb = 6;
    case '1000'
        fb = 5;
    case '1100'
        fb = 4;
end

bitleft = 12 - fb;
amp = (num*20*2)/(2^(bitleft+1)-1);


        
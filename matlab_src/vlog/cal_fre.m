function fw = cal_fre(sampling_rate,jumping,number_wave)
% code for calculating frequency
switch sampling_rate
    case '10'
        fs = 13.5*10^6;
    case '01'
        fs = 54*10^6;
    case {'11','00'}
        fs = 27*10^6;
end

switch jumping
    case '00'
        kj = 1;
    case '01'
        kj = 2;
    case '10'
        kj = 3;
    case '11'
        kj = 4;
end

fw = number_wave * fs /(kj*160);
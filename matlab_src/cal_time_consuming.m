x = 160;
y = 120;
f = 25*10^6;
t = 1/f;

screen_time = t*x*y;
line_time = t*x;


freq = 48;
one_hz_time = 1/freq;
disp(['to draw a whole screen:',num2str(screen_time) ]);
disp(['to draw a whole line:',num2str(line_time) ]);
disp(['to delay at ',num2str(freq),'hz. 25Mhz needed(positive edge): ',num2str(one_hz_time/t),'. bit needed ',num2str(ceil(log2(one_hz_time/t)))]);
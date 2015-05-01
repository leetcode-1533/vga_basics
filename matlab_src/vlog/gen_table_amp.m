shift = {'0000','0001','0010','0011','0100','1000','1100'};

for i = 1:7
        str_temp = '';
        for k = 1 : 3 
            temp(k) =  cal_amp(shift{i},k);
        end
        for k =  1: 3
            str_temp = strcat(str_temp,num2str(temp(k)),'&');
        end
        str_temp(end) ='';
        str_temp = strcat(str_temp,'\\ \hline');
        str_temp = strcat(shift{i},'&',str_temp)
end


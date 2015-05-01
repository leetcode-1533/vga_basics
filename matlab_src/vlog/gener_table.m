jumping = {'00','01','10','11'};
sampling_rate = {'10','01','11'};

for i = 1:3
    for j = 1:4
        str_temp = '';
        for k = 1 :10
            temp(k) =  cal_fre(sampling_rate{i},jumping{j},k);
        end
        max(temp)
        for k =  1: 10
            str_temp = strcat(str_temp,num2str(temp(k)),'&');
        end
        str_temp(end) ='';
        str_temp = strcat(str_temp,'\\ \hline');
        str_temp = strcat(sampling_rate{i},'&',jumping{j},'&',str_temp);
    end
end

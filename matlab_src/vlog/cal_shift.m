% code for calculating shift
tk = [1];
original = repmat(tk,1,13);
display('the original center')
bi2de(original)

for i = 3:11
    now_center = bi2de(original(1:end-i));
    if now_center-60 > 0
        bit_needed=ceil(log2(now_center)+1);
        sign = 'plus';
    else
        bit_needed=ceil(log2(60- now_center));
        sign = 'negative';
    end
    display(['shift by ',num2str(i),', to bias it ',sign,' ',num2str(now_center-59)])
end
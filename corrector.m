function s = corrector(dataword,prev_state)
  s = 1;
  dataword = strrep(dataword, ' ', '');
  dataword = strrep(dataword, '[', '');
  dataword = strrep(dataword, ']', '');
  p = length(dataword);

  data_arr = [];
for i = 1:p
    data_arr = [data_arr, str2num(dataword(i))];
end

 if(length(prev_state) <= p)
     return;
 end

  o = prev_state(2:p+1);
  new = floor(o./8);
  final = new - data_arr;
  value = sum(final);
if(value == 0)
    s=1;
else
    s=0;
end    

return
end
    




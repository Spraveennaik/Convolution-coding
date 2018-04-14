% This function is used to generate errors in codewords
% The actual codeword is sent as arguement for which 1 bit,2 bit and 3 bit
% errors are introduced and are stored in 3 different matrices.

function [dt1,dt2,dt3,cr1,cr2,cr3] = errgenerator(dataword,ch,dt1,dt2,dt3,cr1,cr2,cr3)
   pt = [];
for i = 1:length(ch)-1                   % Generate codewords with 2 bit errors
   for p = i+1:length(ch)
    x = ch;
    x(i) = ~(x(i));
    x(p) = ~(x(p));
    pt = [ pt; x];
    x =[];
end
end


  nt = [];
 for p = 1:length(ch)                   % Generate codewords with 1 bit error
    x = ch;
    x(p) = ~(x(p));
    nt = [ nt; x];
    x =[];
 end
   
   
  mt =[];
for j = 1:length(ch)-2                  % Generate codewords with 3 bit error
for i = j+1:length(ch)-1
   for p = i+1:length(ch)
    x = ch;
    x(i) = ~(x(i));
    x(j) = ~(x(j));
    x(p) = ~(x(p));
    mt = [ mt; x]; 
   end
end
end


 %calling decode function to correct 1 bit error codeword
 
for  i1=1:length(nt(:,1))    
  [errr, prev_state, index, err1] = decode_seq(nt(i1,:), [], 1, [0], 0);  % function call to decode the codeword
 %  disp(prev_state);
 %  disp(i1)
   corr1 = corrector(dataword,prev_state); % function call to check whether the codewords are correct
   cr1 = cr1 + corr1;
 %  disp(cr1);
   dt1 = dt1 + err1;
 %  disp(dt1);
end
 
% calling decode function to correct 2 bit error codeword

for i1=1:length(pt(:,1))    
   [errr, prev_state, index, err2] = decode_seq(pt(i1,:), [], 1, [0], 0); % function call to decode the codeword 
 %   disp(prev_state);
     corr2 = corrector(dataword,prev_state); % function call to check whether the codewords are correct
   cr2 = cr2 + corr2;
 %   disp(cr2);
   dt2 = dt2 + err2 ;
 %  disp(dt2);
end
 
% calling decode function to correct 3 bit error codeword

for i1=1:length(mt(:,1))   
    [err, prev_state, index, err3] = decode_seq(mt(i1,:), [], 1, [0], 0); % function call to decode the codeword
 %  disp(prev_state);
   corr3 = corrector(dataword,prev_state); % function call to check whether the codewords are correct
   cr3 = cr3 + corr3;
 %  disp(cr3);
    dt3 = dt3 +err3;
 %  disp(dt3);

end

end


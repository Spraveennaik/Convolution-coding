% MATLAB code for generating codeword for all binary combinations
% of 5 bit dataword and introducing errors to codewords then decoding the
% codeword using sequential decoding technique and generating a graph for
% error detection and error correction percentage upto 3 bit errors. 


function convolution
for i=0:31  %STORE ALL 32 BITS
    s(i+1,:) = de2bi(i,5);
end
  dt1 = 0;
  dt2 = 0;
  dt3 = 0;
  cr1 = 0;
  cr2 = 0;
  cr3 = 0;
  s = [ s(:,5) s(:,4) s(:,3) s(:,2)  s(:,1)];
  % disp('THE CODE WORDS ARE')
  for j=0:31
  k=mat2str(s(j+1,:));
  [dt1,dt2,dt3,cr1,cr2,cr3] = convoencode(k,dt1,dt2,dt3,cr1,cr2,cr3);    % calling a function for encoding the datawords
  end
  
  corr=[cr1/576  cr2/4896  cr3/26115];
  er = [dt1/576  dt2/4896  dt3/26115];
  graph(corr,er)
  
end  

% function is used for encoding the datawords

function [dt1,dt2,dt3,cr1,cr2,cr3] = convoencode(n,dt1,dt2,dt3,cr1,cr2,cr3) 
% n=input('ENTER THE BITS FOR CONVOLUTION ENCODING--','s');
  dataword = n;
  chas=[];
for i = 1:length(n)
    chas = [chas;n(i)];
end
  a = (de2bi(str2num(chas)));
  len=length(a);
  r=zeros(1,5);
for i=1:1:len
    for j=4:-1:1
        r(j+1)=r(j);
    end
    r(1)=a(i);
    g1(i)=xor(xor(r(1),r(2)),r(4));
    g2(i)=xor(xor(r(1),r(2)),r(3));
end
for k=len+1:1:len+5
    for j=4:-1:1
        r(j+1)=r(j);
    end
    r(1)=0;
    g1(k)=xor(xor(r(1),r(2)),r(4));
    g2(k)=xor(xor(r(1),r(2)),r(3));
end

  out=zeros(1,2*(len+4));
  b=1;
for l=1:1:len+4
    for m=1:1:2
        
    if(mod(b,2)==0)
        out(2*l)=g2(l);
    else
        out(2*l-1)=g1(l);
    end
    b=b+1;
    end
end
%calling a function to generate error in codewords
   [dt1,dt2,dt3,cr1,cr2,cr3] = errgenerator(dataword,out,dt1,dt2,dt3,cr1,cr2,cr3);
end


%calling a function to generate error in codewords

function [dt1,dt2,dt3,cr1,cr2,cr3] = errgenerator(dataword,ch,dt1,dt2,dt3,cr1,cr2,cr3)
   pt = [];
for i = 1:length(ch)-1                  % Generate codewords with 2 bit errors
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
for j = 1:length(ch)-2                  % Generate codewords with 3 bit errors
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
  [errr, prev_state, index, err1] = decode_seq(nt(i1,:), [], 1, [0], 0);
 %  disp(prev_state);
 %  disp(i1)
   corr1 = corrector(dataword,prev_state);
   cr1 = cr1 + corr1;
 %  disp(cr1);
   dt1 = dt1 + err1;
 %  disp(dt1);
 end

 %calling decode function to correct 2 bit error codeword
 
for i1=1:length(pt(:,1))    
   [errr, prev_state, index, err2] = decode_seq(pt(i1,:), [], 1, [0], 0);
 %   disp(prev_state);
     corr2 = corrector(dataword,prev_state);
   cr2 = cr2 + corr2;
 %   disp(cr2);
   dt2 = dt2 + err2 ;
 %  disp(dt2);
end
 
 %calling decode function to correct 3 bit error codeword
 
for i1=1:length(mt(:,1))   
    [err, prev_state, index, err3] = decode_seq(mt(i1,:), [], 1, [0], 0);
 %  disp(prev_state);
   corr3 = corrector(dataword,prev_state);
   cr3 = cr3 + corr3;
 %  disp(cr3);
    dt3 = dt3 + err3;
 %  disp(dt3);

end

end

% The decoder function which decodes the codewords and returns the decoded
%  dataword.
%At the caller function, err_bit=[], index=1, prev_state=[0]

function [err_bit, prev_state, index, error] = decode_seq(code_wd, err_bit, index, prev_state, error)
    %disp(prev_state);
    curr_state = prev_state(length(prev_state));
    next_state = [floor(curr_state/2), floor(curr_state/2)+8];
    curr_code = zeros(2);
    for i = 1:2
        curr_code(i) = 2*(bitxor(bitxor(floor(next_state(i)/8), mod(floor(next_state(i)/4),2)), mod(next_state(i),2)));
        curr_code(i) = curr_code(i) + bitxor(bitxor(floor(next_state(i)/8), mod(floor(next_state(i)/4),2)), mod(floor(next_state(i)/2),2));
    end
    
    if(index > length(code_wd))
        %disp(prev_state);
       return;
    end
    
    if(curr_code(1) == code_wd(index)*2+code_wd(index+1))
        prev_state = [prev_state, next_state(1)];
        index = index + 2;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            prev_state = c;
            index = index1;
            err_bit = b;
            error = d;
            return;
        end
        err_bit = [err_bit, 2];
        prev_state = [prev_state, next_state(2)];
        error = 1;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            err_bit = b;
            return;
        end
  
    elseif(curr_code(2) == code_wd(index)*2+code_wd(index+1))
        prev_state = [prev_state, next_state(2)];
        index = index + 2;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            err_bit = b;
            error = d;
            prev_state = c;
            return;
        end
        err_bit = [err_bit, 2];
        prev_state = [prev_state, next_state(1)];
        error = 1;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            error = d;
            err_bit = b;
            return;
        end
        
    else
        prev_state = [prev_state, next_state(1)];
        index = index + 2;
        error = 1;
        err_bit = [err_bit, 1];
        if(sum(err_bit) > 5)
            err_bit = [err_bit(1:length(err_bit)-1), []];
            l = length(prev_state);
            prev_state = [prev_state(1:l-1), []];
            index = index - 2;
            return;
        end
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            err_bit = b;
            error = d;
            prev_state = c;
            return;
        end
        prev_state = [prev_state, next_state(2)];
        index = index + 2;
        error = 1;
        err_bit = [err_bit, 1];
        if(sum(err_bit) > 5)
            err_bit = [err_bit(1:length(err_bit)-1), []];
            l = length(prev_state);
            prev_state = [prev_state(1:l-1), []];
            index = index - 2;
            return;
        end
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            error = d;
            err_bit = b;
            return;
        end
    end
    err_bit = [err_bit(1:length(err_bit)-1), []];
    l = length(prev_state);
    prev_state = [prev_state(1:l-1), []];
    index = index - 2;
    return;
end


% corrector function checks whether the actual dataword and the decoded
% dataword from sequential decoder are same or not.

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

% Graph function is used to plot the graph for error correction and error
% correction.

function graph(co,er)

plot ([1 2 3],100*co,'-o')
hold on
plot([1 2 3],100*er,'-o')
axis([0 4 0 110])
xlabel('N bit error')
ylabel('PERCENTAGE')
legend('CORRECTED','ERROR DETECTED')

end
 


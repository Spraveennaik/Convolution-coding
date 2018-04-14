% This function is used for encoding the dataword
% The actual dataword is given as an input for encoding
% generates the codeword


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
   % function call to introduce errors in generated codewords
   [dt1,dt2,dt3,cr1,cr2,cr3] = errgenerator(dataword,out,dt1,dt2,dt3,cr1,cr2,cr3);
end
% mainfunction is the main module of the entire MATLAB code
% This function generates the different combinations of codewords and sends
% them as arguements to convoencode() function which encodes the datawords.

function mainfunction
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
  [dt1,dt2,dt3,cr1,cr2,cr3] = convoencode(k,dt1,dt2,dt3,cr1,cr2,cr3);   %calling convoencode function
  end
  
  % Here the denominator represents Number of combinations of
  % 1 bit,2 bit,3 bit errors for 5 bit dataword combination.
  corr=[cr1/576  cr2/4896  cr3/26115];                                  % attributes for error correction
  er = [dt1/576  dt2/4896  dt3/26115];                                  % Attributes for error detection
  graph(corr,er)                                                        % calling graph() to plot.
  
end  
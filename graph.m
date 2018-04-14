% Graph function is used to plot the graph for error correction and error
% percentage of generated codewords.
% On X-axis, number of errors in codewords
% On Y-axis, Percentage

function graph(co,er)

plot ([1 2 3],100*co,'-o')
hold on
plot([1 2 3],100*er,'-o')
axis([0 4 0 110])
xlabel('N bit error')
ylabel('PERCENTAGE')
legend('CORRECTED','ERROR DETECTED')

end
 
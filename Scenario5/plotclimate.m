a=[6046.806825	2431.922617	3120.690776	2063.678876];
figure(1)


b=[3 9 7 9];

h=bar(a,0.4)
x=get(h,'Xdata');
y=get(h,'Ydata');

for i=1:length(a)
 text(x(i)-0.5,y(i)+200,['Optimal time = ' num2str(b(i))]);   

end

set(gca, 'XTick', 1: 4);
set(gca, 'XTickLabel', {'Phoenix','Atlantic City','Atlanta','Chicago'});
xlabel('Location of the house');
ylabel('Expected optimal NPV ($)');

% figure(2)
% b=[3 9 7 9];
% plot(b,'or', 'markersize' , 10)
% xlabel('Location of the house');
% ylabel('Expected optimal investment time (year)');
% 
% set(gca, 'XTick', 1: 4);
% set(gca, 'XTickLabel', {'Arizona','Atlantic City','Atlanta','Chicago'});

% h=bar([1 2 3]);
% x=get(h,'Xdata');
% y=get(h,'Ydata');
% for xc=1:length(x)
%     text(x,y+0.2,['y=' num2str(y)]);
% end
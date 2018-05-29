function [length] = arclength(data)
% calculate arc lengthes of each stroke and sum them all
n=numel(data);% strokes
l=zeros(n,1);
for i=1:n
    temp=data{i};
    l(i)=sum(sqrt((temp(2:end,1)-temp(1:end-1,1)).^2+(temp(2:end,2)-temp(1:end-1,2)).^2));
end
length=sum(l);


end


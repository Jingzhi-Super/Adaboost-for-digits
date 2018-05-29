function [fld] = FLdistance(data)
% first and last distance feature
n=numel(data);% strokes
d=zeros(n,1);
for i=1:n
    temp=data{i};
    d(i)=distance(temp(1,1),temp(1,2),temp(end,1),temp(end,2));
end
fld=mean(d);


end


function [distance] = fitline(Inkdata)
% fit line feature
n=numel(Inkdata);
distance=zeros(n,1);
for k=1:n
data=Inkdata{k};
x=data(:,1);y=data(:,2);
p=polyfit(x,y,1);
data=[data,zeros(size(data,1),1)];
Q1=[data(1,1),p(1)*data(1,1)+p(2),0];% starting point of a line
Q2=[data(end,1),p(1)*data(end,1)+p(2),0];% ending point of a line
d=zeros(size(data,1),1);
for i=1:size(data,1)
    temp1=data(i,:)-Q1;
    d(i) = norm(cross(Q2-Q1,temp1))/norm(Q2-Q1);
end
distance(k)=sum(d);
end

end


function [newdata] = discard(Inkdata)
% an input point within a very distance of the previous input point is
% discarded
for k=1:numel(Inkdata)
data=Inkdata{k};
x=data(:,1);
y=data(:,2);
dx=x(2:end)-x(1:end-1);
dy=y(2:end)-y(1:end-1);
d=sqrt(dx.^2+dy.^2);
n=size(d,1);
j=1;s=[];
for i=1:n-1
    if d(i) < 0.01
        d(i+1)=d(i+1)+d(i);
        s(j)=i;
        j=j+1;
    end
end
modify=d;
modify(s)=[];
newdata{k,1}=data;
newdata{k,1}(s+1,:)=[];
if modify(end) < 0.01
    newdata{k,1}(end,:)=[];
end
end

end

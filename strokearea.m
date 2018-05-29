function [S] = strokearea(data)
% stroke area feature
n=numel(data);S=zeros(n,1);
for i=1:n
    temp=data{i};
    u=[temp(2:end-1,1)-temp(1,1),temp(2:end-1,2)-temp(1,2)];
    v=[temp(3:end,1)-temp(1,1),temp(3:end,2)-temp(1,2)];
    u(:,3)=zeros(numel(u(:,1)),1);
    v(:,3)=zeros(numel(v(:,1)),1);
    c=cross(u,v);c=c(:,3);
    sarea=sum(0.5*c.*sgn(c));
    S(i)=sarea;
end
S=mean(S);


end


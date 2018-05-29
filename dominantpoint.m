function [result] = dominantpoint(Inkdata)
% dominant point feature
n=numel(Inkdata);
x=[1,0];threshold=3*pi/180;
amax=zeros(n,1);
adev=zeros(n,1);
slr=zeros(n,1);
nzc=zeros(n,1);
for i=1:n
    temp=Inkdata{i};
    points=finddominant(temp);
    beta=zeros(size(points,1),1);
    for j=1:size(points,1)
        beta(j)=acos(dot(x,points(j,:)/norm(points(j,:))));
    end
    amax(i)=max(beta);
    phi=beta(2:end)-beta(1:end-1);
    adev(i)=sum(phi)/size(phi,1);
    slr(i)=sum(phi(abs(phi)<threshold))/size(phi,1);
    crossing=sgn(phi);
    count=0;
    for j=1:size(crossing,1)-1
        if crossing(j)*crossing(j+1)==-1;
            count=count+1;
        end
    end
    nzc(i)=count;
end

result=[amax;adev;slr;nzc];


end


function [c] = curvature(data,n)
% Find curvature by fitting a circle
x=data(:,1);y=data(:,2);
c=zeros(numel(x),1);
f=floor(n/2);% number of points to be fitted
for i=1+f:size(x,1)-f
    beforepart=0;laterpart1=0;laterpart2=0;laterpart3=0;
    for j=i-f:i+f
        beforepart=x(j)*y(j)+beforepart;
        laterpart1=-(x(j)^2+y(j)^2)*x(j)+laterpart1;
        laterpart2=-(x(j)^2+y(j)^2)*y(j)+laterpart2;
        laterpart3=-(x(j)^2+y(j)^2)+laterpart3;
    end
        beforec=[2*sum(x(i-f:i+f).^2),2*beforepart,sum(x(i-f:i+f));
                 2*beforepart,2*sum(y(i-f:i+f).^2),sum(y(i-f:i+f));
                 2*sum(x(i-f:i+f)),2*sum(y(i-f:i+f)),n];
        laterc=[laterpart1;laterpart2;laterpart3];
        abc=beforec\laterc; 
        r=sqrt(abc(1)^2+abc(2)^2-abc(3));
        c(i)=1/r;
end
c(1:f)=c(1+f);
c(isnan(c))=0;
c(end-f+1:end)=c(end-f);
c(c>500)=500;

end
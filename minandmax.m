function [result] = minandmax(Inkdata)
% min and max features
n=numel(Inkdata);
xmax=zeros(n,1);xmin=zeros(n,1);
ymax=zeros(n,1);ymin=zeros(n,1);% number of peaks
sdx=zeros(n,1);edx=zeros(n,1);
sdy=zeros(n,1);edy=zeros(n,1);% starting and ending direction
llcdx=zeros(n,1);
llcdy=zeros(n,1);% length between last change direction and last stroke point
for i=1:n
    temp=Inkdata{i};
    x1=findpeaks(temp(:,1));
    x2=findpeaks(-temp(:,1));
    y1=findpeaks(temp(:,2));
    y2=findpeaks(-temp(:,2));
    xmax(i)=xmax(i)+numel(x1);
    xmin(i)=xmin(i)+numel(x2);
    ymax(i)=ymax(i)+numel(y1);
    ymin(i)=ymin(i)+numel(y2);
    if temp(1,1)>temp(2,1)
        xmax(i)=xmax(i)+1;
    else if temp(1,1)<temp(2,1)
            xmin(i)=xmin(i)+1;
        end
    end
    if temp(1,2)>temp(2,2)
        ymax(i)=ymax(i)+1;
    else if temp(1,2)<temp(2,2)
            ymin(i)=ymin(i)+1;
        end
    end
    if temp(end,1)>temp(end-1,1)
        xmax(i)=xmax(i)+1;
    else if temp(end,1)<temp(end-1,1)
            xmin(i)=xmin(i)+1;
        end
    end
    if temp(end,2)>temp(end-1,2)
        ymax(i)=ymax(i)+1;
    else if temp(end,2)<temp(end-1,2)
            ymin(i)=ymin(i)+1;
        end
    end
    d1=sgn(temp(2:end,1)-temp(1:end-1,1));
    d2=sgn(temp(2:end,2)-temp(1:end-1,2));
    sdx(i)=d1(1);edx(i)=d1(end);
    sdy(i)=d2(1);edy(i)=d2(end);
    lcx=find(d1~=d1(end));
    lcy=find(d2~=d2(end));
    try
        lcx=lcx(end)+1;
        llcdx(i)=abs(temp(end,1)-temp(lcx,1));
    catch
        llcdx(i)=0;
    end
    try
        lcy=lcy(end)+1;
        llcdy(i)=abs(temp(end,2)-temp(lcy,2));
    catch
        llcdy(i)=0;
    end
end
result=[xmin;xmax;sdx;edx;llcdx;ymin;ymax;sdy;edy;llcdy];

end


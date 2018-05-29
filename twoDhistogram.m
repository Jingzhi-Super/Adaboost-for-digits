function [result] = twoDhistogram(data)
% 2D point histogram
n=size(data,1);
table=zeros(9,1);% histogram
data(:,1)=data(:,1)-min(data(:,1));
data(:,2)=data(:,2)-min(data(:,2));
width=max(data(:,1));
height=max(data(:,2));
w=[width;width*2/3;width/3];
h=[height;height*2/3;height/3];
for i=1:n
    if data(i,1)<=w(3) && data(i,2)<=h(1) && data(i,2)>h(2)
        table(1)=table(1)+1;
    else if data(i,1)<=w(2) && data(i,1)>w(3) && data(i,2)<=h(1) && data(i,2)>h(2)
            table(2)=table(2)+1;
    else if data(i,1)<=w(1) && data(i,1)>w(2) && data(i,2)<=h(1) && data(i,2)>h(2)
            table(3)=table(3)+1;
    else if data(i,1)<=w(3) && data(i,2)<=h(2) && data(i,2)>h(3)
            table(4)=table(4)+1;
    else if data(i,1)<=w(2) && data(i,1)>w(3) && data(i,2)<=h(2) && data(i,2)>h(3)
            table(5)=table(5)+1;
    else if data(i,1)<=w(1) && data(i,1)>w(2) && data(i,2)<=h(2) && data(i,2)>h(3)
            table(6)=table(6)+1;
    else if data(i,1)<=w(3) && data(i,2)<=h(3)
            table(7)=table(7)+1;
    else if data(i,1)<=w(2) && data(i,1)>w(3) && data(i,2)<=h(3)
            table(8)=table(8)+1;
    else if data(i,1)<=w(1) && data(i,1)>w(2) && data(i,2)<=h(3)
            table(9)=table(9)+1;
        end
        end
        end
        end
        end
        end
        end
        end
    end
end
result=table/n;


end


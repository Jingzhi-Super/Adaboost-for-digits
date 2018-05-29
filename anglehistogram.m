function [result] = anglehistogram(Inkdata,data)
% angle histogram feature
n=numel(Inkdata);
x=[1,0];
bin=zeros(4,1);
for i=1:n
    temp=Inkdata{i};
    v=temp(2:end,:)-temp(1:end-1,:);
    for j=1:size(v,1)
        theta=acos(dot(x,v(j,:)/norm(v(j,:))));
        if theta<=pi/4
            bin(1)=bin(1)+1;
        else if theta>pi/4 && theta<=pi/2
            bin(2)=bin(2)+1;
        else if theta>pi/2 && theta<=3*pi/4
            bin(3)=bin(3)+1;
        else if theta>3*pi/4 
            bin(4)=bin(4)+1;
            end
            end
            end
        end
    end
end

result=bin/(size(data,1)-2);








end


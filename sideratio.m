function [SR] = sideratio(Inkdata,data)
% side ratio
n=numel(Inkdata);
xl=min(data(:,1));
width=max(data(:,1))-xl;
SR2=zeros(n,2);
for i=1:n
    s=xl-Inkdata{i}(1,1);e=xl-Inkdata{i}(end,1);
    SR2(i,:)=[s/width,e/width];
end
SR=[mean(SR2(:,1));mean(SR2(:,2))];

end


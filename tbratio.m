function [TP] = tbratio(Inkdata,data)
% top and buttom ratio
n=numel(Inkdata);
yt=max(data(:,2));
height=yt-min(data(:,2));
TP2=zeros(n,2);
for i=1:n
    s=yt-Inkdata{i}(1,2);e=yt-Inkdata{i}(end,2);
    TP2(i,:)=[s/height,e/height];
end
TP=[mean(TP2(:,1));mean(TP2(:,2))];

end


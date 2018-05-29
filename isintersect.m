function [intersect_feature] = isintersect(data)
% intersection features
n=numel(data);% strokes
% self intersecting
location=[];
for i=1:n
    temp=data{i};
    s=size(temp,1);
    for j=2:s-2
        [xi,yi]=polyxpoly(temp(1:j,1),temp(1:j,2),temp(j+1:end,1),temp(j+1:end,2));
        if ~(isequal([xi,yi],[temp(j,1),temp(j,2)]))
            location=[location;xi,yi];
        end
    end
end
if n>1
    for i=1:n-1
        for j=i+1:n
            temp1=data{i};
            temp2=data{j};
            [xi,yi]=polyxpoly(temp1(:,1),temp1(:,2),temp2(:,1),temp2(:,2));
            location=[location;xi,yi];
        end
    end
end
location=unique(location,'rows');
number=size(location,1);
if number>0
    for i=1:n
        d1=distance(location(:,1),location(:,2),data{i}(1,1),data{i}(1,2));
        d2=distance(location(:,1),location(:,2),data{i}(end,1),data{i}(end,2));
        dfeature(i,:)=[max([d1;d2]),min([d1;d2])];
    end
    d_feature=[max(dfeature(:,1));min(dfeature(:,1));max(dfeature(:,2));min(dfeature(:,2))];
else
    d_feature=[0;0;0;0];
end
intersect_feature=[number;d_feature];



end


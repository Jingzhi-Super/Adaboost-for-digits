function [cusp_feature] = cusp(data)
% calculate cusps
n=numel(data);% strokes
endpoints=[];% endpoints of each stroke
for i=1:n
    endpoints=[endpoints;data{i}(1,:);data{i}(end,:)];
end
ang=cell(n,1);
for i=1:n
    for j=1:size(data{i},1)-2
        ang{i}(j,1)=interangle(data{i}(j,1),data{i}(j,2),data{i}(j+1,1),...
            data{i}(j+1,2),data{i}(j+1,1),data{i}(j+1,2),data{i}(j+2,1),data{i}(j+2,2));
    end
end 
for i=1:n
    ang{i}(isnan(ang{i}))=0;
    ang{i}(imag(ang{i})~=0)=0;
end
C=cell2mat(ang);% intersection angles between every 3 points
number=numel(C(C>0.6*pi));% number of cusps
dfeature=zeros(n,2);
for i=1:n
    temp=ang{i};
    temp_number=numel(temp(temp>0.6*pi));
    if temp_number>0
        location=data{i}(temp>0.6*pi,:);
        d1=distance(location(:,1),location(:,2),data{i}(1,1),data{i}(1,2));
        d2=distance(location(:,1),location(:,2),data{i}(end,1),data{i}(end,2));
        dfeature(i,:)=[max([d1;d2]),min([d1;d2])];
    end
end
d_feature=[max(dfeature(:,1));min(dfeature(:,1));max(dfeature(:,2));min(dfeature(:,2))];
cusp_feature=[number;d_feature];

end

        




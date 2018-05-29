function [points] = finddominant(data)
% find dominant points in a stroke
c=curvature(data,11);
[~,location1]=findpeaks(c);
[~,location2]=findpeaks(-c);
location=[location1;location2];
location=sortrows(location);
point=[data(1,:);data(location,:);data(end,:)];
points=zeros(size(point,1)*2-1,2);
points(1:2:end,:)=point;
for i=2:2:size(points,1)-1
    points(i,:)=(points(i-1,:)+points(i+1,:))/2;
end




end


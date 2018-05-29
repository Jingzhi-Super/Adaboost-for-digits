function [theta] = interangle(x1,y1,x2,y2,x3,y3,x4,y4)
% calculate angle between two vectors
A=[x2-x1,y2-y1]';
B=[x4-x3,y4-y3]';
theta=acos(A'*B/sqrt(A'*A)/sqrt(B'*B));


end


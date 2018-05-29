function [value] = sgn(xx)
% sgn function
value=xx;
value(value<0)=-1;
value(value==0)=0;
value(value>0)=1;



end


function cmp = colgreycol(col1,col2,n);
% function cmp = colgreycol(col1,col2,n);
% start with col1, go to grey, then to col2.

% 

if nargin<3
  n = length(colormap);
end;

white = [1 1 1]*0.8;
cmp1 = interp1([1;floor(n/2)],[col1;white],1:floor(n/2));
cmp2 = interp1([1;floor(n/2)],[white;col2],1:floor(n/2));

if n/2==floor(n/2)
  cmp = [cmp1;cmp2];
else
  cmp = [cmp1;white;cmp2];
end;


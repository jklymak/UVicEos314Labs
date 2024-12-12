function cmp = threecol(col1,col2,col3,n);
% function cmp = col2col(col1,col2,n);
% start with col1 and go to col2. 
%
% This is most useful with col1 or 2 as a gray or white.

if nargin<4
  n = length(colormap);
end;

n

if n/2 == floor(n/2)
  cmp = interp1([1;(n/2)-1;(n/2);n],[col1;col2;col2;col3],1:n);
else
  cmp = interp1([1;ceil(n/2);n],[col1;col2;col3],1:n);
end;
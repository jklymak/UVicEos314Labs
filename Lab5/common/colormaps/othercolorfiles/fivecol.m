function cmp = threecol(col1,col2,col3,col4,col5,n);
% function cmp = col2col(col1,col2,n);
% start with col1 and go to col2. 
%
% This is most useful with col1 or 2 as a gray or white.

if nargin<6
  n = length(colormap);
end;

n
dx = n/4;
xx = round(linspace(1,n,5));

cmp = interp1(xx,[col1;col2;col3;col4;col5],1:n);

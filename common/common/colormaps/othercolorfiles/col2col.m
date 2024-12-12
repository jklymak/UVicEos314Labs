function cmp = col2col(col1,col2,n);
% function cmp = col2col(col1,col2,n);
% start with col1 and go to col2. 
%
% This is most useful with col1 or 2 as a gray or white.

if nargin<3
  n = length(colormap)
end;

cmp = interp1([1;n],[col1;col2],1:n);
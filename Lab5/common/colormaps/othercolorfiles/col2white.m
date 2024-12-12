function cmp = col2white(col,n);
% function cmp = col2white(col,n);
% start with col and go to white...

if nargin<2
  n = length(colormap);
end;

cmp = interp1([1;n],[col;1 1 1],1:n);
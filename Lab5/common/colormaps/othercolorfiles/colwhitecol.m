function cmp = colwhitecol(col1,col2,n);
% function cmp = col2white(col,n);
% start with col and go to white...

if nargin<3
  n = length(colormap);
end;

cmp1 = interp1([1;floor(n/2)],[col1;1 1 1],1:floor(n/2));
cmp2 = interp1([1;floor(n/2)],[1 1 1;col2],1:floor(n/2));

if n/2==floor(n/2)
  cmp = [cmp1;cmp2];
else
  cmp = [cmp1;1 1 1;cmp2];
end;


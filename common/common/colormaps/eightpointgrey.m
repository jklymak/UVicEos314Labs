function cmp = eightpointgrey(n);
% function cmp = col2white(col,n);
% start with col and go to white...
if nargin<1
  n=size(colormap,1);
end;

nn = floor(n/8);

cc = ([1:4 4:-1:1])'/4*[1 1 1]

cc = 3*cc + 7
cc = cc/10;

cmp = repmat(cc,nn,1);


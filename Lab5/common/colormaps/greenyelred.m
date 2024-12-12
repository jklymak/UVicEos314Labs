function cmp = greenyelred(n);
% function cmp = colgreycol(col1,col2,n);
% start with col1, go to grey, then to col2.

% 

if nargin<1
  n = size(colormap,1);
end;

h = [0.35 0];
s = [1 0.6];
l = [0.3 0.5];

h=interp1([1 n],h,1:n)';
%s=interp1([1 floor(n/2) n],s,1:n)';
s=interp1([1  n],s,1:n)';
l=interp1([1 n],l,1:n)';
cmp = hsl2rgb([h s l]);

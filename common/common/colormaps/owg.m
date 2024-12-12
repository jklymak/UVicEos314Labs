function map = rowgb(nn);%function map = rowgb(nn)% red-orange-white-green-blue colormap with 'nn' entries (default=64)% if nn is odd, center is exactly white.if nargin < 1, nn = size(get(gcf,'colormap'),1); endn1=fix(nn*.3);n2=fix(nn/2) - n1;n2 = fix(nn/2)% make map in HSV coordinatesmap2= [ 0.12*ones(n2,1)     (n2:-1:1)'/n2     ones(n2,1)];map3= [   ones(n2,1)/3      (1:n2)'/n2        ones(n2,1)-.25*(1:n2)'/n2];if( nn == 2*(n1+n2) ),	map = [map2; map3;];else	map = [map2; [0 0 1]; map3];endmap = hsv2rgb(map);
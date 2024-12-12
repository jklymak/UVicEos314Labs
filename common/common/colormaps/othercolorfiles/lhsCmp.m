function cmp = lhsCmp(col,low);
% function cmp = lhsCmp(col,low);

n = length(colormap);
n = 64
[h0,s0,y0] = rgb2hsy(col)


h = [h0 h0];
s = [1 0];
y = [0.4 1]*1; % luminence...

cmp(:,1) = interp1([1 n],h,1:n);
cmp(:,2) = interp1([1 n],s,1:n);
cmp(:,3) = interp1([1 n],y,1:n);

cmp = hsy2rgb(cmp);


  
  
  
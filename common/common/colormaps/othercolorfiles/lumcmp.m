function cmp = lumcmp(col,n);
  
  if nargin<2
    n = size(colormap,1);
  end;
  
  cc = rgb2hsl(col);
  
  h = [cc(1) cc(1)];
  s = [1 0];
  l = [0.25 1];
  
  cmp = interp1([1 n],[h' s' l'],1:n)
  cmp = hsl2rgb(cmp);

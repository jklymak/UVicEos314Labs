function cmp = RedGrayBlue(n);
  
  if nargin<1
    n=size(colormap,1);
  end;
  
  cmp = fivecol([1 0 0]*0.4,[0.9 0.1 0.0],[1 1 1]*0.8,[0. 0.3 1],[0 0 1]*0.4, ...
                n);
  %cmp = fivecol([1 0.0 0]*0.4,[1 0.3 0.0],[1 1 1]*0.7,[0.4 1 0.],[0.4 1 0]*0.4, ...
  %              n);
  cmp = flipud(cmp);
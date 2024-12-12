function cmp = RedGrayBlue(n,gray);
  
  if nargin<1
    n=size(colormap,1);
  end;
  if nargin<2
    gray = 0.8;
  end;
  
  
  cmp = fivecol([1 0 0]*0.4,[0.9 0.1 0.0],[1 1 1]*gray,[0. 0.3 1],[0 0.3 1]*0.4, ...
                n);
  %cmp = fivecol([1 0.0 0]*0.4,[1 0.3 0.0],[1 1 1]*0.7,[0.4 1 0.],[0.4 1 0]*0.4, ...
  %              n);
  
  c = [[1 0 0]*0.4;
       [0.9 0.1 0.0];
       [1 0.8 0.8]*gray;
       [1 1 1]*gray;
       [0.8 0.8 1]*gray;
       [0. 0.3 1];
       [0 0 1]*0.4];
  
  shoulder = 0.15
  p = [0 shoulder 0.4 0.5  0.6 1-shoulder 1]*(n-1)+1;
  
  cmp =interp1(p,c,1:n);
  
  
  cmp = flipud(cmp);
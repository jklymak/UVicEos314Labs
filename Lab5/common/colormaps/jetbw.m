function J = jetbw(m)%jetbw :	Variant of HSV.%	jetbw(M), a variant of JET(M). Goes black->blue->red->white%  instead of grey->blue->red->black.%	jetbw, by itself, is the same length as the current colormap.%	Use colormap(jetbw).if nargin < 1, m = size(get(gcf,'colormap'),1); endn = max(ceil(m/4),1);x = (1:n)'/n;e = ones(length(x),1);y = (2:2:n)'/n;r = [0*y; 0*e; x; e; ones(length(y),1)];g = [0*y; x; e; flipud(x); y];b = [y; e; flipud(x); 0*e; y];J = [r g b];while size(J,1) > m   J(1,:) = [];   if size(J,1) > m, J(size(J,1),:) = []; endend
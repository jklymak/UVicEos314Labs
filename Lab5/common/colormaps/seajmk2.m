function cmp = sea(vargin);
% cmp = sea(vargin);

%	@(#)GMT_sealand.cpt	1.1  03/19/99
%
% Colortable for ocean and land with break at sealevel
% Designed by W.H.F. Smith, NOAA
% COLOR_MODEL = HSV

if nargin==1
  len=vargin
else
  len=length(colormap)
end;

load seajmk2data
ind =1:size(dat,1)';

cmp = interp1(ind/max(ind),dat,[1:len]/len);

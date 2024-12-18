function cmp = land(vargin);
% cmp = land(vargin);
% 

%	@(#)GMT_sealand.cpt	1.1  03/19/99
%
% Colortable for ocean and land with break at sealevel
% Designed by W.H.F. Smith, NOAA
% COLOR_MODEL = HSV

if nargin==1
  len=vargin;
else
  len=length(colormap);
end;

X=[
-8000	0	0	0	-7000	0	5	25
-7000	0	5	25	-6000	0	10	50
-6000	0	10	50	-5000	0	80	125
-5000	0	80	125	-4000	0	150	200
-4000	0	150	200	-3000	86	197	184
-3000	86	197	184	-2000	172	245	168
-2000	172	245	168	-1000	211	250	211
-1000	211	250	211	0	250	255	255
0	70	120	50	500	120	100	50
500	120	100	50	1000	146	126	60
1000	146	126	60	2000	198	178	80
2000	198	178	80	3000	250	230	100
3000	250	230	100	4000	250	234	126
4000	250	234	126	5000	252	238	152
5000	252	238	152	6000	252	243	177
6000	252	243	177	7000	253	249	216
7000	253	249	216	8000	255	255	255];
[M,N]=size(X);
X(:,1)=X(:,1)+0.01;
X(:,5)=X(:,5)-0.01;
X = reshape(X',N/2,M*2)';
x=X(:,1);
in = find(x>=0);
x=x(in);
hsv_ = X(in,2:4)/255;
newx=min(x)+(max(x)-min(x))*((0:len-1)/len);

cmp = interp1(x,hsv_,newx);



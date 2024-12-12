%% Lab 5: Setting the Stage – Regional Conditions part 2

%% 
% Last edited Oct 2024


%% Lab 5 Assignment
% Hand in 1 file named Lab5CodeYourLastName.m containing the code to
% generate the figures listed below, and a comment under your code to
% answer Q1. Make sure that your code will run (and use the data files that
% I have given you, so that I have them too!). 
%
% Two figures, using appropriate colormaps, labels, captions, etc: 
%
% 1. Close up of the bathymetry and topography of our study area (Saanich
% Inlet, Satellite Channel, Haro Strait). Use |find| to limit the data in
% BCregion_sm.mat and plot only the data you need for your close up plot.
% This map must show the stations we visited on our 18 and 25 Sep 2024 cruises.
%
% 2. Regional map, to put the location of Saanich Inlet into context. You
% should limit the data in this plot too, to include only the areas you are
% likely to reference in your final project. Do you need the deep Pacific?
% Or merely Juan de Fuca Strait?

load BCregion_sm.mat
load StationLocation.mat
%% 1. Close up of area - Option 1: 

indlat=find(lat>=48.5 & lat<=48.9);
indlon=find(lon>=-123.7 & lon<=-123.15);
s_lat=lat(indlat);
s_lon=lon(indlon);
s_z=z(indlat,indlon);

% Now use |pcolor()| to produce a bathymetric map of Saanich Inlet. 
figure(1);clf;
pcolor(s_lon-0.03,s_lat,s_z)   % NOTE: the base map is poorly aligned ... if we shift everything over 0.03deg in longitude, the stations will like up much better!
shading flat
set(gca,'dataaspectratio',[1 cos(49*pi/180) 1])
xlabel('Long ^oE')
ylabel('Lat ^oN')
caxis([-250 250]); % shows from 250m below sealevel to 250m above
shading flat
title('Elevation/Bathymetric Map of Saanich Inlet - split colorbar - Stns from 201909a')
colormap("parula")  % This is a nice colormap that goes through white. Use cool colours for water, warm colours for land. 
hc=colorbar;
ylabel(hc, 'metres above/below sealevel')


% Can you figure out a way to outline the coast a bit better? You could do
% it with the data set we have using the |contour| command. Another option is
% in another data set - SViCoast.mat. See if you can figure out how to use
% the variable |ncst| and the |plot| 
hold on
contour(s_lon-0.03,s_lat,s_z, [0 0  ],'k')  % this method uses the 0 m contour from our dataset

% Can you figure out a way to add a text label to the figure (using code,
% not the text box overlay function on the figure editor window!)?
text(-123.5,48.6, 'Saanich Inlet')
% Overlay the stations from 201909a - the info is all in the file
% StationLocation.mat which contains one structure. 
text(stnloc.lon, stnloc.lat, stnloc.id)

%%  Close up of area - Option 2: Split Colormaps
% Now use |pcolor()| to produce a bathymetric map of Saanich Inlet. 
figure(2);clf;
pcolor(s_lon-0.03,s_lat,s_z)% NOTE: the base map is poorly aligned ... if we shift everything over 0.03deg in longitude, the stations will like up much better!
shading flat  % Use to remove the black lines
set(gca,'dataaspectratio',[1 cos(49*pi/180) 1])
xlabel('Long ^oE')
ylabel('Lat ^oN')
title('Elevation/Bathymetric Map of Saanich Inlet - split colorbar - Stns from 201909a')

% Note - I'm going to use TWO colormaps here, one for below sealevel and
% one for above. 
caxis([-250 250]); % shows from 250m below sealevel to 250m above
%colormap([seajmk1(60);reliefland(60)])  % this colormap has equal numbers of colours from each colormap

hc=colorbar;
ylabel(hc, 'metres above/below sealevel')

hold on
contour(s_lon-0.03,s_lat,s_z, [0 0],'k')  % Adds a "coastline" - uses the 0 m contour from our dataset

text(-123.5,48.6, 'Saanich Inlet')
plot(stnloc.lon, stnloc.lat, '+r')  % plots a red + at each station location.
text(stnloc.lon+0.005, stnloc.lat, stnloc.id)  % shifts the text away from the symbol

%%  Close up of area - Option 3: Using function demcmap to delineate coastline
% Now use |pcolor()| to produce a bathymetric map of Saanich Inlet. 
figure(3);clf;
pcolor(s_lon-0.03,s_lat,s_z)% NOTE: the base map is poorly aligned ... if we shift everything over 0.03deg in longitude, the stations will like up much better!
shading flat  % Use to remove the black lines
set(gca,'dataaspectratio',[1 cos(49*pi/180) 1])
xlabel('Long ^oE')
ylabel('Lat ^oN')
title('Elevation/Bathymetric Map of Saanich Inlet - split colorbar - Stns from 201909a')

%Use a special function |demcmap| to pick a colormap for elevation data.
%Use help demcmap to see how this works. You need to pass the function the
%elevation matrix - for us, this is your LIMITED z range. Note - you cannot
%use caxis easily using this function, so you have less control of what data you emphasize. 
demcmap(s_z)

hc=colorbar;
text(-123.5,48.6, 'Saanich Inlet')

hold on
plot(stnloc.lon, stnloc.lat, '+r')  % plots a red + at each station location.
text(stnloc.lon+0.005, stnloc.lat, stnloc.id)  % shifts the text away from the symbol




%% 2. Regional Map
% Use find to limit the BCRegion file to a larger area than your previous
% map. 

rindlat=find(lat>=48 & lat<=49.5);
rindlon=find(lon>=-124& lon<=-122);
r_lat=[lat(rindlat)];
r_lon=[lon(rindlon)];
r_z=[z(rindlat,rindlon)];

% Now use |pcolor()| to produce a bathymetric map of Saanich Inlet. 
figure(4);clf;
pcolor(r_lon-0.03,r_lat,r_z)
set(gca,'dataaspectratio',[1 cos(49*pi/180) 1])
xlabel('Long ^oE')
ylabel('Lat ^oN')
shading flat
caxis([-250 250]); % shows from 250m below sealevel to 250m above
shading flat
title('Elevation Map of 201909 Study Region')
colormap("summer")
hc=colorbar;
ylabel(hc, 'metres above/below sealevel')

hold on
contour(r_lon-0.03,r_lat,r_z, [0 0],'k')  % this method uses the 0 m contour from our dataset


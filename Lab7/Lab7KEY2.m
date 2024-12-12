
clear 
close all
%% Part I - VENUS despike/smooth
load Jan2007Cond.mat
C=venusdata.data.Conductivity; %S/m
t=venusdata.data.Conductivity_time;

load Jan2007Press.mat
P=venusdata.data.Pressure; %decibar
load Jan2007Temp.mat
T=venusdata.data.Temperature; % C

%Calculate Salinity
c3515 = sw_c3515;
S=sw_salt((C*10/c3515),T,P);
%Define Narrowed Points
tstart=datenum(2007,01,4);
tend=datenum(2007,01,15);
%Find narrowed points
inds=find(t>=tstart & t<tend);
Ss=S(inds);
ts=t(inds);
Ps=P(inds);

%Find the bad data and remove
Sdespike=Ss;
Smean=mean(Ss);
Sstd=std(Ss);
uplim=3*Sstd;
lolim=-3*Sstd;
Sscor=Ss-Smean;
badinds=find((Sscor)>=uplim | (Sscor)<=lolim);
Sdespike(badinds)=NaN;

%Smooth the data

win=ones(15,1)/15; %window of 15 data points (1 per minute)
S_sm=conv2(Sdespike, win,'same');

%unsmooth the start and end
S_sm(1:7)=Sdespike(1:7);
S_sm(end-6:end)=Sdespike(end-6:end); 

%plot
figure(1);clf
plot(ts,Ss,'g') %uncorrected in green
hold on
plot(ts,S_sm,'k') %corrected in black
datetick('x','mmmdd','keepticks');
axis tight
xlabel('Time (date)')
ylabel('Salinity (psu)')
title('Saanich VENUS Salinity for 04/01/2007 through 14/01/2007')
legend('Uncorrected Salinity','Corrected Saliniy','Location','SouthEast')



%% *Part II: The 2015-2017 Hallam data set*  ( /15)
clear
% * Load the Hallam data set
load HallamGrid.mat
% * Plot the salinity at 14m depth and at 54m depth vs time.
figure(2);clf
plot(cgrid.time, cgrid.sal(14,:))
hold on
plot(cgrid.time, cgrid.sal(54,:))
datetick
legend('14 m', '54 m', 'location', 'southwest')
ylabel('salinity [psu]')
title ('Saanich Inlet (Hallam data) Salinity 2015-2017')

% * Plot the vertical profiles for T, S, and oxygen for the CTD cast from
% 13 July 2016. Use subplots.
% HINT = use datestr(cgrid.time) to turn the dates of each CTD cast into
% something you can read!

figure(3);clf
subplot(1,3,1)
plot(cgrid.t(:,19), cgrid.depths)
axis ij
set(gca,'XAxisLocation', 'top')
ylim([0 220])
xlabel('T [^oC]')
ylabel('depth [m]')
xlim([8 18])
title('CTD data 13 Jul 2016')
subplot(1,3,2)
plot(cgrid.sal(:,19), cgrid.depths)
axis ij
set(gca,'XAxisLocation', 'top')
ylim([0 220])
xlabel('S [psu]')

subplot(1,3,3)
plot(cgrid.O2(:,19), cgrid.depths)
axis ij
set(gca,'XAxisLocation', 'top')
ylim([0 220])
xlabel('O_2 [umol/kg]')
%%
% * Find the bad data in the Flu field and set those bad values to NaN (see
% text description of the Hallam data above for hints on criteria). You
% don't need to correct the bad data found near the bottom in Sep 2017. 
%
badFtime=find(cgrid.time<datenum(2016,1,1));
cgrid.Flu(:,badFtime)=NaN;
badFlu=find( cgrid.Flu<0);
cgrid.Flu(badFlu)=NaN;%

% Figure to test my criteria
figure(4);clf
pcolor(cgrid.time, cgrid.depths, cgrid.Flu)
shading flat
colormap(jet)
axis ij
colorbar
datetick('x','mm/yyyy');
caxis([0 10])
%%
% * Using |pcolor|, plot the oxygen vs time and overlay contours (use
% |contour|) of sigma-t. Use appropriate colour settings including |caxis|
% to emphasize the details of the dataset.

figure(5);clf
pcolor(cgrid.time, cgrid.depths, cgrid.O2)
shading flat
axis ij;
ylabel('Depth (m)');
xlabel('Date');
datetick('x','mm/yyyy');
Ha=colorbar;
ylabel(Ha, 'Oxygen (umol/kg)');
colormap(jetwb);
caxis([0 300]);
hold on
c=contour(cgrid.time, cgrid.depths, cgrid.den, 'k');
clabel(c)
legend('O2', 'sigma-t','Location','SouthWest')
title('Saanich Inlet Oxygen profile 2015-2017 with density contours')


% * As a COMMENT below your section plot code, answer the following
% question: Q1. Briefly discuss the features you see in the oxygen plot.
% Use specific language: What are the oxygen values and how do they change
% over time? At approximately what time of year do these changes occur?
% Describe the oxygen at both shallow and deep regions. 

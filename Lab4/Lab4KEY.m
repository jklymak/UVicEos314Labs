%% Lab 4 Assignment   KEY

% Last updated: Oct 2024

% Hand in 2 files: 
%
% *1.* Hand in a file named Lab4CodeYourLastName.m that contains the code
% to make all required figures below. You must use |find| for at least one
% of the two datasets (wind, pressure)

% Part 1: Wind data
load ('met2024')
firsttime = datenum(2024,9,12); %start at midnight on Sep 12th
lasttime = datenum(2024,9,26);  % midnight on the 26th - i.e. the time right after 11:59:59 pm on the 25th

time = met2024(:,1); % time is the 1st column of met2024
windsp = met2024(:,6); % wind speed is the 6th column of met2024, (km/h)
winddir =10*met2024(:,5); % wind direction is the 5th column, multiply it by 10 to make it degrees instead of 10's of degrees

inds=find(time>=firsttime & time<lasttime);
% check your work - how many data points were returned? You want two weeks
% = 14 days worth of points, and the data are taken hourly, so we want
% 14*24 points = 336 points.

figure(1);clf
subplot(2,1,1)
plot(time(inds), windsp(inds), 'b', 'LineWidth', 2)
datetick('keepticks', 'keeplimits')
xlabel('Date')
ylabel('Wind Speed [km/h]')

subplot(2,1,2)
plot(time(inds), winddir(inds), 'g*')
datetick('keepticks', 'keeplimits')
xlabel('Date')
ylabel('Wind Direction [^o]')
ylim([0 360])
set(gca,'ytick',[0 90 180 270 360])
hold on  % this allows me to put two lines on the same graph
plot(time(inds), 90*ones(length(time(inds))), 'k:')  %
plot(time(inds), 180*ones(length(time(inds))), 'k:')  %
plot(time(inds), 270*ones(length(time(inds))), 'k:')  %


% Figure caption: must include What/When/Where, source of data. Wind speed
% (km/hr) and direction (degrees) recorded at Victoria International
% Airport for two weeks prior to and including the EOS 314 teaching cruise
% on 25 September 2024. 
%%
% * Part 2: Tides as proxied by Pressure * at the ONC Saanich Inlet VENUS node
% One figure showing tides (as proxied by pressure) for (almost) 21 days prior to
% and including 25 Sep 2024. You will need to download the
% pressure dataset from the ONC website. Note that the ONC website provides
% times in UTC. 
clear
tidefirsttime=datenum(2024,9,4);
tidelasttime=datenum(2024,9,26);

load Sep24P.mat

tideinds=find(data.time>=tidefirsttime & data.time<tidelasttime);

figure(2);clf
plot(data.time(tideinds), data.dat(tideinds))
xlim([tidefirsttime tidelasttime]) %sets the x-axis limits
ylim([94.5 98.5]) %sets the y-axis limits
xticks(tidefirsttime:2:tidelasttime) %sets the ticks to be every other day

datetick('x','dd-mmm', 'keeplimits', 'keepticks') %need to make sure 'keeplimits' and 'keepticks' are included since otherwise datetick will reset them

xlabel('Date in Sept 2024')
ylabel('Pressure [db]')

% Figure caption: must include What/When/Where, source of data. Tides as
% proxied by bottom pressure (db) recorded at Ocean Networks Canada VENUS
% Instrument Platform in Saanich Inlet for approximately three weeks prior
% to and including 25 September 2024, a time period during which two EOS
% 314 teaching cruises were held (Sep 18 & 25).

%%


%% Lab 4: Setting the Stage  Regional Conditions part I

%% 
%

%% Objectives
% Today, we will continue to learn about MATLAB while also looking at the
% regional conditions surrounding our cruise area. We will visit the ONC-VENUS
% website and investigate some of the data available there. 
%
%%
% To help put the cruises in context, we will look at meteorology data.
%
% We will use two different ways to limit our data: |axis| and |find| - a
% very powerful tool!

%% 1. Meterological Data
%
% Meteorological data are available from two reliable locations near our
% study area. The Ocean Networks Canada Inshore Profiling System at Yarrow
% Point has meteorological data including wind speed and direction, air temperature,
% humidity, and barometric pressure. You can download those data from the
% ONC webpage (see the section below on tides for more info on how to
% download data from ONC). 
%
%
% Another great source of meteorological data is airports... and
% conveniently, we have one right in the middle of our study area! I've
% downloaded the meterological data at the Victoria Airport during the time period of
% 1 September - 1 October 2024. The main website is at:
% http://climate.weather.gc.ca/climate_data/hourly_data_e.html?StationID=51337 and
% you can work your way through it to find data for many different weather
% stations in Canada.
%
% I've put the met data into a _mat_ file called _met2024.mat_. 
%
% Load this data. What is the size of the array? How many columns of data
% are there? Note there is a second array called |met_colheaders| that
% contains the column headers. 
%
% Unlike the ONC-VENUS data sets, this mat file is NOT a structure. It's an eight
% column array, with the columns arranged as: 
%
% Time(UTC) Temp(oC) DewPoint(ToC) RelHum(%) WindDir(10's deg) Wind
% Spd(km/h) Visibility(km)	AirPress(kPa)
%
% You'll notice there are two columns for wind: strength(speed) and
% direction. The wind direction variable is in 10's of degrees.
%
% Also note that the time is in UTC. 

clear
load ('met2024') 

%%
% You can make a new variable _time_ and another _windsp_ if you'd like, by
% using the commands:
time = met2024(:,1); % time is the 1st column of met2024
windsp = met2024(:,6); % wind speed is the 6th column of met2024, (km/h)
winddir =met2024(:,5); % wind direction is the 5th column, (10's of degrees)

% Note - you could also just always specify met2024(:,1) every time you
% want to use the |time| variable, rather than pulling the values out of
% the matrix. 
%% 2. Tutorial: Using only part of the data set 
% This data set contains hourly measurements for the entire month of
% September. What if I only want to plot the data from a couple of
% weeks? Let's look at the two weeks prior to (and including) the first cruise (Sep 4 to Sep 19).
%
% Here are two methods: 
%
% *1.* Use the |axis| command to specify what section of the data to plot
%
% OR
%
% *2.* Take a subset of the data using the |find| command, and then plot it. 
%
% For both options, you will need to tell MATLAB what is the first time you
% are interested in plotting, and what is the last. 
%
% We can specify the first time that we want to plot by typing: 
firsttime = datenum(2024,9,4) %start at midnight on Sep 4th
%%
% and the last time that we want to plot:
lasttime = datenum(2024,9,19)  % midnight on the 20th - i.e. the time right after 11:59:59 pm on the 19th
%%
% We've just created two new variables - _firsttime_ and _lasttime_ - that
% contain the time of the first and last record we are interested in.
%
%

%% 2a: the axis command
% Start by taking a look at |axis| by typing |help axis| at the command
% prompt. If you don't like this version of help, you may also try clicking
% on the blue "Reference page for axis" at the bottom. Always scroll down
% in the help files to see the worked examples - they are often much easier
% to understand! 
%
% Today, we will be using |axis| to limit how much of the data on a plot is
% visible. First, we make a plot including all the data. Then, we call the
% |axis| command and tell MATLAB exactly which data to show. Our usage will
% be axis([xmin xmax ymin ymax]). Note the round brackets, which specify an
% arguement for axis, and the square brackets, which indicate a maxtrix (a
% 1x4 vector in this case). The order is important - you must put the four
% values in order (minimum x value, maximum x value...). 

%%
% Using the |axis| command, plot the wind speed as a timeseries for the two
% weeks prior to (and including) the first cruise (Sep 4 to Sep 19). Plot wind speed in green. 

figure(1); clf
plot(time, windsp, 'g')
%axis ([ first time to plot, last time to plot, lowest windsp, highest windspeed])
datetick
ylabel('')  %give name and untis
xlabel('')


%%
% A couple things to note using the axis command:
%
% 1. You are still plotting all the data, so if you have a really large
% data set, the plot can take a lot of time to generate. If you want to
% show a small part of a large data set, it is much better to limit the
% *data*, not just the *plot*! (See |find|, below).
%
% 2. Sometimes |axis| doesn't play nice with |datetick|... 
%
%
%

%% 2b. the find command
% And the second method - using the |find| command. This is a powerful
% command that we will come back to again - so do make sure you understand
% it by the end of this lab!
%%
% Let's look at some relational operators: 
%
% > is greater than
%
% < is less than
% 
% <= less than or equal to
% 
% Some operations on a vector :

x = [11  0  33  0  55]';

find(x) % finds all non-zero values of x and returns the indices of their positions.

find(x == 0) % finds all _zero_ values of x

find(0 < x & x < 10*pi) % finds all values of x that are greater than zero, but less than 31.4...

%%
% Back to our wind speed plot... 

% We can specify the first time that we want to plot by typing: 
firsttime = datenum(2024,9,4) %start at midnight on Sep 4th

%%
% And the last time that we want to plot:
lasttime = datenum(2024,9,19)  % midnight on the 20th - i.e. the time right after 11:59:59 pm on the 29th
%%
% Now we'll use the |find| command to locate all the (non-zero) elements of
% time that fall between our start and end points. 
% |find| will give us the _indices_ of those times (not the times,
% themselves). It gives us the place in the array, not the value. 

inds=find(time>=firsttime & time<lasttime); % take out the ; here to see the output!
% 

%%
% How many wind speed measurements are there between our start and end
% times? Does this make sense? (Hourly measurements for 14 days... )
%
% OK - now we've created an array called |inds| and given it the value of
% all the indices that fall in between our start and end points. 
% The equation above says: 
%
% inds = all the indices where time is greater than or equal to our firsttime and less
% than our lasttime. 
%
% How do I ask MATLAB for only SOME values of an array, not all of them? I
% say x=(1:3) to get the first three values, right? I could also say
% x=(variable name that contains all the ones I want)... 

time(inds) ;  % this will give me all values of time that fit the criteria I gave above!

%windsp(inds);
%winddir(inds)*10; % what is the *10 doing? 


%% 3. Wind plots
% Let's make some timeseries plots of the wind data. Remember to add all
% your axis lables. Try making the speed as a cyan line and the direction
% as green +'s. Remember to use |help plot| to see the formatting options. 

figure (3);clf; 
subplot(2,1,1) % plot wind speed vs time here for our short dataset
plot(time(inds), windsp(inds)) 
datetick('keepticks', 'keeplimits')
xlabel('date/time')

% kdatetick % here's a special function that Jody gave me. I like this one sometimes! 
% If you get an error message, make sure that the "common" directory is in the MATLAB path. 


subplot(2,1,2) % plot wind direction vs time here, using points, not lines. 



%% 
% That wind direction plot above is a little odd... it's hard to look at
% angular data on a straight plot like that! There are ways to use MATLAB
% to produce other kinds of plots, but that is beyond the scope of the
% tutorial.
%
%%
% Have a look at the figure you made... From what directions did the wind
% blow the most frequently? 

%% 4. Download the VENUS Saanich Node pressure data
% We need to look at the tidal data during and prior to our cruise. 
% The pressure record at the bottom of Saanich Inlet can be used 
% as a proxy for tidal height. 
%
% Start with Choose Variable By Location, and navigate to Pacific/Salish Sea/Saanich
% Inlet / Patricia Bay / Saanich Inlet VENUS Instrument Platform / Pressure
% Then click the RED "Select Data Product" link over on the right side of your screen. 
%
% We want the Pressure data, in MAT 7 format. 
%
% Enter the time range of interest - download a month's worth of pressure
% data:
%
% Date From (UTC): 1-Sep-2024  00:00:00
%
% Date To (UTC): 1-Oct-2024 00:00:00
%
% Select Data Format: 
% Here you have 7 options: 2 of them are for plots made by VENUS  good if
% you just want a quick graphical view. But if you actually want to examine
% the pressure data, you'll need to choose one of the data formats. We will
% use MATLAB, but you may wish to use a .csv file if you want to use Excel,
% for example.
%
% Choose MATLAB Version 7 mat file. 
%
% Click the red "Add to Cart", and then click "Next", then "Checkout All."
%
% The file will be generated for you (wait a minute or two!) and a link
% will show up on the right of the page. We want the |.mat| file, not the
% Metadata (though that's interesting, too.) Right-Click on the file name and
% download it to your computer. Put it into a directory that you can find
% and rename it to something that makes sense to you. I'll use
% |Sep24P.mat| for mine. Make sure you keep the |.mat| extension.

%% 5. Load the data using MATLAB. 
% Look at the current directory tab  and double click on the .mat file.
% Now change to the Workspace tab it should show two structures in the
% Workshpace, |data| and |metadata|. Click on |data| and the Variables window will
% open, showing the large amount of information in the data structure.
%
% ONC has set up their download data products to come with all the
% information you might need. We know the dates, the quality flag
% information, what sensor the data came from... and most importantly,
% there are two parts of the structure that contain the data we want. 
%
% Note that ONC provides times in the UTC timezone. 
%
% The data are in two fields |data.time| and |data.dat|. The data in |dat| is our
% parameter of interest, in this case, pressure.
%
%
% Another way to load the data is from the command line.
clear
load('Sep24P.mat');  % or whatever file name you gave your downloaded file

%%
% To see what the structure contains, just type the name of the structure.
whos  % this shows us what variables are in memory: we see there is a variable named "data"
%%
data 
%%
% Typing the name of the variable shows us that it is a "structure" - it
% contains many different kinds of information, tucked away into different
% parts of the array. 


%%
% To access the different parts of the structure, we can type the structure
% name followed by . followed by the next deeper piece of the structure.
% Here's the first three entries in |data.dat|:
data.dat(1:3)  %units are decibar

%%
% To make the data easier to work with, you could rename the variables to
% have nice, short, understandable names but it's often better
% to leave the data in the structure. 


%% 6. Plot the pressure data
% Plot the time vs pressure data for Saanich Inlet for the 21 days prior to
% and including Sep 25. This will give us a good picture of what's going on
% in the Inlet during the time around our cruise.  Use your knowledge of
% plotting in MATLAB to add appropriate titles, legends, axis labels, etc.
% Try making the line in red this time... with a line thickness of 2.
% You can use either |find| or |axis| to limit your data. 


figure (1) % opens a figure window
clf % clears the contents of the current figure window

plot(data.time,data.dat)
datetick


%%
% Investigate the various options for |datetick| and |datestr|. There are
% many format codes available. Make sure you choose appropriate formats for
% your xticks and xlabel... Anyone looking at your figure needs to be able
% to understand when the data are from. 
%% 
% Think about other methods you could use to look at these data... Are you
% going to be comparing various data sets? Would subplots be appropriate?


%% Lab 4 Assignment
% Hand in 2 files: 
%
% *1.* Hand in a file named Lab4CodeYourLastName.m that contains the code
% to make all required figures below. You must use |find| for at least one
% of the two datasets (wind, pressure)
%
% *2.* Also hand in (don't print out) a Word document named
% Lab4YourLastName.doc containing the specified figures and answers to
% the questions below. Make sure all figures are clearly labeled!
%
% *Part 1*. Winds
%
% Figure (use subplots) showing winds (both speed and direction) at the
% Victoria Airport for two weeks prior to and including the Sep 25 2024 cruise.
%
% *Q1*: Describe the general pattern in the winds. Were they strong or
% weak? Give an estimate of their magnitude. Did they change over time? What
% direction did they blow? Were they different in the days before each
% cruise or fairly similar?
%
% *Q2*: Why are we concerned with the winds in our study area? What
% effect(s) do you anticipate seeing in our physical data (CTD)? 
%
% *Part 2*. Tides (from VENUS pressure data)
% 
% One figure showing tides (as proxied by pressure) for 21 days prior to
% and including 25 Sep 2024. You will need to download the
% pressure dataset from the ONC website. Note that the ONC website provides
% times in UTC. 
%
% *Q3*: Discuss the tides in Saanich Inlet during the three week period. Were they
% strong or weak? What is the estimated amplitude of the tides? What stage
% (spring or neap) of the tide was happening during each of our cruises? 
%
% *Q4*: We will cover tides in greater detail later in the course. For the
% moment, briefly speculate on what effect the tides might have on the
% physical properties of our study area. 

%%
%last compiled on
datestr(now)
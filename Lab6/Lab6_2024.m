%% Lab 6 - Vertical Realm (CTDs) 
%%
% Last edited Oct 2024
%

%% Objectives
%
% To learn about FLOW CONTROL in MATLAB. We will use FOR loops and IF
% statements. 
%
% To learn about FUNCTIONS and how to use them, including the functions in
% the saltwater toolbox (found in your /common directory).
%
% To learn about CTD profilers used to obtain data in physical
% oceanography, and how to manipulate the data. These processes
% include calculating salinity, density, depth, buoyancy frequency and
% potential temperature from the measured variables.
%
%% Review:
%
% * Review commands/skills: relational operators, plot, axis labels, use of
% functions, legend.
% * New commands/skills: flow control (for and if loops), use of functions
% with multiple inputs and outputs, axis ij, using multiple colours on a
% plot
%% Part I: Flow Control Tutorial
% Syntax of control flow statements:
% 
% for VARIABLE = EXPR
%
%     STATEMENT
%
%      ...
%
%     STATEMENT
%
% end 
%
%   EXPR is a vector here, e.g. 1:10 or -1:0.5:1 or [1 4 7]
% 
% 
% if EXPRESSION
%
%     STATEMENTS 
%
% elseif EXPRESSION
%
% STATEMENTS
%
% else
% 
% STATEMENTS
%
% end 
%
%   (elseif and else clauses are optional, the "end" is required)
%
%   EXPRESSIONs are usually made of relational clauses, e.g. a < b
%
%   The operators are <, >, <=, >=, ==, ~=  (almost like in C(++))
%
% Examples:
for i=1:2:7                  % Loop from 1 to 7 in steps of 2
  i                          % Print i
end

%%
for i=[5 13 -1]              % Loop over given vector
  if (i > 10)                % Sample if statement
    disp('Larger than 10')   % Print given string
  elseif i < 0               % Parentheses are optional
    disp('Negative value') 
  else
    disp('Something else')
  end
end
%%
% Example: given an m x n matrix A, create a matrix B of the same size
%   containing all zeros, and then copy into B the elements of A that
%   are greater than zero.
%
% Implementation using loops:
A = [-5 3 -18 20; 34 -8 2 67; 3 5 1 -2; -7 2 45 2];
m=4;
n=4;
B = zeros(m,n);
for i=1:m
  for j=1:n
    if A(i,j)>0
      B(i,j) = A(i,j);
    end
  end
end


%% Example using functions 

x=rand(10,1); %Generates 5 random numbers between 0 and 1

for i=1:length(x) 
    y(i)=cos(x(i)); %Assign variable y to be the cos of x for each element i in x 
end

y(3)-cos(x(3)) %CHECK: This should print out 0 if we have applied the function correctly. 


%% Part II: Looking at CTD casts.  
%
% Let's start by looking at one CTD cast from a 18 Sep 2024 cruise. I've
% given you a small subset of of stations today - for your project, you'll
% use all stations that we visited. But for learning purposes, let's
% just look at a few today.
%

%% 
clear
load 20240918_S12.mat
%%
% Here's some special code that I'd like you to try to understand, but
% don't worry about it too much. The CTD mat files from before 2022
% contain all the data - the downcast AND the upcast. For clarity on our
% plots, we only want to look at the downcast. The code below makes a new
% structure (ctdd) that has only downcast data (removes upcast)

dP = diff(ctd.pres) > 0.05; %this command indexes the array to only include
                         %positive differences between adjacent pressure
                         %readings, i.e downcast only. 
ctdd.p = ctd.pres(dP);
ctdd.t = ctd.temp(dP);
ctdd.c = ctd.cond(dP);
ctdd.O2 = ctd.O2sat(dP);

%NOTE: The newer CTDs (RBR Maestro) automatically remove upcasts from the
%data. However, previous year data (before 2022) require you to manually remove the
%upcast. Thus, keep the line: dP = diff(ctd.pres) > 0.05; in your code just to make
%sure you are not also analyzing upcasts when analyzing older data.


%%
figure(1); clf
plot (ctdd.t, ctdd.p)
axis ij  %NOTE - this changes the origin of the graph to the upper left
%axis tight

set(gca,'XAxisLocation', 'top')
set(gca,'XGrid','on')

%% Calculating salinity and density 
%

% NOTE: The new CTDs also calculate salinity and density for us.
% The old CTDs do not do this, so we are going to practice using these
% functions so that you are also able to analyze previous years data (you
% will need to do a multi-year comparison in your final project). 

% You'll notice  that there is no salinity variable (in datasets before 2022). The older CTD
% measures three properties - _conductivity_, _temperature_, and
% _pressure_. Salinity at each record can be calculated from those three
% properties. Have a look at the hand-out that explains how salinity is
% calculated.
%
% Luckily, there's a toolbox of saltwater calculations that
% have be made for MATLAB. So it's very easy for us to calculate salinity.
% We can just use a function that's already been written. 
%
% Remember - all the functions that we use were written by someone. A
% function is a recipe that MATLAB follows to conduct a series of steps.
% You could write your own functions - especially if there is a series of
% commands you use regularly. 
%
% See the handouts on Functions and Scripts for some examples. 
%
% 
clear
load EXAMPLE20180922_S12
%%
% "Call" the |sw_salt| function to get salinity...
%%
% =========================================================================
%  SW_SALT  $Id: sw_salt.m,v 1.2 2004/03/18 20:27:03 pen078 Exp $
%           Copyright (C) CSIRO, Phil Morgan 1993.
% 
%  USAGE: S = sw_salt(cndr,T,P)

% Be careful that your units for the conductivity ratio are correct!

% And what _is_ the conductivity ratio? It is a comparison of the
% conductivity of water at standard S, T, P (that is, at Salinity of 35,
% Temperature of 15, and Pressure of zero) to the measured conductivity of
% our water sample. The standard conductivity can be found by using the
% saltwater toolbox function |sw_c3515| which gives you a number: 42.9140


c3515 = sw_c3515; % units is ms/cm (you will need this statement too)

% Calculate salinity here below, making a new entry in the ctdd structure
% that contains the values for salinity
 


%ctd.s = sw_salt(

%%
% And do a quick plot to have a look at the data. (No need for axis titles,
% etc.)
figure(2); clf
plot(ctd.s, ctd.p)
axis ij

%%
% What about density? Just like salinity, there's a function that will
% calculate the density of the water, given the salinity, temperature, and
% pressure. Density is often referred to as _rho_ (as d would be confusing,
% since it looks like depth)
% Use |sw_dens| ...

% ctdd.rho = ??

%% 
% Other functions you might be interested in: 
%
% * potential temperature: use |sw_ptmp|
%
% * buoyancy frequency: use |sw_bfrq|  ** Note: multiple inputs and outputs
% possible



%% Working with multiple CTD casts at the same time
%
% Now that we've looked at how to calculate salinity and density on one
% file... could we calculate them for all the files, all at once? How about
% plotting the data from all casts at once? 

%% 
% *Loading ALL the Sep 2024 (subset) CTD data*
% 
% NOTE - This section can be confusing. Work through it slowly, making sure
% you understand each line before you move onto the next. 
%
% Also Note: Here, we are loading individual files that contain all the
% data collected.  There is another version of the CTD data available to
% you - a gridded data file in CtdGrid.mat. In that mat file, the data has
% been averaged into 1 m depth bins and gridded into a structured array. You
% will likely use the gridded data for your project, but it can be useful
% to have the single casts too.

clear
files=dir('2*.mat'); %note the use of the function |dir|...

%%
% Let's look at |files|. What is the value of the variable |files|? How do
% we find out? Simply re-run the previous command without suppressing the 
% output in the command prompt.
%
files=dir('2*.mat')

%%
% What is contained in the variable |files.name|?
files.name

%%
% What is the first file listed in |files|?
files(1)
%%
% What is the name of the third file listed in |files|?
files(3).name

%%
% How many files do we want to load? We want all the CTD data files... we
% could go to the directory and count... or we could use MATLAB to check
% for us:
length(files)

%% Loading all files at once
% Now, we want to load ALL of these data sets at once. All the mat
% files contain variables of the same name (just like the 2 VENUS data sets
% last lab). So if we just load them one after the other, the data will get
% overwritten by the next file to be loaded. 
%
% If we use a for loop, we can load all the files in, but give each a unique
% identifier (it's own index value). 


for i=1:length(files);
    load (files(i).name);  % what is this command doing on the 2nd time through the loop?
    ctd(i)=ctd;
   
end; %for i=each file, which is each station
%%
% This works just fine to load in all the files... but recall from above,
% each file contains both the upcast and the downcast. We only want the
% downcast... So, rather than me getting in there and reprocessing all the
% data before giving it to you, I'll just give you the code you need to
% process it. So... we need to run this loop slightly differently than we
% just did above. 

% As we saw above, each CTD mat file
% contains all the data - the downcast AND the upcast. For clarity on our
% plots, we only want to look at the downcast. The code below makes a new
% structure (ctdd) that has only downcast data (removes upcast)   
   
for i=1:length(files);
    load (files(i).name);  % what is this command doing on the 2nd time through the loop?
    ctd(i)=ctd;
        dP = diff(ctd(i).pres) > 0.05; 
        ctdd(i).p = ctd(i).pres(dP);
        ctdd(i).t = ctd(i).temp(dP);
        ctdd(i).c = ctd(i).cond(dP);
        ctdd(i).O2 = ctd(i).O2sat(dP);
        ctdd(i).id = ctd(i).id;
        ctdd(i).lon= ctd(i).lon;
        ctdd(i).lat= ctd(i).lat;
        
end; %for i=each file, which is each station
%% Plotting all files at once
% Now, we have all the CTD files in the Workspace memory, which means we can
% plot the data. 
%
% *Plotting vertical plots*
%
% Let's start by plotting the S12 cast again, like we did above. We need to
% know what the file number is for S12. How do we find that out? 
% We can use  _files.name_ to list all the files and then just count
% through to find the one we are looking for. 
figure(3);clf;

plot(ctdd(2).t, ctdd(2).p);

axis ij

xlabel('Temperature (^oC)')
ylabel('Pressure (db)')
axis tight
title('Temperature profile for Station S12, 18 Sep 2024')

%%
% Make sure you understand how we got Station S12 to graph. What would we
% type to get station A2? 

%%
% Let's plot S12 and A2 on the same graph. 


figure(4);clf;

plot(ctdd(2).t, ctdd(2).p)
hold on
plot(ctdd(1).t, ctdd(1).p)
axis ij
axis tight


%%
% If you're using an older version of Matlab, both lines will be blue. If
% you're using a newer one, it will automagically change the second line to
% red. We can also tell it what colour to use for each line - like this:
%
figure(5);clf;
plot(ctdd(2).t, ctdd(2).p, 'r')
hold on
plot(ctdd(1).t, ctdd(1).p, 'k')
axis ij
axis tight

%use the legend command to differeniate between the lines
%%
% Now, let's plot ALL the files on the same graph, using a different colour
% for each line. We could type in many plot commands... but that's not
% necessary. We already learned how to do the same thing, multiple times.
% We'll do it using a |for loop|. The command |jet| gives us a set of
% colours, and we'll specify that we want enough different colours. 

figure(6);clf;
mycolours = jet(7);

for k=1:(length(files));
    plot(ctdd(k).t, ctdd(k).p, 'color', mycolours(k,:))
    hold on
end;
% note how we are specifying colors... 'color' tells MATLAB that the next
% piece of information will be the colour I want to use... and then we give
% MATLAB an array of colours that we just made.

xlabel('Temperature (^oC)')
ylabel('Pressure (db)')
axis ij
axis tight
title('Temperature profiles 20240918')
set(gca,'XAxisLocation', 'top')
set(gca,'XGrid','on')

%%
% This is very pretty... but meaningless without a legend. Each files has
% it's own colour. We need to find out the order that the files are listed
% in the |files| variable, since that is the order that they are processed,
% so the order in which they are plotted. And then we need to add these
% names to a legend command. (We'll do this by hand, but it _can_ be
% coded...)
% 
% put your legend command here
hold on
% legend()

%% Calculations on all files at once
% We've now seen how to use for loops to load the data and to plot the
% data. Could we also use them to do calculations on the data? Sure!
%
% Let's calculate salinity from conductivity, temp and pressure

c3515 = sw_c3515; % units is ms/cm
 

for j=1:length(files)

    %put your code to calculate salinity and density in here! Both salinity
    %and density calculations can go in the same for loop, provided you do
    %salinity first, since the density calculation needs salinity!

end;

%NOTE: THIS SECTION WILL ONLY BE FOR PRACTICE AS THE CONDUCTIVITY
%MEASUREMENTS IN THE 2024 DATA ARE DIFFERENT THAN PREVIOUS YEARS, SO THE
%VALUES WILL NOT MAKE ANY SENSE. 

%WHEN DOING THE ASSIGNMENT, USE THE SALINITY AND DENSITY VARIABLES THAT ARE
%ALREADY IN THE 2024 DATA.



%% ASSIGNMENT
%  
%
% *Part 2*. Sep 18 2024 subset CTD Data (/10)
% 
% Make and hand in a new script, Lab6CodeYourlastname.m
%
% Include in this file all the code you need to: 
%
% * 1. Load all of the stations from the 18 Sep 2024 cruise subset using a for loop
% and limit the data to only the downcast information.
% * 2. Save your new data structure (ctdd) into a mat file called MyLastName.mat
% * 3. Code to produce a plot of S vs T (known as a TS plot)for A2,
% S4, and S5. Use points, not lines; different colour for each CTD cast.
% * 4. Code to produce a plot of density vs pressure for two of the
% stations (you choose which two stations) - there will be two lines on
% this graph.
%
% Plots should include all appropriate labels (axis, legend, titles if
% needed...) and have appropriate axis limits, etc, so that you can
% reasonably interpret the plots.
%
% Code will be marked by running the m-file, so make sure that it works
% before you hand it in. Make sure to add comments to explain what you are
% doing, and use semicolons (;) to suppress unneccesary screen output. 
%
% *Part 3* Written Questions  (  /5)
%
% Below the code for Part 2 (above), type the answers to the following
% questions. 
%
% *Q1* Look at your plot of density vs P for two stations. Are there any
% differences between the lines? Give a brief description of the two data
% sets (mixed layer depth? surface values? deep values?) What time was each
% sample was taken (use the log sheets)? What (roughly) was the tide doing
% at each sample time? (You will need to find tide info for our cruise
% dates for this! http://www.tides.gc.ca/eng/station?type=0&sid=7277&tz=UTC&pres=1)
%
% *Q2* Look at your TS plot. Does Stn S4 have the same TS characteristics
% as the other two stations? In what corner of the graph is the 'deep'
% water of Saanich Inlet? Does A2 have any water that is the same density
% as the 'deep' Saanich Inlet water? 
%
%
%
%% NOTE:
% You will be marked on 1) your answers to the questions; 2) your ability
% to follow directions; and 3) the elegance of your code. Keep things neat
% and organized. Use % to make comment lines to explain what you are doing.
% Use the semicolon ; after commands to suppress unnecessary output. Make
% sure you follow the file name conventions I've asked for. 
%
% You need to hand in 1 file to Brightspace.
%
% * |Lab6CodeYourlastname.m| with your code and answers to all questions. 
%
% 
%%
%
%%
datestr(now)




%% Lab 6 - Vertical Realm (CTDs) **KEY 2
%% ASSIGNMENT
%  
% Last edited Oct 2024
%
% *Part 2*. Sep 2024 subset CTD Data (/10)
% 
% Make and hand in a new script, Lab6CodeYourlastname.m
%
% Include in this file all the code you need to: 
%
% * 1. Load all of the stations from the Sep 2024 cruise subset and limit the
% data to only the downcast information.

clear
files=dir('2*.mat'); %note the use of the function |dir|...
for i=1:length(files);
    load (files(i).name);  % what is this command doing on the 2nd time through the loop?
    ctd(i)=ctd;
        dP = diff(ctd(i).pres) > 0.05;
        ctdd(i).p = ctd(i).pres(dP);
        ctdd(i).t = ctd(i).temp(dP);
        ctdd(i).s = ctd(i).sal(dP);
        ctdd(i).rho = ctd(i).pden(dP);
        ctdd(i).O2 = ctd(i).O2sat(dP);
        ctdd(i).id = ctd(i).id;
        ctdd(i).lon= ctd(i).lon;
        ctdd(i).lat= ctd(i).lat;
          
end; %for i=each file, which is each station



%%

% * 2. Save your new data structure (ctdd) (containing the original values
% AND your values for salinity and density) into a mat file called MyLastName.mat
%save('MyLastName.mat', 'ctdd')
% save MyLastName ctdd   also works

%%

% * 3. Code to produce a plot of S vs T (known as a TS plot)for A2,
% S4, and S5. Use points, not lines; different colour for each CTD cast.
figure(1);clf
plot(ctdd(1).s, ctdd(1).t,'b.', ctdd(3).s, ctdd(3).t, 'g.',ctdd(4).s, ctdd(4).t, 'k.')
xlim([29 33])
ylim([9 12.5])
legend(ctdd(1).id, ctdd(3).id, ctdd(4).id)
xlabel('Salinity (psu)')
ylabel('Temperature (^o)')
title('TS Plot (A2, S4, S5) 202209c')

%%
% * 4. Code to produce a plot of density vs pressure for two of the
% stations (you choose which two stations) - there will be two lines on
% this graph.
figure(2);clf
plot(ctdd(1).rho, ctdd(1).p,'b', ctdd(3).rho, ctdd(3).p, 'k')
xlim([1020 1027])
ylim([0 300])
axis ij
legend(ctdd(1).id, ctdd(3).id)
xlabel('Density (kg/m^3)')
ylabel('Pressure (db)')
title('Density profiles (A2, S4) 202209c')
set(gca,'XAxisLocation', 'top')

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
% at each sample time? (You will need to find tide info for Sep 19
% for this! http://www.tides.gc.ca/eng/station?type=0&sid=7277&tz=UTC&pres=1 )
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
% * |Lab6CodeYourlastname.m| with your code and answer to all questions
%
% 
%%
%
%%
datestr(now)




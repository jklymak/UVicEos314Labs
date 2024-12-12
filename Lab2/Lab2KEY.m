
%
%% ASSIGNMENT
%% Part I:  Writing your own script (m-file)
%
% For this section, you will write your own script to remove the mean from
% the March 13, 2012 Temperature data and re-plot it. 
%
% * Make a new _m-file_ called |Lab2CodeYourlastname.m|.  This script
% will contain all the code needed to: Load the March 13, 2012 datafile. Calculate the
% mean of T (using the |mean| function) and subtract it from |T|, making a
% new variable. Now that you've done some work on your dataset, save your
% new variable (T with the mean removed) and |time| (and ONLY those
% two variables) into a new mat file called |george.mat|. Now plot the new
% variable versus time, using a red dashed line. Label your axes. Include a
% descriptive (but concise!) title for your figure. And then add a line to
% your code that will save your figure with the name LastnameFig2.jpg

% KEY for Lab 2 assignment  
% note - this is 'fancier' than you need... showing you some new
% tricks here in this code. 

clear

load Mar13_T.mat
Tanom=T-mean(T);   % I can take the mean and subtract it from T all in one line of code
save george.mat time Tanom   % note - I'm only saving two variables here, not my whole workspace

figure(1);clf
plot(time, Tanom, 'r--')   % use help plot to see all the colour, symbol, and line options
hold on  % this allows me to put two lines on the same graph
plot(time, zeros(length(time)), 'k')  % Cool! I've added a black line at zero to help see the anomaly values!
datetick  %converts times into something readable


% xlabel('Time')  % this is OK, but not very interesting... try the following two lines instead

str=['Time [' datestr(time(1),1) ']'];
xlabel(str)
ylabel('Temperature Anomaly ^oC')
title('Temperature Anomaly at 96m depth, Saanich Inlet, on 13 Mar 2012')
print -djpeg95 -r200 ThorntonFig2.jpg 





% As a comment below your code, include your answer to Q1 below. 
% 
% *Q1*. The value obtained by subtracting the mean of a data set from the
% data is called the _temperature anomaly_. Why do you think oceanographers
% calculate temperature anomalies? Describe a situation where this might
% be useful. 
% 


%% NOTE:
% You will be marked on 1) your answers to the questions; 2) your ability
% to follow directions; and 3) the elegance of your code. Keep things neat
% and organized. Use % to make comment lines to explain what you are doing.
% Use the semicolon ; after commands to supress unnecessary output. Make
% sure you follow the file name conventions I've asked for. 
%
% You need to hand in 1 file: 
%
% * |Lab2CodeYourlastname.m| with your code and answer to Q1
%
% You may hand them in on the class USB Memory stick, or via email to
% sarahjt@uvic.ca with the subject: *314 Lab2 LastName*




%%
% .
% .
% .
%%
% Last compiled on: 
datestr(now)


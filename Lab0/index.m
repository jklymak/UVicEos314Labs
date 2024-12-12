%% EOS 314 - Physical Oceanography Laboratory
%
%% Preamble to the 314 Laboratory
%%
% Throughout the Ocean Sciences core program, we will keep revisiting
% Saanich Inlet. In 314, we are interested in water column properties.
%
% The final project for 314 will involve looking at Saanich Inlet and
% surrounding waters and discussing why we see what we do. This lab is
% designed as a tutorial to help you with data analysis and presentation
% for your project. We will work on making good graphics and explaining the
% story behind each graph. Some of the data that we use in the lab will be
% the same data you use in your final project. Please use this opportunity
% to get a head start on your project!
%
% The first part of each lab session will include a review of the previous
% week's lab and a guided tutorial covering the new material. In the second
% half of the time, you'll be expected to start working on an assignment to
% turn in. You may work collaboratively, but everyone must hand in their
% own assignment. Assignments are due in the Brightspace dropbox at 4 pm on
% the day before your next lab (i.e. Sunday at 4 pm for Monday labs,
% Tuesday at 4 pm for Wednesday labs).
%
% It will be very useful to install MATLAB on your personal laptop.
% Instructions are available at: https://www.mathworks.com/academia/tah-portal/university-of-victoria-31110150.html .
% 
% Alternatively, if you do not want to or are unable to install MATLAB on
% your personal computer, you can access MATLAB Online by signing up for a
% Mathworks account with your UVic email address:
% https://www.mathworks.com/products/matlab-online.html
%
% You will also need to copy the "common" directory (contains functions and
% color maps that do not come with the standard MATLAB installation) to
% your laptop in order to use the lab tutorials. See the "Lab 1" section
% for the common directory download link.
%
% Initial Lab Handout available as a PDF here:
% https://web.uvic.ca/~evamegan/314Labs/Lab0info/314LabIntroHandout_Sep2024.pdf
%
% *Senior Lab Instructor:* Eva MacLennan evamegan@uvic.ca
% *TAs:* Becky Brooks: rebeccaabrooks@uvic.ca; 
% Jamie Daniel: jamiedaniel@uvic.ca
%  
%% 
% Labs will be clickable links a day before the lab. Keys will be
% available after the lab is marked.

%% Strickland cruise data are now available!
%
% Download https://web.uvic.ca/~evamegan/314Labs/2024CruiseData.zip
%
% The data is separated by cruise day (September 18th and September
% 25th). There are a lot of files in there in case you get curious, but the
% most useful ones, and the ones I'd direct you to, are CtdGridNew.mat or 
% CtdGridNew.nc. 

%%
%% Fall 2024
%% Week of Sept 9 - Lab 1 
% *Introduction to MATLAB*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab1/Lab1.html
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab1/Lab1.zip
%
% Download https://web.uvic.ca/~evamegan/314Labs/common/common.zip
%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab1/Lab1KEY.m

%%
%% Week of Sept 16 - Lab 2 
% *Times and Graphs*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab2/Lab2.html
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab2/Lab2.zip Download
% the compressed folder Lab2.zip and place it in your Documents/MATLAB
% directory. Uncompress the folder by right-clicking on it and clicking
% "Extract All".
%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab2/Lab2KEY.m
%%
%% Wed Sept 18 OR Wed Sept 25 - Field Exercise
% Basic cruise details available on Brightspace.
%
%   Watch for updates in class/lab and posted to Brightspace!
%
%%
%% Mon Sept 23 (B02) and Wed Oct 2 (B01) - Lab 3
% *Structures and ONC Data*
%
% http://web.uvic.ca/~evamegan/314Labs/Lab3/Lab3.html
%
% The data files and .m file for this lab can be found on Brightspace.

%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab3/Lab3KEY.m
%%
%% Week of Oct 7 - Lab 4 
% *Regional Conditions - part 1*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab4/Lab4.html
%
% The .m and .mat files for this lab can be found on Brightspace.

%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab4/Lab4KEY.m
%
%
%%
%% Wed Oct 16 (B01) and Mon Oct 21 (B02) - Lab 5 
% *Regional Conditions - part 2*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab5/Lab5.html
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab5/Lab5.m
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab5/StationLocation.mat
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab5/SViCoast.mat
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab5/BCRegion_sm.mat
%
% Key(example map):  https://web.uvic.ca/~evamegan/314Labs/Lab5/Lab5KEY.m
%
%
%%
%% Wed Oct 23 (B01) and Mon Oct 28 (B02) - Lab 6  
% *The Vertical Realm*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab6/Lab6.html
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab6/Lab6.zip
%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab6/Lab6KEY.m
%
%% Wed Oct 30 (B01) and Mon Nov 4 (B02) - Lab 7
% *Saanich Time Series Data*
%
% https://web.uvic.ca/~evamegan/314Labs/Lab7/Lab7.html
%
% Download https://web.uvic.ca/~evamegan/314Labs/Lab7/Lab7.zip
%
% Key(code):  https://web.uvic.ca/~evamegan/314Labs/Lab7/Lab7KEY.m
%
% Monday's section (B02) will also have the project orientation today.
%
%%
%% Wed Nov 6 - Project Orientation
% *An introduction to the datasets available to you for your final project*
%
% Your TA will be available.
%
%%
%% Week of Nov 11 - Reading Break
% *No labs this week*
% 
%%
%%  Wed Nov 23 through Wed Nov 30 - Open Labs
% *Open labs to work on your final project*
%
% Your TA will be available.
%

%% Useful Links
% * Ocean Sciences Minor - Cruise Data Archive:
% http://web.uvic.ca/~cbrant/OSM/OSMCruiseData/
% * MATLAB online tutorials:
% http://www.mathworks.com/academia/student_center/tutorials/
% * ONC-VENUS project: http://oceannetworks.ca
% * Tides Prediction website
% http://www.tides.gc.ca/eng/station?type=0&date=2019%2F09%2F23&sid=7277&tz=UTC&pres=1

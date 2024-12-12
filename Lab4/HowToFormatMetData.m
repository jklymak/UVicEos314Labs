%% Instructions for Eva so you can do this again next year

% download the data according to lab 4 instructions
% change it around in excel - take out some of the columns according to the
% met_colheaders so that we can reuse met_colheaders every time

% load into matlab
met2024 = readtable('met2024.csv')

% now we have to fix the time
timea = met2024(:,1) % pulls out date and time
timeb = table2array(timea) % converts to array instead of table
timec = convertTo(timeb, 'datenum') % converts to type datenum which is 700000 something

% copy and paste the new timec data column into the original csv using
% excel or something, then reload back into here

% then change to an array

function XLabelHndl = kdatetick(arg1,arg2)
%
% kdatetick.m--My own version of Matlab's datetick.m program. 
% Plot some quantity versus time, then run kdatetick. The 
% plot x-ticks and x-tick labels will be replaced with "human"
% time format ones appropriate to the time range in the plot
% (e.g., "04:36:22", or "01/01/1983", etc.). Unlike Matlab's
% datetick.m, kdatetick does not alter your plot's x-limits. 
%
% kdatetick(DatumTime,InTimeUnits) specifies that the plotted time data 
% represent elapsed time since the time "DatumTime", measured in units 
% specified by "InTimeUnits". DatumTime is a Matlab-format time, as
% produced by datenum.m; InTimeUnits is a string which must be one of
% 'days', 'hours', 'minutes' or 'seconds'.
%
% kdatetick with no input arguments assumes the plotted time is in
% Matlab-format time (i.e., DatumTime=0, InTimeUnits='days').
%
% XLabelHndl = kdatetick(...) returns a handle to the xlabel produced
% by kdatetick.m.
%
% Note that choosing a time format that measures time in small increments
% over a long period (as is the case with Matlab-format time) has serious
% disadvantages. Depending on your machine, you may find it impossible to
% zoom in on the time axis of your plot as closely as you would like
% before the limit of your machine precision is reached. If this occurs,
% convert your time to a format that allows closer zooming, like elapsed
% days since the beginning of your data, or elapsed hours since the start
% of the current year.
%
% If the x-tick labels are too close together, try setting the axes'
% 'FontSize' property to a smaller value. 
%
% Kdatetick.m must be run after each rescaling of the time axis (with
% zoom, for example) or the tick labels will be incorrect.
%
% Syntax: <XLabelHndl> = kdatetick(<DatumTime>,<InTimeUnits>)
%
% Example: set(gca,'xlim',[datenum('01-Sep-1999') datenum('28-Oct-1999')]);
%          kdatetick;
%
% Example: set(gca,'xlim',[0 100]);
%          DatumTime = datenum('01-Sep-1999 06:35:44'); InTimeUnits='seconds';
%          kdatetick(DatumTime,InTimeUnits);

%   Bug fixes/modifications:
%      October 26, 2000: Method of initial calculation of tick values changed to 
%                        remove bug that sometimes resulted in incorrect tick values.
%      October 26, 2000: Improved x-labelling with more information in strings. 
%      October 26, 2000: Made year vector open-ended, added error message for
%                        times exceeding permissible Matlab-format dates.
%
% Kevin Bartlett (bartlett@soest.hawaii.edu) 10/2000
%------------------------------------------------------------------------------

% Examples for development, testing:
% e.g., t=[721673.67:721732.39];plot(t,t.^3);set(gca,'xlim',[t(1)-20 max(t)+.7]);kdatetick  
% e.g., t=[730378.79:.01:730379.37];plot(t,t.^3);set(gca,'xlim',[t(1)-.3/24 max(t)+.7/24]);kdatetick  
% e.g., t=[730366.79:.1:730391.13];plot(t,t.^3);set(gca,'xlim',[t(1)-.3/24 max(t)+.7/24]);kdatetick  
% e.g., t=[240:552];plot(t,t.^3);kdatetick(datenum('01-Aug-1999 00:00:00'),'hours')
% e.g., t=[724276.6:.01:724277.1];plot(t,t.^3);kdatetick
% Problem: x=[1:.001:10];y = sin(x)./x;t=linspace(4,555,length(y));plot(t,y);kdatetick(datenum('01-Sep-1999')-1,'days');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) Preparation.

% Constants:
YEARS   = 1;
MONTHS  = 2;
DAYS    = 3;
HOURS   = 4;
MINUTES = 5;
SECONDS = 6;

MINTICKS = 3; % Desire at least this many ticks on the time axis.
MAXMAXTICKS = 8; % Stop looking for finer ticks if you already have this many.

MonthList = {'January','February','March','April','May','June','July','August',...
      'September','October','November','December'};

TimeUnits = {'years','months','days','hours','minutes','seconds'};

% If no input arguments specified, assume Matlab-format time.
if nargin == 0,
   DatumTime = 0;
   InTimeUnits = 'days';  
elseif nargin == 2,
   DatumTime = arg1;
   InTimeUnits = arg2;  
else 
   error([mfilename '.m--Wrong number of input arguments.'])
end %if

InTimeUnits = lower(InTimeUnits);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2) Choose the time units to calibrate the time axes by.

% Get the x-limits of the axes.
CurrAxes = gca;
xlims = get(CurrAxes,'xlim');

% Convert the x-limits to Matlab-format time.
if strcmp(InTimeUnits,'days'),
   XLimFactor = 1;
elseif strcmp(InTimeUnits,'hours'),
   XLimFactor = 24;
elseif strcmp(InTimeUnits,'minutes'),
   XLimFactor = 24*60;
elseif strcmp(InTimeUnits,'seconds'),
   XLimFactor = 24*3600;
else
   error([mfilename '.m--Input argument "InTimeUnits" must be "days", "hours", "minutes" or "seconds".'])
end % if

xlims = xlims./XLimFactor + DatumTime;

MINMATLABDATE = datenum('01-Jan--999');
MAXMATLABDATE = datenum('31-Dec-9999');

if any(xlims<MINMATLABDATE) | any(xlims>MAXMATLABDATE),
   error([mfilename '.m--Plot limits exceed allowable Matlab-format times; cannot convert to date strings.']);
end % if

% Find the first possible tick for each of the defined time units.
[year1,month1,day1,hour1,minute1,second1] = datevec(xlims(1));

FirstSecondTick = datenum(year1,month1,day1,hour1,minute1,ceil(second1));
FirstMinuteTick = datenum(year1,month1,day1,hour1,minute1+1*(second1~=0),0);
FirstHourTick = datenum(year1,month1,day1,hour1+1*(minute1~=0 | second1~=0),0,0);
FirstDayTick = datenum(year1,month1,day1+1*(hour1~=0 | minute1~=0 | second1~=0),0,0,0);
FirstMonthTick = datenum(year1,month1+1*(day1~=1 | hour1~=0 | minute1~=0 | second1~=0),1,0,0,0);
FirstYearTick = datenum(year1+1*(month1~=1 | day1~=1 | hour1~=0 | minute1~=0 | second1~=0),1,1,0,0,0);

% Find the last possible tick for each of the defined time units.
[year2,month2,day2,hour2,minute2,second2] = datevec(xlims(2));
LastSecondTick = datenum(year2,month2,day2,hour2,minute2,floor(second2));
LastMinuteTick = datenum(year2,month2,day2,hour2,minute2,0);
LastHourTick = datenum(year2,month2,day2,hour2,0,0);
LastDayTick = datenum(year2,month2,day2,0,0,0);
LastMonthTick = datenum(year2,month2,1,0,0,0);
LastYearTick = datenum(year2,1,1,0,0,0);

% Correct for cases for which no tick is available.
if FirstYearTick > LastYearTick,
   FirstYearTick = NaN;
   LastYearTick = NaN;
end % if

if FirstMonthTick > LastMonthTick,
   FirstMonthTick = NaN;
   LastMonthTick = NaN;
end % if

if FirstDayTick > LastDayTick,
   FirstDayTick = NaN;
   LastDayTick = NaN;
end % if

if FirstHourTick > LastHourTick,
   FirstHourTick = NaN;
   LastHourTick = NaN;
end % if

if FirstMinuteTick > LastMinuteTick,
   FirstMinuteTick = NaN;
   LastMinuteTick = NaN;
end % if

if FirstSecondTick > LastSecondTick,
   disp([mfilename '.m--Time range too small to convert to time strings.'])
   error(' ');
end % if

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3) Find the tick values.

MonthTicks = [];
DayTicks = [];
HourTicks = [];
MinuteTicks = [];
SecondTicks = [];

% ...Get the year tick values (Needed for all time units).
if year2>year1 & ~isnan(FirstYearTick) & ~isnan(LastYearTick),
   [FirstVal,dummy,dummy,dummy,dummy,dummy] = datevec(FirstYearTick);
   [LastVal,dummy,dummy,dummy,dummy,dummy] = datevec(LastYearTick);
   YearVector = FirstVal:LastVal;
   YearTicks = roundn(datenum(YearVector,ones(size(YearVector)),ones(size(YearVector))),1/(24*3600) );   
else
   YearTicks = [];
   YearVector = year1;
end % if

BaseUnits = YEARS;
NumYearTicks   = length(YearTicks);
NumMonthTicks  = NaN;
NumDayTicks    = NaN;
NumHourTicks   = NaN;
NumMinuteTicks = NaN;
NumSecondTicks = NaN;

% ...If there are not too many year ticks, get the month tick values.   
if NumYearTicks < MAXMAXTICKS,
   
   % Create a vector of dates marking the start of months. This vector is based on a
   % standard month length and may not coincide with actual month ticks. 
   if isnan(FirstMonthTick),
      MonthTicks = [];
   else
      ApproxNumMonthTicks = ceil( (LastMonthTick - FirstMonthTick)/(365.25/12) ) + 2;
      ApproxMonthTickDates = FirstMonthTick + (365.25/12)*[0:ApproxNumMonthTicks-1];
      
      % Create a vector of integer month numbers.
      [dummy,IntMonths,dummy,dummy,dummy,dummy] = datevec(ApproxMonthTickDates);
      
      % Loop through the integer month numbers and correct for repeated values caused by
      % real months having non-standard lengths.
      while any(diff(IntMonths)~=1),
         RepIndex = min(find(diff(IntMonths)~=1)) + 1;
         IntMonths(RepIndex) = IntMonths(RepIndex) + 1;
      end % while
      
      % "Wrap" months to run from 1 to 12. Adjust years for end-of-years if detected.      
      %IntYears = year1 * ones(size(IntMonths) );
      %IntYears = YearVector(1) * ones(size(IntMonths) );      
      [FirstMonthTickYear,dummy,dummy,dummy,dummy,dummy] = datevec(FirstMonthTick);
      IntYears = FirstMonthTickYear * ones(size(IntMonths) );      

      for MonthCount = 1:length(IntMonths),
         if IntMonths(MonthCount)>12,
            IntMonths(MonthCount:length(IntMonths)) = IntMonths(MonthCount:length(IntMonths)) - 12;
            IntYears(MonthCount:length(IntMonths)) = IntYears(MonthCount:length(IntMonths)) + 1;
         end % if
      end % for
      
      if ~isempty(IntMonths),
         MonthTicks = roundn(datenum(IntYears,IntMonths,ones(size(IntMonths))),1/(24*3600) );
      else
         MonthTicks = [];
      end % if
      
      % Remove any ticks that exceed the time limits of the plot.
      MonthTicks = MonthTicks(MonthTicks <= xlims(2));
      
   end % if isnan  
   
   NumMonthTicks = length(MonthTicks);
   
   % ...If there are not too many month ticks, get the day tick values.  
   if NumMonthTicks < MAXMAXTICKS,
      
      if isnan(FirstDayTick),
         DayTicks = [];
      else
         ApproxNumDayTicks = ceil( (LastDayTick - FirstDayTick) ) + 2;
         DayTicks = roundn( (FirstDayTick + [0:ApproxNumDayTicks-1]),1 ); 
         
         % Remove any ticks that exceed the time limits of the plot.
         DayTicks = DayTicks(DayTicks <= xlims(2));
      end % if isnan      
      
      NumDayTicks = length(DayTicks);
      
      % If there are not too many day ticks, get the hour tick values.
      if NumDayTicks < MAXMAXTICKS,
         
         if isnan(FirstHourTick),
            HourTicks = [];
         else
            ApproxNumHourTicks = ceil( (LastHourTick - FirstHourTick)*(24) ) + 2;
            HourTicks = roundn( (FirstHourTick + [0:ApproxNumHourTicks-1]./24),1/24 ); 
            
            % Remove any ticks that exceed the time limits of the plot.
            HourTicks = HourTicks(HourTicks <= xlims(2));
         end % if isnan      
         
         NumHourTicks = length(HourTicks);
         
         % If there are not too many hour ticks, get the minute tick values.      
         if NumHourTicks < MAXMAXTICKS,
            
            if isnan(FirstMinuteTick),
               MinuteTicks = [];
            else
               ApproxNumMinuteTicks = ceil( (LastMinuteTick - FirstMinuteTick)*(24*60) ) + 2;
               MinuteTicks = roundn( (FirstMinuteTick + [0:ApproxNumMinuteTicks-1]./(24*60)),1/(24*60) ); 
               
               % Remove any ticks that exceed the time limits of the plot.
               MinuteTicks = MinuteTicks(MinuteTicks <= xlims(2));
            end % if isnan      
            
            NumMinuteTicks = length(MinuteTicks);
            
            % If there are not too many minute ticks, get the second tick values.
            if NumMinuteTicks < MAXMAXTICKS,
               
               if ~isnan(FirstSecondTick) & ~isnan(LastSecondTick),
                  
                  ApproxNumSecondTicks = ceil( (LastSecondTick - FirstSecondTick)*(24*60*60) ) + 2;
                  SecondTicks = roundn( (FirstSecondTick + [0:ApproxNumSecondTicks-1]./(24*60*60)),1/(24*60*60) ); 
                  
                  % Remove any ticks that exceed the time limits of the plot.
                  SecondTicks = SecondTicks(SecondTicks <= xlims(2));
                  NumSecondTicks = length(SecondTicks);        
                  
               else
                  disp([mfilename '.m--Time range too small to convert to time strings.'])
                  error(' ');
               end % if
               
            end % if units are seconds.
            
         end % if units minutes or smaller.
         
      end % if units hours or smaller.
      
   end % if units days or smaller.
   
end % if units months or smaller.

% Find the largest time unit for which the number of available ticks
% exceeds the desired minimum number of ticks. This will be the time
% unit by which the time axis will be delineated.
AvailTicks = [NumYearTicks NumMonthTicks NumDayTicks NumHourTicks NumMinuteTicks NumSecondTicks];
BaseUnits = min(find(AvailTicks >= MINTICKS));

% If there is no time unit for which the number of available ticks exceeds
% the desired minimum number of ticks, choose the base time unit to be
% the smallest time unit (i.e., seconds).
if isempty(BaseUnits),
   BaseUnits = SECONDS;
end % if

% Certain variables will control how the time axis ticks will be placed and
% labelled. Assign these variables according to which base time units 
% have been chosen. "MinorTicks" and "MajorTicks" give the tick locations
% as-is, and "TimeJumps" is a vector of permitted increments between
% ticks if they require thinning. "MaxTicks" controls how many ticks can
% be plotted (different date label formats require different amounts of
% space, so MaxTicks varies from one time unit to another).
if BaseUnits == YEARS,
   MinorTicks = YearTicks;
   MajorTicks = [];
   MaxTicks = 8;
   %TimeJumps = [2 5 10 20 25 50 100 200 250 500 1000]; % (open-ended--could expand if needed).
   
   % Allow time length to be open-ended by extending TimeJumps for years as far as
   % dictated by the x-limits.
   BaseYearTimeJumps = [2 2.5 5 10 20 25 50 100 200 250 500 1000]; 
   TimeJumps = [2 2.5 5 10 20 25 50 100 200 250 500 1000];
   
   BasePower = log10(max(BaseYearTimeJumps));
   
   for PowerCount = BasePower:BasePower:BasePower*ceil(log10(ceil(xlims(2)))/BasePower),
      TimeJumps = [TimeJumps BaseYearTimeJumps*10^PowerCount];
   end % for
   
elseif BaseUnits == MONTHS,
   MinorTicks = MonthTicks;   
   MajorTicks = YearTicks;
   MaxTicks = 8;
   TimeJumps = [2 3 4 6 12];
elseif BaseUnits == DAYS,
   MinorTicks = DayTicks;   
   MajorTicks = MonthTicks;
   MaxTicks = 8;
   TimeJumps = [2 5 10 50 100];
elseif BaseUnits == HOURS,
   MinorTicks = HourTicks;   
   MajorTicks = DayTicks;
   MaxTicks = 8;
   TimeJumps = [2 3 4 6 8 12 24];
elseif BaseUnits == MINUTES,
   MinorTicks = MinuteTicks;   
   MajorTicks = HourTicks;
   MaxTicks = 8;
   TimeJumps = [2 5 10 15 30 60];
elseif BaseUnits == SECONDS,
   MinorTicks = SecondTicks;   
   MajorTicks = MinuteTicks;
   MaxTicks = 6;
   TimeJumps = [2 5 10 15 30 60];
end % if

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4) Thin the ticks if necessary.

% Thin the number of ticks if there are too many to fit nicely on a plot
% axis. Thin the ticks in such a way that the "major" ticks are not
% skipped.
if length(MinorTicks) <= MaxTicks,
   ThinnedTicks = MinorTicks;
else
   
   NiceTimeJump = TimeJumps(min(find(TimeJumps >= ceil(length(MinorTicks)/MaxTicks))));
   
   % The permitted time jumps have been chosen to ensure that the thinned minor
   % ticks will still include their associated major ticks. This doesn't work
   % for days, however, as months do not always contain the same number of days.
   % For this reason, a rather complicated algorithm that builds up the thinned
   % tick vector from the major ticks has to be used.
   if ~isempty(MajorTicks),
      
      % Fill in any minor ticks prior to the first major tick.
      ThinnedTickIndex = sort(find(MinorTicks == MajorTicks(1)):-NiceTimeJump:1);
      
      % Fill in the minor ticks following each of the major ticks.
      % For each major tick...
      
      for MajorCount = 1:length(MajorTicks),
         
         % If there are more major ticks after this one, only fill in the
         % minor ticks up to the next major tick.
         if MajorCount < length(MajorTicks),
            ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))];
            
            %if BaseUnits == DAYS | BaseUnits == MONTHS,
            %  ThinnedTickIndex = [ThinnedTickIndex (find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump-1):NiceTimeJump:(find(MinorTicks == MajorTicks(MajorCount+1)))];
            %else
            %  ThinnedTickIndex = [ThinnedTickIndex (find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump):NiceTimeJump:(find(MinorTicks == MajorTicks(MajorCount+1)))];
            %end % if   
            
            % All time units start with a value of 0, except for days and months, which start with values of 1. For months, this
            % doesn't matter for thinning, but to get day ticks with nice, round values, they need to be thinned differently.
            if BaseUnits == DAYS,
               ThinnedTickIndex = [ThinnedTickIndex (find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump-1):NiceTimeJump:(find(MinorTicks == MajorTicks(MajorCount+1)))];
            else
               ThinnedTickIndex = [ThinnedTickIndex (find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump):NiceTimeJump:(find(MinorTicks == MajorTicks(MajorCount+1)))];
            end % if            
            % Else, if this is the last major tick, fill in the remaining minor ticks,
            % (including the current major tick).
         else
            ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))];
            
            % All time units start with a value of 0, except for days and months, which start with values of 1. For months, this
            % doesn't matter for thinning, but to get day ticks with nice, round values, they need to be thinned differently.
            if BaseUnits == DAYS,
               ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump-1:NiceTimeJump:length(MinorTicks)];
            else
               ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump:NiceTimeJump:length(MinorTicks)];
            end % if            
                        
            %if BaseUnits == DAYS | BaseUnits == MONTHS,
            %   ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump-1:NiceTimeJump:length(MinorTicks)];
            %else
            %   ThinnedTickIndex = [ThinnedTickIndex find(MinorTicks == MajorTicks(MajorCount))+NiceTimeJump:NiceTimeJump:length(MinorTicks)];
            %end % if   
                        
         end % if there are more major ticks after this one.
         
      end % for each major tick.      
      
      % Remove minor ticks placed too close to a major tick.
      ThinnedTickIndex = unique(ThinnedTickIndex);
      IsMinorIndex = find(~ismember(MinorTicks,MajorTicks));
      IsMinorIndex = intersect(IsMinorIndex,ThinnedTickIndex);
      
      % ...Get index to points that are too close to the following point.
      if NiceTimeJump > 2,
         IsTooCloseIndex = ThinnedTickIndex(find(diff(ThinnedTickIndex) < NiceTimeJump-1));
      else
         IsTooCloseIndex = ThinnedTickIndex(find(diff(ThinnedTickIndex) < NiceTimeJump));
      end % if
      
      % ...If the point selected is a major point, we don't want to get rid of it. Get
      % rid of the next minor point.
      for TooCloseCount = 1:length(IsTooCloseIndex),
         if ~ismember(IsTooCloseIndex(TooCloseCount),IsMinorIndex),
            IsTooCloseIndex(TooCloseCount) = ThinnedTickIndex(min(find(ThinnedTickIndex>IsTooCloseIndex(TooCloseCount))));
         end % if
      end % for
      
      ThinnedTickIndex = ThinnedTickIndex(~ismember(ThinnedTickIndex,intersect(IsMinorIndex,IsTooCloseIndex)));
      
   else % (if there are no major ticks).
      
      % No major point to anchor the choice of tick values, so try to find a tick value that
      % is divisible by the time increment between the thinned ticks (NiceTimeJump). 
      [CurrYear,CurrMonth,CurrDay,CurrHour,CurrMinute,CurrSecond] = intdatevec(MinorTicks);
      
      if BaseUnits == YEARS,
         ValList = CurrYear;
      elseif BaseUnits == MONTHS,
         ValList = CurrMonth;
      elseif BaseUnits == DAYS,
         ValList = CurrDay;
      elseif BaseUnits == HOURS,
         ValList = CurrHour;
      elseif BaseUnits == MINUTES,
         ValList = CurrMinute;
      elseif BaseUnits == SECONDS,
         ValList = CurrSecond;
      end % if
      
      AnchorIndex = min(find(rem(ValList,NiceTimeJump)==0));
      
      if isempty(AnchorIndex),
         ThinnedTickIndex = 1:NiceTimeJump:length(ValList);
      else
         ThinnedTickIndex = unique([(AnchorIndex:-NiceTimeJump:1) (AnchorIndex+NiceTimeJump:NiceTimeJump:length(ValList))]);
      end % if
      
   end % if ~isempty(MajorTicks)
   
   ThinnedTicks = MinorTicks(ThinnedTickIndex);
   
end % if too many ticks.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5) Create the tick and axis labels.

% Assemble list of labels for the thinned time axis ticks.
% Matlab bug sometimes has datestr(t,13) = '19:59:00', but
% datestr(t,15) = '20:00'. Work around by calling datestr.m
% with format=15, but removing last 3 characters from the
% resulting string to get HH:MM format.
LabelList = [];

% For each tick...
for TickCount = 1:length(ThinnedTicks),
   CurrTick = ThinnedTicks(TickCount);
   [CurrYear,CurrMonth,CurrDay,CurrHour,CurrMinute,CurrSecond] = datevec(CurrTick);
   
   if ~isempty(MajorTicks),
      IsMajorTick = any(CurrTick == MajorTicks);
   else
      IsMajorTick = 0;
   end % if
   
   % If the current tick is a major tick, give it an appropriate label.
   if IsMajorTick,
      if ismember(CurrTick,YearTicks),
         CurrLabel = [datestr(CurrTick,3) ' ' datestr(CurrTick,10)];
      elseif ismember(CurrTick,MonthTicks),
         CurrLabel = datestr(CurrTick,3);
      elseif ismember(CurrTick,DayTicks),
         CurrLabel = [datestr(CurrTick,3) ' ' sprintf('%.2d',CurrDay)];
      elseif ismember(CurrTick,[HourTicks MinuteTicks]),
         CurrLabel = datestr(CurrTick,13);
         CurrLabel = CurrLabel(1:5);
      end % if
      
      % Else, if the current tick is not a major tick, give it a minor tick label.
   else
      if BaseUnits == YEARS,
         CurrLabel = datestr(CurrTick,10);
      elseif BaseUnits == MONTHS,
         CurrLabel = datestr(CurrTick,3);
      elseif BaseUnits == DAYS,
         CurrLabel = sprintf('%.2d',CurrDay);
      elseif BaseUnits == HOURS,
         CurrLabel = datestr(CurrTick,13);
         CurrLabel = CurrLabel(1:5);
      elseif BaseUnits == MINUTES,
         CurrLabel = datestr(CurrTick,13);
         CurrLabel = CurrLabel(1:5);
      elseif BaseUnits == SECONDS,
         CurrLabel = datestr(CurrTick,13);
      end % if
      
   end % if
   
   LabelList = [LabelList '|' CurrLabel];
   
end % for TickCount

if ~isempty(LabelList),
   LabelList(1) = [];
end % if

% Build a time axis label. The label should include information not included in the
% tick labels (e.g., the year if there are no year ticks on the time axis).
if BaseUnits == YEARS,
   TimeLabelStr = 'Time [years]';
elseif BaseUnits == MONTHS,
   if isempty(YearTicks),
      TimeLabelStr = ['Time [months in ' num2str(year1) ']'];
   else
      TimeLabelStr = ['Time [months in ' num2str(year1) '-' num2str(year2) ']'];
   end % if
   
elseif BaseUnits == DAYS,
   if isempty(MonthTicks),
      TimeLabelStr = ['Time [days in ' char(MonthList{month1}) ' ' num2str(year1) ']'];
   elseif isempty(YearTicks),
      TimeLabelStr = ['Time [days in ' char(MonthList{month1}) '-' char(MonthList{month2}) ' ' num2str(year1) ']'];
   else
      TimeLabelStr = ['Time [days in ' char(MonthList{month1}) ' ' num2str(year1) '-' char(MonthList{month2}) ' ' num2str(year2) ']'];
   end % if
   
elseif BaseUnits == HOURS | BaseUnits == MINUTES | BaseUnits == SECONDS,
   if isempty(DayTicks),
      TimeLabelStr = ['Time on ' char(MonthList{month1}) ' ' sprintf('%.2d',day1) ', ' num2str(year1)];
   elseif isempty(MonthTicks),
      TimeLabelStr = ['Time in ' char(MonthList{month1}) ' ' sprintf('%.2d',day1) '-' sprintf('%.2d',day2) ', '  num2str(year1)];
   elseif isempty(YearTicks),
      TimeLabelStr = ['Time in ' char(MonthList{month1}) ' ' sprintf('%.2d',day1) '-' char(MonthList{month2}) ' ' sprintf('%.2d',day2) ', '  num2str(year1)];
   else
      TimeLabelStr = ['Time in ' char(MonthList{month1}) ' ' sprintf('%.2d',day1) ', ' num2str(year1) '-' char(MonthList{month2}) ' ' sprintf('%.2d',day2) ', '  num2str(year2)];
   end % if
   
end % if


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6) Set the tick positions and labels.

% Convert tick positions back to original plot time units.
ThinnedTicks = (ThinnedTicks - DatumTime).*XLimFactor;
set(gca,'xtick',ThinnedTicks,'xticklabel',LabelList)
kdatetickXlabel = xlabel(TimeLabelStr);
set(kdatetickXlabel,'Tag','kdatetickXlabel');

if nargout == 1,
   XLabelHndl = kdatetickXlabel;
end % if

%------------------------------------------------------------------------------
function RoundedNumber = roundn(number,increment)
%
% roundn.m--Rounds a number to the nearest specified increment.
%
% For example, specifying an increment of .01 will cause the input
% number to be rounded to the nearest one-hundredth while an increment
% of 25 will cause the input number to be rounded to the nearest
% multiple of 25. An increment of 1 causes the input number to be
% rounded to the nearest integer, just as Matlab's round.m does.
%
% Roundn.m works for scalars and matrices.
%
% Syntax: RoundedNumber = roundn(number,increment);
%
% e.g., RoundedNumber = roundn(123.456789,.01)
% e.g., RoundedNumber = roundn(123.456789,5)

% Kevin Bartlett (bartlettk@dfo-mpo.gc.ca) 08/1999
%------------------------------------------------------------------------------

if increment == 0,
   error('roundn.m--Cannot round to the nearest zero.')
end % if

multiplier = 1/increment;
RoundedNumber = round(multiplier*number)/multiplier;

%------------------------------------------------------------------------------
function [year,month,day,hour,minute,second] = intdatevec(time)
%
% intdatevec.m--Calls Matlab's datevec.m function, but rounds the seconds value
% up or down to the nearest integer.
%
% If called with 1 or 0 output arguments, intdatevec.m returns the year, 
% month, day, hour, minute and second values in a single vector variable.
% [year,month,day,hour,minute,second] = intdatevec(time) returns the 
% components of the date vector as individual variables.
%
% Syntax: [year,month,day,hour,minute,second] = intdatevec(time)
%
% e.g., DateVector = intdatevec(datenum(1999,12,31,23,59,59.9))
% e.g., [year,month,day,hour,minute,second] = intdatevec(datenum(1999,12,31,23,59,59.9))

% Kevin Bartlett (bartlettk@dfo-mpo.gc.ca) 11/1999
%------------------------------------------------------------------------------
% Tests for development:
% start = datenum(1999,12,31,23,59,59.9);DateVector = intdatevec([start:.2:start+3])

% Make sure time is a column vector.
time = time(:);

% Run Matlab's datevec.m function.
DateVector = datevec(time);

% Round the seconds to the nearest integer value.
DateVector(:,6) = round(DateVector(:,6));

% Carry over the rounding to the other elements of the date vector.

% ...minutes:
FindIndex = find(DateVector(:,6)>=60);

if ~isempty(FindIndex),
   DateVector(FindIndex,5) = DateVector(FindIndex,5) + 1;
   DateVector(FindIndex,6) = 0;
end % if

% ...hours:
FindIndex = find(DateVector(:,5)>=60);

if ~isempty(FindIndex),
   DateVector(FindIndex,4) = DateVector(FindIndex,4) + 1;
   DateVector(FindIndex,5) = 0;
end % if

% ...days:
FindIndex = find(DateVector(:,4)>=24);

if ~isempty(FindIndex),
   DateVector(FindIndex,3) = DateVector(FindIndex,3) + 1;
   DateVector(FindIndex,4) = 0;
end % if

% ...months:
InputYear = DateVector(:,1);
InputMonth = DateVector(:,2);
DaysInMonth = eomday(InputYear,InputMonth);

FindIndex = find(DateVector(:,3)>DaysInMonth);

if ~isempty(FindIndex),
   DateVector(FindIndex,2) = DateVector(FindIndex,2) + 1;
   DateVector(FindIndex,3) = 1;
end % if

% ...years:
FindIndex = find(DateVector(:,2)>12);

if ~isempty(FindIndex),
   DateVector(FindIndex,1) = DateVector(FindIndex,1) + 1;
   DateVector(FindIndex,2) = 1;
end % if

if nargout <= 1,
   year = DateVector;
else
   year   = DateVector(:,1);
   month  = DateVector(:,2);
   day    = DateVector(:,3);
   hour   = DateVector(:,4);
   minute = DateVector(:,5);
   second = DateVector(:,6);
end % if


clear, clc
%Set the scenario start and end time (eventually controlled from config file)
scenariostart = datetime(2020,12,23,18,00,00);
scenarioend = datetime(2021,3,23,18,00,00);

%Create a int variable representing the number of seconds in the mission 
s = int32(seconds(scenarioend - scenariostart));

% Create a time vector 
time = [1:1:s]';

access = dur("CONUSAccess(1).txt",scenariostart);

% Determine the length of the access array (basically, how many times the
% satellite will be able to "see" CONUS/GNDSTs
access_length = length(access);

bool = zeros(1,s)';

% Create a vector that will serve as a running total of the data in the
% satellite
data = zeros(1, s)';

% Loop through the entire access array
for i = 1:length(access)
   % Loop through the data array where the access is happening
   for j = access(i,1):access(i,2)
    % Basically, where there is an access time flip the boolean
     bool(j) = 1;
   end
end


data = zeros(1, s)';

for i = 2:length(data)
    if(bool(i) == 1)
        % Where there is a boolean in bool add 48 bits to the last element's value and it set it to the current element
        data(i) = data(i-1) + 48;
    else
        % If the bool array is false, keep the data the same as the last element
        data(i) = data(i-1);
    end;
end;

plot(time, data);
title("BMAP Data Generation over one day");
xlabel("Seconds [s]");
ylabel("Total bytes of data generated [B]");

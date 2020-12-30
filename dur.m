function access = dur(textfile,scenariostart)
    %Detect how MATLAB will import the text file from STK
    opts = detectImportOptions(textfile);

    %Change the variable types imported so that every cell is a string
    opts = setvartype(opts,{'Var1','Var2','Var4','Var5','Var6','Var8','Var9','Var10'},'char');

    %Read the table into MATLAB and turn it into an array
    accesstable = readtable(textfile,opts);
    acc = table2array(accesstable);

    %Finding the number of times the satellite can "see" CONUS/GNDST
    acc_length = length(acc)-6;

    %Preallocating the arrays so the program runs faster
    a1 = zeros(acc_length,6);
    a2 = zeros(acc_length,6);
    datetime_start = NaT(acc_length);
    datetime_end = NaT(acc_length);
    duration_start = duration(NaN(acc_length,3));
    duration_end = duration(NaN(acc_length,3));
    
    for i = 1:acc_length
        % Create a vector of start times in DD MMM YYYY HH:MM:SS:MS format
        %start_times(i) = strcat(acc(i,2)," ",acc(i,3)," ",acc(i,4)," ",acc(i,5));
    
        % Create a datevector in the format DD MMM YYYY HH:MM:SS:MS. This
        % will also convert the values from string to int
        a1(i,1:6) = datevec(strcat(acc(i,2)," ",acc(i,3)," ",acc(i,4)," ",acc(i,5)));
    
        % Create a datetime object using the datevector, this will put it in the
        % MM-DD-YYYY HH:MM:SS format 
        datetime_start(i) = datetime(a1(i,1),a1(i,2),a1(i,3),a1(i,4),a1(i,5),a1(i,6));
    
        %Create a vector of the duration between the datetime object and
        %scenariostart. This will take into account months having different
        %number of days, leap years, etc.
        duration_start(i) = datetime_start(i) - scenariostart;
    
        %Perform the same calculations for the endtime
        a2(i,1:6) = datevec(strcat(acc(i,6)," ",acc(i,7)," ",acc(i,8)," ",acc(i,9)));
        datetime_end(i) = datetime(a2(i,1),a2(i,2),a2(i,3),a2(i,4),a2(i,5),a2(i,6));
        duration_end(i) = datetime_end(i) - scenariostart;
    end

    %Create an array representing the seconds since scenario start for start
    %and end times for access over GNDSTs
    access = [int32(seconds(duration_start)),int32(seconds(duration_end))];
end
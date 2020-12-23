clear, clc

%Detect how MATLAB will import the text file from STK
opts = detectImportOptions("CONUSAccess(1).txt");

%Change the variable types imported so that every cell is a string
opts = setvartype(opts,{'Var1','Var2','Var4','Var5','Var6','Var8','Var9','Var10'},'char');

%Read the table into MATLAB and turn it into an array
accesstable = readtable("CONUSAccess(1).txt",opts);
acc = table2array(accesstable);

%Set the scenario start time (eventually controlled from config file)
scenariostart = datetime(2020,12,24);

for i = 1:length(acc)-6
    start_times(i) = strcat(acc(i,2)," ",acc(i,3)," ",acc(i,4)," ",acc(i,5));
    a1(i,1:6) = datevec(start_times(i));
    datetime_start(i) = datetime(a1(i,1),a1(i,2),a1(i,3),a1(i,4),a1(i,5),a1(i,6));
    duration_start(i) = datetime_start(i) - scenariostart;

    end_times(i) = strcat(acc(i,6)," ",acc(i,7)," ",acc(i,8)," ",acc(i,9));
    a2(i,1:6) = datevec(end_times(i));
    datetime_end(i) = datetime(a2(i,1),a2(i,2),a2(i,3),a2(i,4),a2(i,5),a2(i,6));
    duration_end(i) = datetime_end(i) - scenariostart;
end;

sec_start = seconds(duration_start);
sec_end = seconds(duration_end);

sec = [seconds(duration_start);seconds(duration_end);seconds(duration_end)-seconds(duration_start)]';



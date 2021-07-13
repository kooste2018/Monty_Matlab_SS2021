%the function to extract data as specified. the input matFileContent is
%strange, just give anything when you use this function. to use this function e.g.
%[your_X,your_Y]=extractData(1,"Group_4_Walk_3_S.mat",70,4)

%be sure that all mat files are in the same folder!
%be sure that raw data is exactly saved in given manner, data and time
%array, in my case, it is a timetable called data and a double array called
%time, this will be imported as a struct.

%more specification can be found in script.

function [X,Y]=extractData(matFileContent,filename,samplingRateHz,windowWidthSeconds)
flag=true;%set a flag for extracting, if any error occurs, this function will not run 
fp=fopen('log_of_data_extraction.txt','w');%to save information in log file
%load file, check if file in the same path, add path to get file
addpath("TrainingData");
addpath("TestData");
if exist(filename,"file")==0
    fprintf(fp,"the file doesn't exist. check your path or name please.\n");
    flag=false;
else
    fprintf(fp,"the file seems to exist.\n");
    matFileContent=load(filename);
    %check if file follows the specifications and add some basical auto-corrections
    if contains(filename,'_N.mat')|contains(filename,'_S.mat')%go further only if the file name is correct
        fprintf(fp,"the file name seems to be correct.\n");
        if isfield(matFileContent,"data")&isfield(matFileContent,"time")%if variables exist
            fprintf(fp,"two variables exist\n");
            if istimetable(matFileContent.data)%since I had such a mistake, it is useful to check
                matFileContent.data=table2array(matFileContent.data);%convert timetable data to matrix if ... 
            end
            if istimetable(matFileContent.time)
                matFileContent.time=table2array(matFileContent.time);%convert timetable time to array if ...
            end
            %check if data has the specified format, 3xM double matrix and 1xM double array 
            matFileContent.data=double(matFileContent.data);%ensure it is double
            matFileContent.time=double(matFileContent.time);
            minimum=50*3.4;%the minimum amount of data points
            if size(matFileContent.data,1)==3
                if size(matFileContent.data,2)>=minimum%check if data too little
                    fprintf(fp,"data specification satisfied.\n");
                else
                    fprintf(fp,"error: data minimal length not satisfied.\n");
                    flag=false;
                end
            else
                matFileContent.data=matFileContent.data';%transpose to 3xM
                if size(matFileContent.data,2)>=minimum%check again
                    fprintf(fp,"data specification satisfied.\n");
                else
                    fprintf(fp,"error:data minimal length not satisfied.\n");
                    flag=false;
                end            
            end
            if length(matFileContent.time)==size(matFileContent.data,2)%check time length
                fprintf(fp,"time length same as data\n");
                if size(matFileContent.time,1)~=1
                    matFileContent.time=matFileContent.time';%transpose if not 1xM
                end
            else
                fprintf(fp,"error: time length not same as data\n");
                flag=false;
            end 
        else
            fprintf(fp,"error: variable data or time missing.\n");
            flag=false;
        end
    else
        fprintf(fp,"error: the file name seems to be wrong, try again.\n");
        flag=false;
    end
end


% do extracting if flag is true, the file is correct
if flag
    %start extracting data
    %resample, the given data can have different frequencies and the new sampling rate can be lower or higher.
    %in this part I will resample it with default interpolation(linear).
    interval=1/samplingRateHz;
    new_time=matFileContent.time(1):interval:matFileContent.time(end);
    new_time_amount=numel(new_time);
    %the default order is xyz -> 123. since the raw data could be a matrix without xyz label,
    %it is not possible to detect automatically, let's just suppose every group follows default order
    new_X = interp1(matFileContent.time,matFileContent.data(1,:),new_time);%interplation with new frequency 
    new_Y = interp1(matFileContent.time,matFileContent.data(2,:),new_time);
    new_Z = interp1(matFileContent.time,matFileContent.data(3,:),new_time);
    new_data=[new_X;new_Y;new_Z];%3xM
    %window
    windowWidth=windowWidthSeconds*samplingRateHz;%define amount of data points in a window
    windowWidth=floor(windowWidth/2)*2;%round it towards 0 to be even
    window_amount=floor((new_time_amount-windowWidth)/(windowWidth/2))+1;%calculate amount of windows, the window must have full length, so use floor to round
    %suppose n+1 windows, n=0,1,2,3...
    X=cell(window_amount,1);%create cell and start slicing, the cell should be a column Nx1, see script page 13
    for i=1:window_amount
        start_cell=(i-1)*(windowWidth/2)+1;%start index of current slice/window in the new_data
        end_cell=(i+1)*(windowWidth/2);%end index of ...
        X(i)={new_data(:,start_cell:end_cell)};%save data into cell 
    end
    %categorial
    if contains(filename,'_N.mat')%detect if the given file name has this part and determine label Y
         Y=categorical(ones(window_amount,1),1,'Normal walk');% categorically, Nx1, see script page 13
    else %the name is verified before, no more other possibilities
         Y=categorical(ones(window_amount,1),1,'Silly walk');
    end
else
    fprintf("error: something is wrong, the function is not executed, see log_of_data_extraction.txt.\n");
end
fclose(fp);%close file
end%function end
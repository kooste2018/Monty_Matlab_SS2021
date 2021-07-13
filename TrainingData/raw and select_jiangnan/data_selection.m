%script for data selection, to remove start and end useless data, to save 
%data in default form Group<k>_Walk<l>_N.mat or Group<k>_Walk<l>_S.mat
%my reserved index is 1-4
%raw data:60hz 
%ignore: first 10s and last 10s, 601:end-600

clear 
clc
rawfilelist=dir('*.mat');
for i=1:numel(rawfilelist)
    load(rawfilelist(i).name);
    data=Acceleration(601:end-600,:);
    len=length(data.X);
    time=linspace(0,len/60,len);
    data=table2array(data)';
    if contains(rawfilelist(i).name,'s')
        newfilename=strcat('C:\Users\hjn_local\OneDrive\master_studium\3.semester\Monty Matlab\project\g4-21\TrainingData\','Group4_Walk',num2str(i),'_S.mat');
    else
        newfilename=strcat('C:\Users\hjn_local\OneDrive\master_studium\3.semester\Monty Matlab\project\g4-21\TrainingData\','Group4_Walk',num2str(i),'_N.mat');
    end
    save(newfilename,'data','time');
end


    

%normal 
% clear
% clc
% load("n1.mat");
% n=15;
% data=Acceleration(601:600+170*n,:);
% len=length(data.X);
% data=table2array(data)';
% time=linspace(0,len/60,len);
% save('..\Group4_Walk1_N.mat','data','time');
% 
% %silly 1
% clear
% clc
% load("s1.mat");
% n=19;
% data=Acceleration(601:600+170*n,:);
% len=length(data.X);
% data=table2array(data)';
% time=linspace(0,len/60,len);
% save('Group4_Walk1_S.mat','data','time');
% %silly 2
% clear
% clc
% load("s2.mat");
% n=14;
% data=Acceleration(601:600+170*n,:);
% len=length(data.X);
% data=table2array(data)';
% time=linspace(0,len/60,len);
% save('Group4_Walk2_S.mat','data','time');
% %silly 3
% clear
% clc
% load("s3.mat");
% n=11;
% data=Acceleration(601:600+170*n,:);
% len=length(data.X);
% data=table2array(data)';
% time=linspace(0,len/60,len);
% save('Group4_Walk3_S.mat','data','time');
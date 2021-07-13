function model = train(path,SamplingRate,WindowWidth)
XTrain=[];
YTrain=[];
namelist = dir(fullfile(path,'*.mat'));
len = length(namelist);
for i = 1:len
    file_name=namelist(i).name;
    X=[];
    Y=[];
    
    [X, Y] = extractData(1,file_name,SamplingRate,WindowWidth);%resampling specification must be given!
    XTrain=[XTrain;X];
    YTrain=[YTrain;Y];
end
model = trainSillyWalkClassifier(XTrain, YTrain);
save('Model.mat','model');
end

function Accuracy = classify(path,modelname,SamplingRate,WindowWidth)
XTest=[];
YTest=[];
namelist = dir(fullfile(path,'*.mat'));
len = length(namelist);
for i = 1:len
    file_name = namelist(i).name;
    X = [];
    Y = [];
    [X, Y] = extractData(1,file_name,SamplingRate,WindowWidth);
    XTest=[XTest;X];
    YTest=[YTest;Y];
end
for i =1:size(XTest,1)
    XTest{i} = XTest{i};
end
load(modelname, 'model')
YPred = classifyWalk(model, XTest);
num = (YPred == YTest);
correct = sum(sum(num~=0));
Accuracy = correct/size(YTest,1);
end

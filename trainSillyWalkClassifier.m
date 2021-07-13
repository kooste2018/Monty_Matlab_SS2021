%%
function model = trainSillyWalkClassifier(XTrain, YTrain)
% For this trivial example, no model is required. 
inputSize = 3;
numHiddenUnits = 100;
numClasses = 2;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    dropoutLayer
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];


maxEpochs = 15;
miniBatchSize = 32;
options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','once', ...
    'Verbose',0, ...
    'Plots','training-progress');

model = trainNetwork(XTrain,YTrain,layers,options);

save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line

end

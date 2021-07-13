# README
This is the project repository of Monty Matlab 2021. The data for training and test can be found in the TrainingData or TestData folder. The rest code and files are in the root directory. 

## Install the repository
The repository can be install via `git clone` e.g. `git clone https://gitlab.ldv.ei.tum.de/monty/g4-21.git` in the current directory or downloaded from Gitlab and unzipped. In principle the code can run without error directly if the Matlab and used Toolbox are installed previously. If you get any error such as 

*Deep Learning Toolbox is needed*

 please follow the instruction and install. About Matlab version, our recommendation is Matlab 2021a. 

## Run manually: 
1. use `model = train(path,SamplingRate,WindowWidth)` to train and save model in **Model.mat**, e.g. `model=train(fullfile(pwd,'TrainingData'),50,3.4)`
2. use `Accuracy = classify(path,modelname,SamplingRate,WindowWidth)` to test model and get *Accuracy*, e.g. `Accuracy = classify(fullfile(pwd,'TestData'),'Model.mat',50,3.4)`

## Run graphically:
1. run `GUI` command in Matlab Command Window and configure parameters
2. choose mode *Train* or *Test* to start
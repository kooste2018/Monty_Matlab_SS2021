function YPred = classifyWalk(model, XTest)
    YPred = categorical(repmat({'Normal walk'}, size(XTest)));
    predictions = predict(model, XTest);
    for i=1:size(predictions,1)
        if predictions(i,1)<0.5
            YPred(i)='Silly walk'; 
        else
            YPred(i)='Normal walk';
        end   
    end
end



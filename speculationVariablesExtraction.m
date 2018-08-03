%% This Function Computes all Speculation-Related Variables
%__________________________________________________________

function [speculationFrequency_data, speculation_data, speculationFrequency_model, speculation_model, index] = ...
                                speculationVariablesExtraction(modelPrediction, modelProba, con, subjects,...
                                statNumber, startGood, partnersType, proposedGood, willToExchange)

% Variables Tweaking
%___________________

% Computational Data
%-------------------

for m = 1 : 2
    
    modelSpeculation{m}      = nan(36,53);
    modelSpeculationProba{m} = nan(36,53);
    
    for s = 1 : numel(subjects)
        
        modelSpeculation_0{m}{s}       = modelPrediction{m}{s}(con{s}==4);
        modelSpeculationProba_0{m}{s}  = modelProba{m}{s}(con{s}==4);
        
        vectorSize = size(modelSpeculation_0{m}{s},1);
        
        modelSpeculation{m}(1:vectorSize,s)       = modelSpeculation_0{m}{s};
        modelSpeculationProba{m}(1:vectorSize,s)  = modelSpeculationProba_0{m}{s};
        
    end
    
    speculationFrequency_model{m} = nanmean(modelSpeculationProba{m});
    
end

speculation_model = modelSpeculationProba;


% Behavioural Data
%-----------------

speculation_data = nan(36,53);
    
for s = 1 : numel(subjects)

    speculationFrequency_data(1,s) = nanmean(willToExchange(startGood(:,1)==2 & partnersType(:,1)==2 & proposedGood(:,1)==3 &...
        statNumber(:,1)==subjects(s),1));
    
    speculation_data_0{s} = willToExchange(startGood(:,1)==2 & partnersType(:,1)==2 & proposedGood(:,1)==3 & statNumber(:,1)==subjects(s),1);
    
    vectorSize = max(size(speculation_data_0{s}));
    
    speculation_data(1:vectorSize, s) = speculation_data_0{s};
        
end


index = speculationFrequency_data > 0.5;


end







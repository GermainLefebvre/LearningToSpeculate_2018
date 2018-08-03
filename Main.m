%% This Script Plots Behavioural and Computational Data
%______________________________________________________

clear variables
close all
clc

% Loading Behavioural Data
%-------------------------

load Data_LearningToSpeculate_2018

% Computing Model Predictions
%----------------------------

for model = 1:2    % Number of Model of Interest
    
    for sub = 1 : numel(subjects) % Number of Subjects
                                    
                [modelPrediction{model}{sub}, modelProba{model}{sub}]  = ...
                Computational_Models(parameters{model}(sub,:),con{sub},cho{sub},out{sub},model,priors{model},lastR{sub},economyParameters,actualExchange{sub}); 

    end
    
end

%  Speculation Variable Computation
%----------------------------------

[speculationFrequency_data, speculation_data, speculationFrequency_model, speculation_model, index] = ...
    speculationVariablesExtraction(modelPrediction, modelProba, con, subjects, statNumber, startGood, partnersType, proposedGood, willToExchange);

% Plotting Speculation - Behaviours + Models
%-------------------------------------------

plotSpeculation(speculation_data, speculation_model, index);
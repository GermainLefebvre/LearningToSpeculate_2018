% This function generates the likelihood of each model/parameters
%----------------------------------------------------------------

function [Cm, Pc] = Computational_Models(params, s, a, r, model, goodPriors, lastR, economyParameters,actualExchange)


% Parameters Definition
%----------------------

if model == 1 % TD-RL
    
    temp  = params(1);
    alpha = params(2);
    gamma = params(3);
    
end

if model == 2 % OC-RL

    temp   = params(1);
    alpha  = params(2);
    alphaC = params(3);
   
end

% Variables Initialization
%-------------------------

Q  = goodPriors;
Pc = zeros(1,length(a))+0.5;
Cm = zeros(1,length(a));

% Predictions Computation
%------------------------

for i = 1 : length(a)
    
    if model==1                              % TD-RL
%___________________________________________________
        
        % Model Prediction / Decision
        %----------------------------
        
        [Cm(i), Pc(i)] = softmax_policy(i, s, Q, 1/temp);
        
        % Learning Phase
        %---------------
        
        Q(s(i),a(i)) = tDRL_update(i, s, r, a, Q, alpha, gamma, lastR);
        


    elseif model==2                         % OC-RL
%___________________________________________________

        % Model Prediction / Decision
        %----------------------------
        
        [Cm(i), Pc(i)] = softmax_policy(i, s, Q, 1/temp);

        % Learning Phase
        %---------------
        
        if i == 1
            qYellow = -economyParameters(3);
            qPink   = -economyParameters(4);
        end
        
        [Q, qYellow, qPink] = oCRL_update(i, s, r, a, Q, alpha, alphaC, actualExchange, economyParameters, qYellow, qPink);

    end
end

Cm = Cm'-1;

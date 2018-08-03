% This function generates qLearning model decision from qvalues et states

function [Cm, Pc] = softmax_policy(i, s, Q, iTemp)
        
Pc = 1/(1+exp(((Q(s(i),1)-(Q(s(i),2)))*(iTemp))));
Cm = RandomChoice([(1-Pc) Pc]);

end
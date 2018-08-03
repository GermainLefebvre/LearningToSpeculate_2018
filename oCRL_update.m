% This function updates q-values in the OCRL model
%-------------------------------------------------

function  [updatedQ, qYellow, qPink] = oCRL_update(i, s, r, a, Q, alpha, alphaC, actualExchange, param_extra, qYellow, qPink)

c1 = param_extra(2);
c2 = param_extra(3);
c3 = param_extra(4);
u  = param_extra(5);


if s(i) ~= 2 && s(i) ~= 4 && s(i) ~= 7 && s(i) ~= 12
    
    
    % Operant Conditionning
    %______________________
    
    
    deltaI =  r(i) - Q(s(i),a(i));
    
    Q(s(i),a(i)) = Q(s(i),a(i)) + alpha * deltaI;
    
    
    % Classical Conditionning
    %________________________
    
    % Opportunity Cost calculation
    %-----------------------------
    
    if s(i)<= 6
        oC = max(Q(s(i)+6,:));
    else
        oC = max(Q(s(i)-6,:));
    end
    
    
    % Reward Net From Opportunity Costs (in case of non exchange)
    %------------------------------------------------------------
    
    
    if actualExchange(i) == 1
        
        netReward = r(i);
        
    else
        
        netReward = r(i) - oC;
        
    end
    
    % Update
    %-------
    
    if s(i) <= 6
        
        qYellow = qYellow + alphaC * (netReward - qYellow) * (actualExchange(i)==0) + alpha * (netReward - qYellow) * (actualExchange(i)==1);
        
        Q(2,1)  = qYellow;
        Q(4,1)  = qYellow;
        
        Q(7,2)  = qYellow;
        Q(12,2) = qYellow;
        
    else
        
        qPink = qPink + alphaC * (netReward - qPink) * (actualExchange(i)==0) + alpha * (netReward - qPink) * (actualExchange(i)==1);
        
        Q(2,2)  = qPink;
        Q(4,2)  = qPink;
        
        Q(7,1)  = qPink;
        Q(12,1) = qPink;
        
    end
    
end

updatedQ = Q;

end

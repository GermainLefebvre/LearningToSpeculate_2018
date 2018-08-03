% This function updates q-values in the TDRL model
%-------------------------------------------------

function  updatedQ = tDRL_update(i, s, r, a, Q, alpha, gamma, lastRound)

if lastRound(i)==0 && r(i)~=max(r)
    
    deltaI =  r(i) + gamma * max(Q(s(i+1),:))  - Q(s(i),a(i));
    
else
    
    deltaI =  r(i) - Q(s(i),a(i));

end

updatedQ = Q(s(i),a(i)) + alpha * deltaI;

end
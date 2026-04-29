function X = ProbaDiscrete(nbr_boules)
    poignee1 = randi([1 nbr_boules]);
    poignee2 = randi([1 nbr_boules-1]);
    if poignee1 <= poignee2
        X = poignee1;
    else
        X = poignee2;
    end
    
end
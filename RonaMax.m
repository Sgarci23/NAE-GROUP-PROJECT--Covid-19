function [MaxB,DayB,MaxA,DayA] = RonaMax(states,cases,datess)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% INPUT: 
% Data = Cases reported each day
% OUTPUT: 
% Max = Max cases and corresponding day
% Day_R = The day those cases were reported

    St = menu('Select a state or US',states);
    while St == 0
        St = menu('Select a state or US',states);
    end
    if St <= 50
        [MaxB,MrowB] = max(cases(St,1:154));
        [MaxA,MrowA] = max(cases(St,155:end));
        DayB = datess{MrowB};
        DayA = datess{MrowA};
        
        
        
        
        
        
        
    end
    if St == 51
        [MaxB,MrowB] = max(max(cases(:,1:154)));
        [MaxA,MrowA] = max(max(cases(:,155:end)));
        DayB = datess{MrowB};
        DayA = datess{MrowA};
        
        
        
        
    end
    Stat = states{St};
     fprintf('The max amount of cases in %s before the mask mandate was %.0f on %s, and after the max was %.0f on %s\n',Stat,MaxB,DayB,MaxA,DayA)
end

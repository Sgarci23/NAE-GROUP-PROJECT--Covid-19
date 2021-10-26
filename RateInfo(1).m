function [highestRateDate, overallAvgRate, maxRate, maxRateState, stateProjections, projections] = RateInfo(states,cases,dates)
    %PURPOSE: To determine information of COVID spread rates. Specifically,
    %the overall average rate, the max rate, the
    %state with the highest rate, and if the overall rate is increasing
    %or decreasing for all states and individual states.
    
    %INPUTS: A string vector with a list of states, a matrix with the
    %number of cases per state per day, and a string vector with the dates
    
    %OUPUTS:The date when the highest rate was recorded in all states.
    % The overall average rate, the max rate, and the state with the
    %largest rate. A variable names Projections that determines
    %if the overall rate of COVID spread is increasing,
    %decreasing or staying constant. An updated matrix that the list of 
    %states and their individual projections.
    
    %Checking that there is data for every state, if not, the function will
    %still work, but not all rates will be calculated
    [r,c] = size(cases);
    if(r>50 || r<50)
        warning("All U.S states are not included. Missing data could result in calculation error.")
        sel = menu("Do you wish to continue?", "Yes", "No");
        while(sel == 0)
            sel = menu("Do you wish to continue?", "Yes", "No");
        end
        if sel == 2
            error("Terminating program.");
        end
    end
    
    %Calculating rate
    rates = cases./24% the number of cases divided by hours in a day.
    
    %finding maxRate and averageRate
    maxRate = max(rates, [], 'all');
    overallAvgRate = mean(rates, 'all');
    
    %finding state with largest rate
    [MRow,MCol] = find(rates==maxRate)
    maxRateState = states(MRow,1);
    
    %finding date with largest rate
    highestRateDate = dates(MCol);
    
    %Projections
    above = 0;
    below = 0;
    constant = 0;
    pos = 1;
    
    %Loop that goes through every row (aka every state) and column (aka
    %each day) and compares the rate of cases.
    for(x = 1:1:r)
        for(y=1:1:c-1)
            if(rates(x,y+1)>rates(x,y))
                above = above+1;
            elseif(rates(x,y+1)<rates(x,y))
                below = below+1;
            elseif(rates(x,y+1) == rates(x,y))
                constant = constant+1;
            end
        end
        
        %determines the projections for individual state
        if(above>below)
            projectionsState(pos) = "Increasing";
        elseif(below>above)
            projectionsState(pos) = "Decreasing";
        elseif(constant>below && constant>above)
            projectionsState(pos) = "Constant";
        end
        
        %resetting values to find the next state's rate
        above = 0;
        below = 0;
        constant = 0;
        pos = pos + 1;
    end
    
    %list of state with their projections
    stateProjections = [states,projectionsState'];
    
    %finding overall projection from all states
    countIncreasing = 0;
    countDecreasing = 0;
    countConstant = 0;
    for(n=1:1:length(projectionsState))
        if(projectionsState(n) == "Increasing")
            countIncreasing = countIncreasing+1;
        elseif(projectionsState(n) == "Decreasing")
            countDecreasing = countDecreasing+1;
        elseif(projectionsState(n) == "Constant")
            countConstant = countConstant+1;
        end
    end
    
    if(countIncreasing>countDecreasing && countIncreasing>countConstant)
        projections = "Increasing";
    elseif(countDecreasing>countIncreasing && countDecreasing>countConstant)
        projections = "Decreasing";
    elseif(countConstant>countIncreasing && countConstant>countDecreasing)
        projections = "Constant";
    end
    
end
function  out1 = StateGraph(cases,state,dates,mask,stateName)
    out1=1;
    casesbefore = [];
    casesafter = [];
    yval = length(dates);
    yvall = [];
    yvalll = [];
    asdf = [];
    newname = char(stateName);
    for x=1:yval
        asdf(x) = x;
        if x<mask
            yvall(x) = x;
            casesbefore(x) = cases(x);
            casesafter(x) = 0;
        elseif x>mask 
            yvalll(x) = x;
            casesafter(x) = cases(x);
        end
    end
    if mask > 0
        figure 
        plot(yvall,casesbefore,'r-')
        hold on
        plot(asdf(mask-1:end),casesafter(mask-1:end),'b-')
        xline(mask)
        grid on
        title(sprintf('New COVID-19 Cases in %s',newname));
        xlabel('Date');
        ylabel('Number of New COVID-19 Cases');
        legend('COVID-19 Cases Before Mask Mandate','COVID-19 Cases After Mask Mandate','Day of Mask Mandate');
        xticks([0,31,61,92,122,153,184,214])
        xticklabels({'3/1/20','4/1/20','5/1/20','6/1/20','7/1/20','8/1/20','9/1/20','10/1/20'})
    elseif mask == 0
        figure 
        plot(asdf,cases,'r-')
        grid on
        title(sprintf('New COVID-19 Cases in %s',newname));
        xlabel('Date');
        ylabel('Number of New COVID-19 Cases');
        legend('COVID Cases (No Mask Mandate)');
        xticks([0,31,61,92,122,153,184,214])
        xticklabels({'3/1/20','4/1/20','5/1/20','6/1/20','7/1/20','8/1/20','9/1/20','10/1/20'})
    end
end






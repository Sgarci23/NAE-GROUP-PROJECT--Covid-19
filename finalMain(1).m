%Description/Purpose: The main script will call the individual functions
%based on user input. Data will be displayed and plotted based on which
%function is chosen, and the data is being validated depending on the
%inputs of each function.


%% Data Updating
%%Just using 1 data set
[cases dates] = xlsread('DATA2.xlsx');
daysAfter = xlsread('DaysAfter.xlsx');
cases = abs(cases);
datess = dates(1,:);
datess = datess(2:end);
states = dates(:,1);
states = states(2:end);
Options = ["The max cases per state", "Rates of COVID spread", "The Average Rate of Cases per Day","I want to enter in new data","A graph of COVID-19 Cases by State"];
Sel = menu("Please select from the following: ", Options);

%%menu validation
while (Sel == 0)
    warning("Nothing was selected. Please select an option.");
    Sel = menu("Please select the information you would like: ", options);
end

%data control and if statement based on user selection.
%Individual function calls as well.
again = 1;
while(again == 1)
    Options = ["The max cases per state", "Rates of COVID spread", "The Average Rate of Cases per Day","I want to enter in new data","A graph of COVID-19 Cases by State"];
    Sel = menu("Please select from the following: ", Options);
    
    %%menu validation
    while (Sel == 0)
        warning("Nothing was selected. Please select an option.");
        Sel = menu("Please select the information you would like: ", options);
    end
    
    if (Sel == 1)
        YN = 1;
        while YN == 1
            [MaxB,DayB,MaxA,DayA] = RonaMax(states,cases,datess);
            YN = menu("Would you like to repeat the function?","Yes","No");
        end
    elseif (Sel == 2)
        [highestRateDate, overallAvgRate, maxRate, maxRateState, stateProjections, projections] = RateInfo(states,cases,datess);
        fprintf("The overall average rate is %0.3f.\nThe maximum rate is %0.0f.", overallAvgRate, maxRate);
        for j = 1:length(maxRateState)
            StateStr(j) = string(maxRateState(j));
        end
        fprintf("\nThe state with the largest maximum rate is %s.",StateStr);
        fprintf("\nThe overall rate of COVID spread is %s.",projections);
        for s = 1:length(highestRateDate)
            DateStr(s) = string(highestRateDate(s));
        end
        fprintf("\nThe highest rate occured on %s",DateStr);
        x = menu("Would you like to see individual state projection?","Yes","No");
        while(x == 0)
            x = menu("Would you like to see individual state projection?","Yes","No");
        end
        if x == 1
            anotherState = 1;
            while(anotherState == 1)
                stateSelected = menu("Choose a State: ", stateProjections(:,1));
                while(stateSelected == 0)
                    warning("Nothing was selected. Please select an option.");
                    stateSelected = menu("Choose a State: ", stateProjections(:,1));
                end
                for y = 1:length(stateSelected)
                    SelectedStr(y) = string(stateSelected(y));
                end
                for(y=1:length(states))
                    newStates = string(states(y));
                end
                for(x=1:length(stateProjections))
                    newProjections = string(stateProjections(x));
                end
                stateIndex = str2num(SelectedStr);
                fprintf("In the state of %s, COVID rates are %s", stateProjections(stateIndex, 1), stateProjections(stateIndex,2));
                anotherState = menu("See another state's projection?", "Yes", "No");
                while(anotherState == 0)
                    warning("Nothing was selected. Please select an option.");
                    anotherState = menu("See another state's projection?", "Yes", "No");
                end
            end
        end
    elseif(Sel == 3)
        c = 1;
        while(c == 1)
            VState = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','A2:A52');
            state = menu('Select a State',VState);
            VAsk = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','B2:B52');
            while (VAsk{state}) == 'N'
                fprintf('State has not implemented mandatory mask mandate, select a new state.\n')
                state = menu('select state',VState);
            end
            for x = state
                for i = 1:length(VState)
                    io(i) = string(VState(i));
                end
                DateCell = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','C2:C52');
                ColDB = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','E2:E52');
                ConvertDB = cell2mat(ColDB(x));
                DaysB = ConvertDB;
                ColDA = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','G2:G52');
                ConvertDA = cell2mat(ColDA(x));
                DaysA = ConvertDA;
                ColCB = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','D2:D52');
                ConvertCB = cell2mat(ColCB(x));
                CasesB = ConvertCB;
                ColCA = readcell('CasesBeforeAndAfterMaskMandate.xlsx','Range','F2:F52');
                ConvertCA = cell2mat(ColCA(x));
                CasesA = ConvertCA;
                [AvgR] = BeforeAndAfter(DaysB,CasesB,DaysA,CasesA);
                % AvgR(1,1) = avg cases for before
                % AvgR(1,2) = avg cases after
                if AvgR(1,1) > AvgR(1,2)
                    fprintf('%s had averaged %.0f new COVID cases a day, which prompted them to then implement a mask mandate on %s, which helped slow the spread of new cases lowering the average to %.0f a day as of October 6.\n',io(x),AvgR(1,1),DateCell{x},AvgR(1,2));
                elseif AvgR(1,1) < AvgR(1,2)
                    fprintf('%s had averaged %.0f new COVID cases a day, which prompted them to then implement a mask mandate on %s, where they still saw a raise in the number of new cases averaging %.0f a day as of October 6.\n',io(x),AvgR(1,1),DateCell{x},AvgR(1,2));
                else
                    fprintf('%s had averaged %.0f new COVID cases a day, which prompted them to then implement a mask mandate on %s, where they saw no effect averaging the same number of new cases a day as of October 6.\n',io(x),AvgR(1,1),DateCell{x});
                end
            end
            c = menu("Would you like to repeat the function?","Yes","No");
        end
    elseif (Sel == 4)
        [T,Updata,D,Dates,States,State,num] = UpNumber(states, datess);
    elseif (Sel == 5)
        fdsa = 1;
        while(fdsa == 1)
            stateSel = menu('Select a State:',states);
            mask = daysAfter(stateSel);
            caseSel = cases(stateSel,:);
            stateName = states(stateSel);
            [asdf] = StateGraph(caseSel,stateSel,datess,mask,stateName);
            fdsa = menu("Would you like to repeat the function?","Yes","No");
        end
    end
    again = 0;
    while(again == 0)
        again = menu("Would you like to repeat the program? ", "Yes", "No");
    end
    
end



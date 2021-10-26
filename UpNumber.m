function [T,Updata,D,Dates,States,State,num] = UpNumber(a,b)
% Function purpose: updating the number of cases 
% Inputs: The data in double format with number of cases, The data in cell
% format with states and dates
% Outputs: The updated data with the number of cases after edited,The data
% above the updata, The data below the updata, Dates after adding new
% cases, States, Position where the State was chosen, and the position
% where the new cases in the data



States = b(2:end,1);
State = menu('Which state do you want to add?',States);

Updata = a(State+1,1:end);
Dates = b(1,1:end);
question = 1;
s= " 'mm/dd/yyyy' ";
num = 207;
while question == 1
    num = num+1;
    DateEnter = input(sprintf('Enter a new date as %s : ',s));
    tf = isa(DateEnter,'double');
    while tf == 1
        warning('Please check again. Type in the dates in the correct form!');
        DateEnter = input(sprintf('Enter a new date as %s : ',s));
        DateEnter = datestr(DateEnter,'mm/dd/yyyy',2020);
        tf = isa(DateEnter,'double');
    end
    Dates = [Dates,DateEnter];
    T = sprintf('\nType the new cases for %s  :', string(States(State)));
    Vector = input(T);
    Updata = [Updata,Vector];
    question = menu('Do you want to continue adding cases for that state?','yes','no');
    if question == 0
        warning('Please choose an answer!');
        question = menu('Do you want to continue adding cases for that state?','yes','no');
    end
end

T = a(1:State,1:end);
D = a(State+2:end,1:end);



end
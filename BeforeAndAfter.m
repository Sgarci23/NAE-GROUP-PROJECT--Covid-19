function [AvgR] = BeforeAndAfter(DaysB,CasesB,DaysA,CasesA)
% DaysB days before mandate
% DaysA days after mandate
% CasesB cases before mandate
% CasesA cases after mandate
    AvgB = CasesB./DaysB;
    AvgA = CasesA./DaysA;
    AvgR = [AvgB,AvgA];
% AvgR(1,1) = Average cases before
% AvgR(1,2) = Average cases after
end



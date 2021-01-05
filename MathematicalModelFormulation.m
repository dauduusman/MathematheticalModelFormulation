% All values are stated below in digits without units.
% 
% Trailing zeros are added to some digits.
% 
% A nonfeasible or nonapplicable scenerio is always designated a value of
% NaN.
%
% In the variables below where there is more than a row, each row represents
% a source from the first to the last respectively as stated in the 
% research. Each column represents TP1, TP2, TP3, TP4 and TP5 respectively.


% The variable TripDuration below stores all the trip durations

TripDuration = [ ...
    103 132 140 145 165; ...
    129 157 160 165 185; ...
    102 123 135 140 160; ...
    099 115 135 140 160; ...
    109 124 135 140 160; ...
    096 111 120 125 145; ...
    126 141 155 160 180; ...
    099 115 135 140 160; ...
    127 142 155 160 180; ...
    119 134 145 150 170; ...
    125 139 150 155 175; ...
    186 201 180 185 205; ...
    096 111 120 125 145];

% The variable CyclingDistance below stores all the cycling distances
CyclingDistance = [ ...
    04.7 01.0 00.0 00.0 00.0; ...
    09.0 08.7 00.0 00.0 00.0; ...
    04.5 01.0 00.0 00.0 00.0; ...
    04.0 01.0 00.0 00.0 00.0; ...
    05.7 03.2 00.0 00.0 00.0; ...
    03.5 01.0 00.0 00.0 00.0; ...
    08.5 06.0 00.0 00.0 00.0; ...
    04.0 01.5 00.0 00.0 00.0; ...
    08.7 06.2 00.0 00.0 00.0; ...
    07.3 04.8 00.0 00.0 00.0; ...
    08.1 05.6 00.0 00.0 00.0; ...
    18.5 16.0 00.0 00.0 00.0; ...
    03.5 01.0 00.0 00.0 00.0];

% The variable TripCost below stores all the trip costs per person

TripCost = [ ...
    250 250 350 420 570; ...
    250 250 400 470 620; ...
    250 250 300 370 520; ...
    250 250 300 370 520; ...
    250 250 300 370 520; ...
    250 250 300 370 520; ...
    250 250 350 420 570; ...
    250 250 300 370 520; ...
    250 250 350 420 570; ...
    250 250 400 470 620; ...
    250 250 400 470 620; ...
    250 250 500 570 720; ...
    250 250 250 320 470];

% The variable NoOfCommuters below stores the numbers of commuters

NoOfCommuters = [19; 7; 42; 4; 21; 10; 3; 13; 11; 3; 1; 1; 33];

% The maximum trip duration constraint is set below as 180. 

MaxTripDuration = 180;

% The maximum cycling distance constraint is set below as 6.

MaxCyclingDistance = 6;

% Trip duration feasibility is being checked below and the result being 
% stored in the variable TripDurationFeasibility having same dimension as 
% TripDuration. A feasible scenerio will have a value of 1.

[A,B] = size(TripDuration);

TripDurationFeasibility = NaN(A,B);

for m=1:A
    for n=1:B
        if(TripDuration(m,n) <= MaxTripDuration)
            TripDurationFeasibility(m,n) = 1;
        end
    end
end

% Cycling distance feasibility is being checked below and the result being 
% stored in the variable CyclingDistanceFeasibility having same dimension as 
% CyclingDistance. A feasible scenerio will have a value of 1.

[C,D] = size(CyclingDistance);

CyclingDistanceFeasibility = NaN(C,D);

for m=1:C
    for n=1:D
        if(CyclingDistance(m,n) <= MaxCyclingDistance)
            CyclingDistanceFeasibility(m,n) = 1;
        end
    end
end

% Both the trip duration feasibility and the cycling distance feasibility
% are being checked below. A feasible scenerio for both will have a value
% of 1.

Overallfeasibility = TripDurationFeasibility .* CyclingDistanceFeasibility;

% The cost of the feasible trip patterns is being stored in the variable
% FeasibleTripPatternsCosts below.

FeasibleTripPatternsCosts = Overallfeasibility .* TripCost;

% The minimum amount of the feasible trip patterns costs per person for
% each source is stored in the variable OptimizedTripsCostsPerPerson.

OptimizedTripsCostsPerPerson = min(FeasibleTripPatternsCosts,[],2);

% The minimum amount of the feasible trip patterns costs for each source is
% stored in the variable OptimizedTripsCostsPerSource.

OptimizedTripsCostsPerSource = OptimizedTripsCostsPerPerson .* NoOfCommuters;

% Summation of the minimum amount of the feasible trip patterns costs for
% each source is stored in the variable OverallOptimizedCost.

OverallOptimizedCost = sum(OptimizedTripsCostsPerSource);
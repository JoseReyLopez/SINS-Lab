RATS = {397550}%, 397551, 401056, 401057, 402617}
MOVING_AVERAGE = 50;
SCATTER = 0;

subtrial = 0

for RAT_cell = RATS
    RAT = cell2mat(RAT_cell);
    fprintf('\n-----')
    disp(RAT)
    plot_performance
    xlim auto
    plot_failed_trials
    xlim auto
    %plot_reaction_time
    disp(' ')
    
end


%{
RAT = 401057
MOVING_AVERAGE = 50

%These two scripts accept a rat number and a moving average as parameters
%that can be explicited here

plot_failed_trials
%plot_performance



%%% MORE INTERESTING USE

%% TO CHANGE VIEW HOW SOME PARAMETER BE IT THE MOVING AVERAGE JUST MAKE A 
%  A FOR LOOP WITH THE PARAMETERS YOU WANT CHECKED


for MOVING_AVERAGE = 40:10:50
    plot_performance
end


%% OR FOR CHECKING DIFFERENT RATS, FOR INSTANCE

%{
MOVING_AVERAGE = 50

for RAT = [397551, rat2, rat3, etc etc]  % this wont work on my pc bc i dont have other's data
    plot_performance
end

%}
%% For the reaction time is also possible to select the option show the scatter point for the plot

MOVING_AVERAGE = 20

SCATTER = 1   % 0 NO POINTS, 1 POINTS
plot_reaction_time


%SCATTER = 0   % 0 NO POINTS, 1 POINTS
%plot_reaction_time

%}

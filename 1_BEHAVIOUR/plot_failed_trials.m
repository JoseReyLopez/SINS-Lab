
RAT = 397550

subtrial = 1

if ~exist('RAT')
    RAT = 397551
end

if ~exist('MOVING_AVERAGE')
    MOVING_AVERAGE = 20
end

if ~exist('SAVE_PLOT')
    SAVE_PLOT = 0
end



%%% PARAMETERS

fprintf('\n\n PLOT_FAILED_TRIALS \n\n')

fprintf('\n\n--- PARAMETERS ---')


fprintf('\nRAT = %i\n', RAT)

fprintf('MOVING_AVERAGE = %i \n', MOVING_AVERAGE)

fprintf('-----------------\n')
%%%



R = discrimination_failed_trial(RAT)';

if subtrial
    R = R';
    R = R(sum(R, 2)~=0,:)
    R = R';
end


%Results = [Csp_correct, Csp_correct_later_trials, Csp_incorrect, Csm_correct, Csm_correct_later_trials, Csm_incorrect];
    
figure
hold on

round_size = [];


Csp = [];
Csp_positions = [];

Csm = [];
Csm_positions = [];


round_size = [];


index = [1:1:max(size(R))];


%%



where = (sum(R(1:2,:), 1) ~= 0);
sum_ = sum(R(1:2,:),1);

Csp = [Csp sum_(where)];
Csp_positions = [Csp_positions, index(where==1)];

%%

%%%%%



where = (sum(R(3:4,:), 1) ~= 0);
sum_ = sum(R(3:4,:),1);

Csm = [Csm sum_(where)];

Csm_positions = [Csm_positions, index(where==1)];

%%


%%%%%% EVERYTHING CORRECT SO FAR

%%%% THE REVERSAL PART



parent_directory = strcat(num2str(RAT), '/reversal/', num2str(RAT), '/reversal');
var = split(sort({dir(strcat(parent_directory, ' *')).name}));
if length(size(var)) == 3
    reversal_rounds = [cellfun(@str2num, var(1,:,2))];
elseif length(size(var)) == 2
    reversal_rounds = [cellfun(@str2num, var(2,1))];
end
    
    
round_size = [round_size, max(size(R))];

Csp_prob  = [];
Csp_prob_positions = [];

Csm_prob  = [];
Csm_prob_positions = [];



for reversal_round = 1:length(reversal_rounds)

    R = reversal_failed_trial(RAT, reversal_round)'; 

    if subtrial
        R = R';
        R = R(sum(R, 2)~=0,:)
        R = R';
    end

    
    
    %{
    [Csp_correct, Csp_correct_later_trials, Csp_incorrect, 
    Csp_prob_correct,  Csp_prob_correct_later_trials, Csp_prob_incorrect, 
    Csm_correct, Csm_correct_later_trials, Csm_incorrect,
    Csm_prob_correct,  Csm_prob_correct_later_trials, Csm_prob_incorrect]
    %}
    
    
    index = [sum(round_size):1:sum(round_size) + max(size(R))];
    
    %%%%%%
    
    
    where = (sum(R(1:2,:), 1) ~= 0);
    sum_ = sum(R(1:2,:),1);

    Csp = [Csp sum_(where)];
    Csp_positions = [Csp_positions, index(where==1)];

    
    %%%%%%
    
    where = (sum(R(3:4,:), 1) ~= 0);
    sum_ = sum(R(3:4,:),1);

    Csp_prob = [Csp_prob sum_(where)];
    Csp_prob_positions = [Csp_prob_positions, index(where==1)];

    
    %%%%%%
    
    where = (sum(R(5:6,:), 1) ~= 0);
    sum_ = sum(R(5:6,:),1);

    Csm = [Csm sum_(where)];
    Csm_positions = [Csm_positions, index(where==1)];
    
    
    %%%%%%
   
    where = (sum(R(7:8,:), 1) ~= 0);
    sum_ = sum(R(7:8,:),1);

    Csm_prob = [Csm_prob sum_(where)];
    Csm_prob_positions = [Csm_prob_positions, index(where==1)];
    
    
    round_size = [round_size max(size(R))];    
end

%%

baseline = 0;

plot(Csp_positions, movmean(Csp, MOVING_AVERAGE)-baseline, 'k', 'LineWidth', 3)
plot(Csm_positions, movmean(Csm, MOVING_AVERAGE)-baseline, 'r', 'LineWidth', 3)
plot(Csp_prob_positions, movmean(Csp_prob, MOVING_AVERAGE)-baseline, 'g', 'LineWidth', 3)
plot(Csm_prob_positions, movmean(Csm_prob, MOVING_AVERAGE)-baseline, 'b', 'LineWidth', 3)

disp(RAT)
disp('# trials Cs+')
disp(length(Csp_positions))
disp('# trials Cs-')
disp(length(Csm_positions))
disp('# trials Cs+*')
disp(length(Csp_prob_positions))
disp('# trials Cs-*')
disp(length(Csm_prob_positions))

results = [movmean(Csp, MOVING_AVERAGE), movmean(Csm, MOVING_AVERAGE), ...
    movmean(Csp_prob, MOVING_AVERAGE), movmean(Csp_prob, MOVING_AVERAGE)];

y_max = max(results);

cumsum_rounds = cumsum(round_size);

for r_i = 1:length(round_size)
    if r_i>1
        text(0.8*(round_size(r_i)/2)+cumsum_rounds(r_i-1), y_max * 1.1, strcat('Reversal', {' '}, num2str(r_i-1)))
    else
        text(0.8*(round_size(r_i)/2), y_max*1.1, 'Discrimination')
    end
end

for r_i = 1:length(round_size)
    
    x_p = sum(round_size(1:r_i));
    plot([x_p, x_p], [0 y_max*1.1], 'k:', 'LineWidth',  2)
end

xlabel('# Trials')
ylabel('# of subtrials required for a correct trials')
title(string(strcat('Performance training ;  Number of subtrials per correct trial', ...
    {'  '},{'  '},{'  '},'Rat: ',{'  '}, num2str(RAT), {'  '},{'  '},{'  '}, 'Moving average: ',{' '}, num2str(MOVING_AVERAGE), {' '}, 'trials')))

set(gcf, 'Position', [0 0 1000, 600]);

legend('CS+', 'CS-', 'CS+*', 'CS-*')


set(gcf, 'Position', [0 0 1000, 600]);


shg

%%%% SAVING INFORMATION

failed_trials.Csp_positions = Csp_positions;
failed_trials.Csm_positions = Csm_positions;
failed_trials.Csp_prob_positions = Csp_prob_positions;
failed_trials.Csm_prob_positions = Csm_prob_positions;

failed_trials.Csp = Csp;
failed_trials.Csm = Csm;
failed_trials.Csp_prob = Csp_prob;
failed_trials.Csm_prob = Csm_prob;

failed_trials.round_size = round_size;

%%%

failed_trials.round_size

save(strcat('failed_trials_', num2str(RAT),'.mat'), 'failed_trials')


xlim([0, 1907]);

%%%%



%if SAVE_PLOT
%end
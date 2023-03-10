%RAT = 401057
%MOVING_AVERAGE = 40;
%subtrial = 1


%%% PARAMETERS

fprintf('\n\n PLOT_PERFORMANCE \n\n')

fprintf('\n\n--- PARAMETERS ---')


fprintf('\nRAT = %i\n', RAT)

fprintf('MOVING_AVERAGE = %i \n', MOVING_AVERAGE)

fprintf('-----------------\n')
%%%




%%%% THE DISCRIMINATION PART
figure
clf
hold on

round_size = [];

R = discrimination(RAT);
size(R)

if subtrial
    R = R(sum(R, 2)==1,:)
end

Csp_values = [];
Csm_values = [];
positions_Csp = [];
positions_Csm = [];


Csp_prob_values = [];
Csm_prob_values = [];
positions_Csp_prob = [];
positions_Csm_prob = [];


Csp_correct               = R(:, 1);
Csp_correct_later_trials  = R(:, 2);
Csm_correct               = R(:, 3);
Csm_correct_later_trials  = R(:, 4);
      
%%% THE AMOUNT OF SUBTRIALS FOR DISCRIMINATION OF RAT 397551 IS 1540,
%%% HOWEVER THERE ARE ONLY 1096 SUBTRIALS THAT CORREPOND TO ANY OF THE 4
%%% POSSIBLE CATEGORIES HERE
index_total = sum(R, 2);


index_Csp       = sum([Csp_correct, Csp_correct_later_trials], 2);
x_positions_Csp = [1:1:length(index_Csp)];
x_positions_Csp = x_positions_Csp(index_Csp==1);


positions_Csp = [positions_Csp x_positions_Csp];
Csp_values    = [Csp_values' Csp_correct(index_Csp == 1)];


index_Csm       = sum([Csm_correct, Csm_correct_later_trials], 2);
x_positions_Csm = [1:1:length(index_Csm)];
x_positions_Csm = x_positions_Csm(index_Csm==1);

positions_Csm = [positions_Csm x_positions_Csm];
Csm_values    = [Csm_values' Csm_correct(index_Csm == 1)];


round_size = [round_size, length(index_Csp)];



%%%% THE REVERSAL PART


parent_directory = strcat(num2str(RAT), '/reversal/', num2str(RAT), '/reversal');
var = split(sort({dir(strcat(parent_directory, ' *')).name}));
if length(size(var)) == 3
    reversal_rounds = [cellfun(@str2num, var(1,:,2))];
elseif length(size(var)) == 2
    reversal_rounds = [cellfun(@str2num, var(2,1))];
end
    


for reversal_round = 1:length(reversal_rounds)

    R = reversal(RAT, reversal_round);  

    if subtrial
        R = R(sum(R, 2)==1,:)
    end

    disp(size(R))
    disp(sum(R,1))
    disp(size(R(sum(R, 2)==1,:)))
    disp(size(R(sum(R(1:end-1), 2)==1,:)))
    
    
    
    Csp_correct                    = R(:,1);
    Csp_prob_correct               = R(:,2);
    
    Csp_correct_later_trials       = R(:,3);
    Csp_prob_correct_later_trials  = R(:,4);
    
    Csm_correct                    = R(:,5);
    Csm_prob_correct               = R(:,6);
    
    Csm_correct_later_trials       = R(:,7);
    Csm_prob_correct_later_trials  = R(:,8);
    
    
    index_Csp       = sum([Csp_correct, Csp_correct_later_trials], 2);
    x_positions_Csp = [sum(round_size):1:sum(round_size) + length(index_Csp)];
    x_positions_Csp = x_positions_Csp(index_Csp==1);
    
    positions_Csp = [positions_Csp x_positions_Csp];
    Csp_values    = [Csp_values ; Csp_correct(index_Csp == 1)];
    %plot(x_positions_Csp(index_Csp==1), movmean(Csp_correct(index_Csp == 1)*100, 20))
    
    index_Csp_prob       = sum([Csp_prob_correct, Csp_prob_correct_later_trials], 2);
    x_positions_Csp_prob = [sum(round_size):1:sum(round_size) + length(index_Csp_prob)];
    x_positions_Csp_prob = x_positions_Csp_prob(index_Csp_prob==1);
    
    positions_Csp_prob = [positions_Csp_prob x_positions_Csp_prob];
    Csp_prob_values    = [Csp_prob_values ; Csp_prob_correct(index_Csp_prob == 1)];
    %plot(x_positions_Csp_prob(index_Csp_prob==1), movmean(Csp_correct(index_Csp_prob == 1)*100, 20))
    
    index_Csm       = sum([Csm_correct, Csm_correct_later_trials], 2);
    x_positions_Csm = [sum(round_size):1:sum(round_size) + length(index_Csm)];
    x_positions_Csm = x_positions_Csm(index_Csm==1);
 
    positions_Csm = [positions_Csm x_positions_Csm];
    Csm_values    = [Csm_values ; Csm_correct(index_Csm == 1)];
    %plot(x_positions_Csm(index_Csm==1), movmean(Csm_correct(index_Csm == 1)*100, 20))
    
    
    index_Csm_prob       = sum([Csm_prob_correct, Csm_prob_correct_later_trials], 2);
    x_positions_Csm_prob = [sum(round_size):1:sum(round_size) + length(index_Csm_prob)];
    x_positions_Csm_prob = x_positions_Csm_prob(index_Csm_prob==1);
    
    positions_Csm_prob = [positions_Csm_prob x_positions_Csm_prob];
    Csm_prob_values    = [Csm_prob_values ; Csm_prob_correct(index_Csm_prob == 1)];
    %plot(x_positions_Csm_prob(index_Csm_prob==1), movmean(Csm_correct(index_Csm_prob == 1)*100, 20))
    
    round_size = [round_size length(index_Csp)];
    
end


%%% PLOTTING PART

plot(positions_Csp, movmean(Csp_values, MOVING_AVERAGE)*100, 'k', 'LineWidth', 3)
plot(positions_Csm, movmean(Csm_values, MOVING_AVERAGE)*100, 'r', 'LineWidth', 3)
plot(positions_Csp_prob, movmean(Csp_prob_values, MOVING_AVERAGE)*100, 'g','LineWidth', 3)
plot(positions_Csm_prob, movmean(Csm_prob_values, MOVING_AVERAGE)*100, 'b','LineWidth', 3)




%%%% SAVING INFORMATION

performance.Csp_positions = positions_Csp;
performance.Csm_positions = positions_Csm;
performance.Csp_prob_positions = positions_Csp_prob;
performance.Csm_prob_positions = positions_Csm_prob;

performance.Csp = Csp_values;
performance.Csm = Csm_values;
performance.Csp_prob = Csp_prob_values;
performance.Csm_prob = Csm_prob_values;

performance.round_size = round_size;


save(strcat('performance_', num2str(RAT),'.mat'), 'performance')

%%%%


ylim([0, 110])
title(strcat('Performance Training ; Rat: ', num2str(RAT), '  Moving Average: ' , num2str(MOVING_AVERAGE), ' trials'))
xlabel('# Trials')
ylabel('(%) Accuracy in first trial ')


cumsum_rounds = cumsum(round_size);

for r_i = 1:length(round_size)
    if r_i>1
        text(0.8*(round_size(r_i)/2)+cumsum_rounds(r_i-1), 105, strcat('Reversal', {' '}, num2str(r_i-1)))
    else
        text(0.8*(round_size(r_i)/2), 105, 'Discrimination')
    end
    
end

for r_i = 1:length(round_size)
    
    x_p = sum(round_size(1:r_i));
    plot([x_p, x_p], [0 100], 'k:', 'LineWidth',  2)
end

xlim([0, 3625]);

set(gcf, 'Position', [0 0 1000, 600]);

legend('CS+', 'CS-', 'CS+*', 'CS-*')
%saveas(gcf, 'salvamerda.png','png');

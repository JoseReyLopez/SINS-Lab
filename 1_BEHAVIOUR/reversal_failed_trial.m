function [Results] = reversal_failed_trial(rat, reversal_round)


reversal_results = 0;
trials   = 0;
total    = 0;
per_file = 0;


reversal_head       = ["trial", "subtrial", "currentTone", "SwapSideTrial", "PokeCode", "correctCSp", "correctCSp_corr", "incorrectCSp", "incorrectCSp_corr", "correctCSm", "correctCSm_corr", "incorrectCSm", "incorrectCSm_corr", "initializationTime", "ReactionTime", "MovementTime", "initialization_failures", "timeOut_CentralNosePoke", "ephys_markers"];

subtrial = find(reversal_head == 'subtrial');

load('rat_information.mat');


files = sort({dir(string(strcat(num2str(rat), '/reversal/', num2str(rat), '/reversal ', {' '}, num2str(reversal_round),'/*.csv'))).name});

for day_number = 1:length(files)
    %%% LOADING THE FILE
    
    %disp(day_number)
    %string(files(day_number))
    %strcat(num2str(rat), '/reversal/', num2str(rat), '/reversal ', {' '}, num2str(reversal_round),'/', files(day_number));
    %disp(strcat(num2str(rat), '/reversal/', num2str(rat), '/reversal ', {' '}, num2str(reversal_round),'/', files(day_number)));

    data = importdata(string(strcat(num2str(rat), '/reversal/', num2str(rat), '/reversal ', {' '}, num2str(reversal_round),'/', files(day_number))));

    %%%% FILTERING THE NaNs in the last lines
    last_row = 0;
    
    while sum(isnan(data(end + last_row, 5:16))) ~= 0
        last_row = last_row -1;
    end
    data = data(1:end + last_row, :);
    size(data);
    %%%%

    
    trials = trials + length(unique(data(:,1)));
    total = total + sum([data(end, 5), data(end, 6), data(end, 9), data(end, 10)]);

    % total  += sum([data_day_np[-1, 4], data_day_np[-1, 5], data_day_np[-1, 8], data_day_np[-1, 9]])
    
    %%% SAVE THE MATRIX RESULTS IN THE SAME PLACE 
    if day_number == 1
        reversal_results = data;
    else
        reversal_results = [reversal_results; data];
    end
    
end


data = reversal_results;


%%%%%% REVERSAL   PROCESSING


first_trial = 2;
Tone        = 3;
SwapSide    = 4;
PokeSide    = 5;


if and(reversal_round>0, mod(reversal_round,2)==1)
    
    
    
    %%% CS+
    
    %%% Tone with reward, correct in first trial
     
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                    data(:, SwapSide)    == 1, ...
                                    data(:, Tone)        == conditions_reversal.(strcat('r', num2str(rat))).('CSp'), ...
                                    data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_correct =  zeros(max(size(data)), 1);
                    
    Csp_correct(position_data) = data(position_data, subtrial);
   
                                
    %%%                
    
    
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 1, ...
                                     data(:, Tone)        == conditions_reversal.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csp_correct_later_trials(position_data) = data(position_data, subtrial);
             
                    
                                 
    %%% Tone with no reward, but   
    
    
    
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_reversal.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_prob_correct =  zeros(max(size(data)), 1);
                    
    Csp_prob_correct(position_data) = data(position_data, subtrial);
    
                    
    
    %%%%           
    
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_reversal.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_prob_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csp_prob_correct_later_trials(position_data) = data(position_data, subtrial);
                                    
    
    
    %%% CS-
    
    
     
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, SwapSide)    == 1, ...
                                     data(:, Tone)        == conditions_reversal.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_correct =  zeros(max(size(data)), 1);
                    
    Csm_correct(position_data) = data(position_data, subtrial);
   
    
                                 
    %%%%                             
           
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                            data(:, SwapSide)    == 1, ...
                                            data(:, Tone)        == conditions_reversal.(strcat('r', num2str(rat))).('CSm'), ...
                                            data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csm_correct_later_trials(position_data) = data(position_data, subtrial);
   
    
                       
    %%%                                    
   
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, SwapSide)    == 1, ...
                                     data(:, Tone)        ~= conditions_reversal.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_prob_correct =  zeros(max(size(data)), 1);
                    
    Csm_prob_correct(position_data) = data(position_data, subtrial);
   
                                
        
    %%%                           
        
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_reversal.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_reversal.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_prob_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csm_prob_correct_later_trials(position_data) = data(position_data, subtrial);  
   
                                 
                                 
elseif and(reversal_round>0, mod(reversal_round,2)==0)
    
    
    
    %%% THE CHANGE FROM THIS PART FROM THE LAST ONE IS THE USE OF
    %%% CONDITIONS_DISCRIMINATION OR CONDITIONS_REVERSAL
    
     %%% CS+
     
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, SwapSide)    == 1, ...
                                     data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_correct =  zeros(max(size(data)), 1);
                    
    Csp_correct(position_data) = data(position_data, subtrial);
     
     
    %%%%
    
         
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 1, ...
                                     data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csp_correct_later_trials(position_data) = data(position_data, subtrial);

        
                                 
                                 
    %%%%                             
                                 
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_prob_correct =  zeros(max(size(data)), 1);
                    
    Csp_prob_correct(position_data) = data(position_data, subtrial);
                                 
                                 
    %%%%             
                               
                                     
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==4;
                    
    Csp_prob_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csp_prob_correct_later_trials(position_data) = data(position_data, subtrial);
                                 
                              
    
    
    %%% CS-
    
                                      
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                              data(:, SwapSide)    == 1, ...
                              data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                              data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_correct =  zeros(max(size(data)), 1);
                    
    Csm_correct(position_data) = data(position_data, subtrial);
                                 
                 
    %%%%
    
    
                                          
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                data(:, SwapSide)    == 1, ...
                                data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                                data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csm_correct_later_trials(position_data) = data(position_data, subtrial);
       
                        
    %%%%                      
    
        
                                          
    position_data = sum(horzcat(data(:, first_trial) == 1, ...
                                   data(:, SwapSide)    == 0, ...
                                   data(:, Tone)        ~= conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                                   data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_prob_correct =  zeros(max(size(data)), 1);
                    
    Csm_prob_correct(position_data) = data(position_data, subtrial);
       
    
    %%%
     
    
                                              
    position_data = sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, SwapSide)    == 0, ...
                                     data(:, Tone)        ~= conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==4;
                    
    Csm_prob_correct_later_trials =  zeros(max(size(data)), 1);
                    
    Csm_prob_correct_later_trials(position_data) = data(position_data, subtrial);
       

end


Results = [Csp_correct, Csp_correct_later_trials, Csp_prob_correct,  Csp_prob_correct_later_trials, Csm_correct, Csm_correct_later_trials, Csm_prob_correct,  Csm_prob_correct_later_trials];

end
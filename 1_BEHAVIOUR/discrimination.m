function [Results] = discrimination(rat)
 
%{
    files = sort({dir(strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/*.csv')).name});
        
    discrimination_results = 0;
       
    for day_number = 1:length(files)
        
        %%% LOADING THE FILE
        
        string(files(day_number));
        strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/', string(files(day_number)),'.csv');
        data = importdata(strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/', string(files(day_number))));
        
        
        %%%% FILTERING THE NaNs in the last lines
        
        last_row = 0;
        
        while sum(isnan(data(end + last_row, 5:16))) ~= 0
            last_row = last_row -1;
        end
    
        data = data(1:end + last_row, :);
        
        size(data);
        
        %%%%
        
        %discrimination_results
        
        %%% SAVE THE MATRIX RESULTS IN THE SAME PLACE 
        if day_number == 1
            discrimination_results = data;
        else
            discrimination_results = [discrimination_results; data];
        end

        
    end
    
%}

load('rat_information.mat');


files = sort({dir(strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/*.csv')).name});

discrimination_results = 0;
trials   = 0;
total    = 0;
per_file = 0;


for day_number = 1:length(files)
    
    %%% LOADING THE FILE
    
    %string(files(day_number));
    %strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/', string(files(day_number)),'.csv');
    data = importdata(strcat(num2str(rat), '/discrimination/', num2str(rat), ' post surgery/', string(files(day_number))));
    
    
    %%%% FILTERING THE NaNs in the last lines
    
    last_row = 0;
    
    while sum(isnan(data(end + last_row, 5:16))) ~= 0
        last_row = last_row -1;
    end
    
    data = data(1:end + last_row, :);
    
    
    %%%%
    
    trials = trials + length(unique(data(:,1)));
    
    %disp('=====')
    
    total = total + sum([data(end, 5), data(end, 6), data(end, 9), data(end, 10)]);
    
    % total  += sum([data_day_np[-1, 4], data_day_np[-1, 5], data_day_np[-1, 8], data_day_np[-1, 9]])
    
    %%% SAVE THE MATRIX RESULTS IN THE SAME PLACE 
    if day_number == 1
        discrimination_results = data;
    else
        discrimination_results = [discrimination_results; data];
    end
    

end


data = discrimination_results;


%%%%% DATA PROCESSING

first_trial = 2;   % Position in the files of where the field for the number of trial is
Tone        = 3;   % Position too
PokeSide    = 4;   % Same



    
    %%% CS+
    
    Csp_correct =       sum(horzcat(data(:, first_trial) == 1, ...
                                    data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                    data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==3;
                          
    Csp_correct_later_trials =      sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSp'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('reward')), 2)==3;
                           
                                 
                                 
    %%% CS-
    
    Csm_correct =        sum(horzcat(data(:, first_trial) == 1, ...
                                     data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==3;
                          
    Csm_correct_later_trials =      sum(horzcat(data(:, first_trial) ~= 1, ...
                                     data(:, Tone)        == conditions_discrimination.(strcat('r', num2str(rat))).('CSm'), ...
                                     data(:, PokeSide)    == conditions_discrimination.(strcat('r', num2str(rat))).('other_side')), 2)==3;
                            


Results = [Csp_correct, Csp_correct_later_trials, Csm_correct, Csm_correct_later_trials];
    
    
    
end
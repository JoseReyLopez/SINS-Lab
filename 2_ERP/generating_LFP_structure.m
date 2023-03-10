function generating_LFP_structure(RAT)

addpath(strcat('../Discrimination_', num2str(RAT)))



load('EEGlab_empty.mat');
files = dir(strcat('../Discrimination_', num2str(RAT), '/*202*.mat'));


epochs = [];
n_trials = [];





tic
disp('Starting to generate the structure')


%%% Here I record how many trials each 

for i = 1:length(files)
    loaded = load(files(i).name);
    n_trials = [n_trials size(loaded.EEG.data, 3)];
end



data_holder = zeros(64, 7000, sum(n_trials));

cumsum_trials = cumsum(n_trials);

disp('Structuring the data')

for i = 1:length(files)
    fprintf('File %i/%i\n', i, length(files))
    
    loaded = load(files(i).name);
    
    index = ones(64, 1);
    
    % Here I check which channels are not included into a file's data
    
    if isfield(loaded, 'rejected_channels')
        
        index(sort(loaded.rejected_channels))=0;
    
    else
        
        chans = [];
        
        for chan_i = loaded.EEG.chanlocs
            chans = [chans str2num(chan_i.labels)];
        end
        
    
        for chan_i = 1:64
            if size(find(chans == chan_i), 2) == 0
                index(chan_i) = 0;
            end
        end 
    end
    
    data = loaded.EEG.data;
 
    data_holder_session = zeros([64 size(data, [2 3])]);
    data_holder_session(index==1, :, :) = data(:, :, :);
    
    
    
    if i==1
        data_holder(:, :, 1:cumsum_trials(1)) = data_holder_session(:,:,:);
    else
        data_holder(:, :, cumsum_trials(i-1)+1:cumsum_trials(i)) = data_holder_session(:,:,:);
    end
    
    
    epochs = [epochs loaded.EEG.epoch];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%

%%% Now we extract which event corresponds to which epoch and the times for the events of type 32 and 40s

disp('Event extraction')

codes = [40, 41, 42, 43, 44, 45, 46, 47];

event_list = [];


bad_trials = []

for i = 1:length(epochs)
    disp(i)
   
    latency_zero_position = find(cell2mat(epochs(i).eventlatency) == 0);
    marker1020 = [find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==10), find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==20)];
    marker1020 = marker1020+latency_zero_position-1;
    
    
    if length(marker1020)>1
        trial_code = intersect(codes, cell2mat(epochs(i).eventtype(marker1020(1):marker1020(2))));
        disp(trial_code)
    else    
        trial_code = intersect(codes, cell2mat(epochs(i).eventtype(marker1020(1):end)));
    end

    
    if length(trial_code) == 1
        event_list = [event_list trial_code];
    elseif length(trial_code) > 1
        fprintf('Too many trial codes, review: %i\n', i)
        disp(length(marker1020))
        disp(epochs(i).eventlatency)
        disp(epochs(i).eventtype)
        disp(marker1020)
        fprintf('\n\n\n\n')
        %break
        bad_trials = [bad_trials i]
    else
        event_list = [event_list -1];
    end
        
end    


%%

event_matrix = zeros(9, length(event_list));


event_matrix(1, :) = event_list == 40;
event_matrix(2, :) = event_list == 41;
event_matrix(3, :) = event_list == 42;
event_matrix(4, :) = event_list == 43;
event_matrix(5, :) = event_list == 44;
event_matrix(6, :) = event_list == 45;
event_matrix(7, :) = event_list == 46;
event_matrix(8, :) = event_list == 47;
event_matrix(9, :) = event_list == -1; % Time out





%%% Generator time marker 32

disp('Time marker event 32 (Reaction Time)')

count_no_movement = 0;
time_event_32 = [];

for i = 1:length(epochs)  
    
    
    
    %disp(i)
    %disp(latency_zero_position)
    %disp(length(epochs(i).eventlatency))
    %disp(epochs(i))
    %disp('---')  
    
    latency_zero_position = find(cell2mat(epochs(i).eventlatency) == 0);
    marker1020 = [find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==10), find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==20)];
    marker1020 = marker1020+latency_zero_position-1;
    
    if length(marker1020)>1
        trial_code = intersect([32], cell2mat(epochs(i).eventtype(marker1020(1)+1:marker1020(2))));
        position_32 = find(cell2mat(epochs(i).eventtype(marker1020(1)+1:marker1020(2))) == 32);
    else    
        trial_code = intersect([32], cell2mat(epochs(i).eventtype(marker1020(1)+1:end)));
        position_32 = find(cell2mat(epochs(i).eventtype(marker1020(1)+1:end)) == 32);
    end
   
    % It might be possible that the rat does not that the nose of the
    % central hole and that will make a time out event, 33, but not all
    % time outs will be bc of it, so here we see that the epochs where this
    % happens always happen on time out event
    
    if length(position_32)==0
        count_no_movement = count_no_movement + 1;
        time_event_32 = [time_event_32 -1];
    else
        time_event_32 = [time_event_32 cell2mat(epochs(i).eventlatency(marker1020(1)+position_32))];
    end
    
end  

count_no_movement
    
% This should be true to check for the condition of no movement in all the
% seconds
disp('Equal')
sum(event_matrix(9, time_event_32 == -1)) == count_no_movement


matrix_names = {
'correctFirstCSp_code     = 1  40;'
'correctCorrCSp_code      = 2  41;'
'correctFirstCSm_code     = 3  42;'
'correctCorrCSm_code      = 4  43;'
'incorrectFirstCSp_code   = 5  44;'
'incorrectCorrCSp_code    = 6  45;'
'incorrectFirstCSm_code   = 7  46;'
'incorrectCorrCSm_code    = 8  47;'
'Time out'};


%%% Generator time marker 40s


disp('Time marker event 40s (Movement Time) or -1 (Time out)')

time_event_40s = [];

for i = 1:length(epochs)
    
    latency_zero_position = find(cell2mat(epochs(i).eventlatency) == 0);
    marker1020 = [find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==10), find(cell2mat(epochs(i).eventtype(latency_zero_position:end))==20)];
    marker1020 = marker1020+latency_zero_position-1;
    
    
    if length(marker1020)>1
        trial_code = intersect(codes, cell2mat(epochs(i).eventtype(marker1020(1):marker1020(2))));
        position_40s = find(cell2mat(epochs(i).eventtype(marker1020(1):marker1020(2))) == trial_code);
        
        if length(trial_code)==0
            time_event_40s = [time_event_40s -1];
        elseif length(trial_code) == 1
            time_event_40s = [time_event_40s cell2mat(epochs(i).eventlatency(marker1020(1)+position_40s))];
        end
        
        
    % If there's only one, find the 40s code in that segment
    else    
        trial_code = intersect(codes, cell2mat(epochs(i).eventtype(marker1020(1):end)));
        if length(trial_code)==0
            time_event_40s = [time_event_40s -1];
        elseif length(trial_code) == 1
            position_40s = find(cell2mat(epochs(i).eventtype(marker1020(1)+1:end)) == trial_code);
            time_event_40s = [time_event_40s cell2mat(epochs(i).eventlatency(marker1020(1)+position_40s(1)))];
        else
            fprintf('More than 1 40s code, review, # epoch: %i ;  Trial codes: %i', i, trial_code)
        end
        
   end
end


%%%%

% Now making the eeglab structure with the data

disp('Making the structure')

EEGlab_empty.subject   = num2str(RAT);
EEGlab_empty.condition = 'Discrimination ; all';

EEGlab_empty.data  = data_holder;
EEGlab_empty.epoch = epochs;

EEGlab.trials = sum(n_trials);

EEGlab_empty.ReactionTimes = time_event_32;
EEGlab_empty.MovementTimes = time_event_40s;

EEGlab_empty.EventMatrix   = event_matrix;
EEGlab_empty.MatrixNames   = matrix_names;




EEGlab = EEGlab_empty;


disp('Saving the File...')
save(strcat('../Discrimination_', num2str(RAT), '/LFP_', num2str(RAT), '.mat'), 'EEGlab', '-v7.3');
disp('Saving Done')
toc
end
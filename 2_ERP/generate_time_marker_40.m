function [time_marker_40] = generate_time_marker_40(RAT)


    verbose = 0;
    
    %%% TIME MARKER FOR THE 40S EVENT

    time_marker = 0;

    %if exist('RAT')~=1
    %    disp('RAT number not a variable in the workspace')
    %    return
    %end

    folder = '../Discrimination_';
    folder = strcat(folder, num2str(RAT), '/')


    codes = [40 41 42 43 44 45 46 47];

    for data_file = dir(strcat(folder, '*notch*.mat'))'

        file = load(strcat(folder, data_file.name));
        
        if verbose
            disp(data_file.name)
            disp(length(file.EEG.epoch))
            disp('%%%%%%%%%%%%%')
        end

        for i = 1:length(file.EEG.epoch)
            %disp(' ')
            %disp('--------')
            %disp(i)

            if isempty(intersect(codes, cell2mat(file.EEG.epoch(i).eventtype)))
                time_marker = [time_marker -1];
                continue
            end

            %%% What are the eventtypes
            eventtypes = cell2mat(file.EEG.epoch(i).eventtype);
            %disp(eventtypes)

            %%% Where we have 10s or 20s
            events_10_20 = sum(cat(1, eventtypes== 10, eventtypes== 20), 1);
            % make 2 vectors where events 10 or 20 are marked as 1 and summed
            % [0 1 0 0]
            % [0 0 0 0]
            %disp(events_10_20)

            %%% Where are those events
            first_event = find(events_10_20);
            %disp(first_event)

            %%% Events after cutting by the first 10 or 20
            eventtypes_cut = eventtypes(first_event(1):end);

            if isempty(intersect(codes, eventtypes_cut))
                time_marker = [time_marker -1];
                continue
            end

            %disp(eventtypes_cut)

            %%% Getting the first 40s event
            epoch_code = intersect(codes, eventtypes_cut);

            %disp(first_event)
            %disp(epoch_code)
            %%% Get the time of the first 
            %disp(')()()(')
            %%% Position of the 1st event in the 40s after the cut, making
            %%% sure, that its position is after the first 10/20 event

            event_position_40s = find(eventtypes==epoch_code(1));

            first_event_position_40s = event_position_40s(event_position_40s > first_event(1));
            first_event_position_40s(1);
            %disp(cell2mat(file.EEG.epoch(i).eventlatency(find(eventtypes==epoch_code(1)))))



            time_marker = [time_marker cell2mat(file.EEG.epoch(i).eventlatency(first_event_position_40s(1)))];
            %disp(length(time_marker))

        end
        end

    time_marker = time_marker(2:end);
    time_marker_40 = time_marker;

    save(strcat('time_marker_40_',num2str(RAT),'.mat'), 'time_marker_40')

end
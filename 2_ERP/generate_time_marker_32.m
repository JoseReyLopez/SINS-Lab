function [time_marker_32] = generate_time_marker_32(RAT)

    verbose = 0;
    
    time_marker_32 = 0;

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
            %disp('=')
            %disp(i)
            if isempty(intersect(codes, cell2mat(file.EEG.epoch(i).eventtype)))
                %disp('Time out')
                time_marker_32 = [time_marker_32 -1];
                continue
            else

                event_type = cell2mat(file.EEG.epoch(i).eventtype);
                event_latency = cell2mat(file.EEG.epoch(i).eventlatency);
                event_cut = find(event_latency==0);

                %disp(event_type)
                %disp(event_latency)
                %disp(find(event_latency==0))

                cut_before = event_type(1:event_cut);
                event_31 = find(cut_before==31);
                event_31 = event_31(end);


                cut_after  = event_type(event_cut:end);
                event_32 = find(cut_after == 32);
                event_32 = event_32(1);


                if isempty(intersect(codes, cut_after))
                    %disp('Time out')
                    time_marker_32 = [time_marker_32 -1];
                    continue
                end

                events_40 = intersect(codes, cut_after);
                event_40  = find(events_40(1) == cut_after);


                displacement = length(cut_before) - 1;

                if event_type(event_32 + displacement)~=32
                    disp('32 MAL')
                end

                if isempty(intersect(codes, event_type(event_40 + displacement)))
                    disp('40 MAL')
                end


                time_marker_32 = [time_marker_32 event_latency(event_32 + displacement)];

            end 

        end
        end

    time_marker_32 = time_marker_32(2:end);

    save(strcat('time_marker_32_', num2str(RAT) ,'.mat'), 'time_marker_32')

end
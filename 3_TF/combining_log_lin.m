function [image_data_struct] = combining_log_lin(EEG_log, EEG_lin)
    
    % size image data [142, 7000]
    
    if size(EEG_log.TF_data, 1) ~= size(EEG_lin.TF_data, 1)
        disp('The number of channels is not the same in both structures')
        return
    end
    
    if not(all(EEG_log.times == EEG_lin.times))
        disp('The timevectors are not the same')
        return
    end
    
    
    
    frex_log = EEG_log.frex;
    frex_lin = EEG_lin.frex;
    
    n_cycles_log = EEG_log.n_cycles;
    n_cycles_lin = EEG_lin.n_cycles;
    
    
    [~, i_log] = min(abs(frex_log-30));
    [~, i_lin] = min(abs(frex_lin-30));
    
    
    frex_composed     = [frex_log(1:i_log), frex_lin(i_lin:end)];
    n_cycles_composed = [n_cycles_log(1:i_log), n_cycles_lin(i_lin:end)];
    
    
%    positions = [[1:13:67], [67+15:15:142]];
%    values = ceil(frex_composed(positions));  
    
    n_channels   = size(EEG_log.TF_data, 1);
    n_frex       = length(frex_composed);
    n_timepoints = size(EEG_log.TF_data, 3);
    
    image_data = zeros(n_channels, n_frex, n_timepoints);
    
    for channel = 1:n_channels
        image_data(channel, :, :) = [squeeze(EEG_log.TF_data(channel, 1:i_log, :)); squeeze(EEG_lin.TF_data(channel, i_lin:end, :))];       
    end
    
    image_data_struct.frex     = frex_composed;
    image_data_struct.times    = EEG_log.times;
    image_data_struct.TF_data  = image_data;
    image_data_struct.n_cycles = n_cycles_composed;
    image_data_struct.limit_log_lin_index = i_log;
    
    %
    %   positions = [[1:13:67], [67+15:15:142]];
    %   values = ceil(frex_composed(positions));
    %
    %
     
end
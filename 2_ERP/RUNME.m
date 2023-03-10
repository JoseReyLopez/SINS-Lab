RAT = 397550


if ~exist(strcat('../Discrimination_', num2str(RAT)), 'dir')
    mkdir ../Discrimination_397550
    disp('Data must be downloaded using the "download_data.sh" file')
    return;
end

if ~length(dir(strcat('../Discrimination_', num2str(RAT), '/*notch*.mat')))
    disp('Data must be downloaded using the "download_data.sh" file')
    return
end
    
if ~isfile(strcat('../Discrimination_', num2str(RAT), '/LFP_', num2str(RAT) ,'.mat'))
    generating_LFP_structure(RAT)
end


generate_time_marker_32(RAT)
generate_time_marker_40(RAT)

create_sorted_channel(RAT)

system('python3 ERP_plots.py') % <-- might need to be run by hand, matlab is very
% unstable with this kind of stuff
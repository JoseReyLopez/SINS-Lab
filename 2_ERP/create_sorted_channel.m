function create_sorted_channel(RAT)

    load(strcat('time_marker_32_', int2str(RAT), '.mat'))
    load(strcat('time_marker_40_', int2str(RAT), '.mat'))

    [V32, I32] = sort(time_marker_32);
    [V40, I40] = sort(time_marker_40);

    load(strcat('../Discrimination_', int2str(RAT), '/LFP_', int2str(RAT), '.mat'))
    EEG_data = EEGlab.data;
    size_eegdata = size(EEG_data)
    
    %{
    figure
    clf
    hold on
    image(squeeze(EEG_data(43, :, I32))')
    plot([2000 2000], [0 size_eegdata(3)], 'r')
    plot(2000+V32, 1:size_eegdata(3))
    plot(2000+ time_marker_40(I32), 1:size_eegdata(3))
    %}
    
    tosave = squeeze(EEG_data(43, :, I32));
    save('channel_43_sorted_32.mat', 'tosave')
    
    %{
    figure
    clf
    size(EEG_data);
    hold on
    image(squeeze(EEG_data(43, :, I40))')
    plot([2000 2000], [0 size_eegdata(3)], 'r')
    plot(2000+V40, 1:size_eegdata(3))
    plot(2000+ time_marker_32(I40), 1:size_eegdata(3))
    %}
    
    tosave = squeeze(EEG_data(43, :, I40));
    save('channel_43_sorted_40.mat', 'tosave')


end
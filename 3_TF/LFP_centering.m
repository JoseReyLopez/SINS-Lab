function LFP_centering(RAT)

    %LFP_trimming
    %   
    %   This function loads a LFP file with the stimulus centered
    %   and creates two different files where the LFP data is
    %   centered to Reaction Time and Movement Time, all other 
    %   parameters are updated as well.
    %
    %   By default the loaded file will be the trimmed ones
    %   where extreme times for either MT or RT are removed 
    %
    %   * RAT: Number of the RAT, the file loaded will be LFP_*RAT*.mat'
    %   

    
    name = strcat('LFP_', num2str(RAT), '_trimmed.mat');
    disp('loading LFP data...')
    load(strcat('../Discrimination_', num2str(RAT),'/', name))
    EEGlab_save = EEGlab;
    
    % Centered Reaction Time
    disp('Reaction Time')

    EEGlabR = EEGlab;

    [vR, sR] = sort(EEGlab.ReactionTimes);

    minR = min(EEGlab.ReactionTimes);
    maxR = max(EEGlab.ReactionTimes);

    ReactionCentered = zeros(EEGlab.nbchan, EEGlab.pnts + maxR - minR, EEGlab.trials);


    times = [1:1:7000+maxR-minR];
    %times = times-2000-maxR+minR;

    starting_point = 2000 + maxR;
    times = times - starting_point;

    starting_pointR = zeros(1, EEGlab.trials);

    for i = 1:EEGlab.trials

        ReactionCentered(:, :, i) = [zeros(64, maxR - EEGlab.ReactionTimes(sR(i))), EEGlab.data(:, : , sR(i)), zeros(64, abs(minR - EEGlab.ReactionTimes(sR(i))))];
        starting_pointR(i) = maxR - EEGlab.ReactionTimes(sR(i));
    end

    EEGlabR = EEGlab;
    EEGlabR.data = ReactionCentered;
    EEGlabR.times = times;
    EEGlabR.pnts = max(size(EEGlabR.data));
    EEGlabR.xmin = min(EEGlabR.times);
    EEGlabR.xmax = max(EEGlabR.times);
    EEGlabR.starting_points = starting_pointR;
    EEGlabR.zero = find(EEGlabR.times == 0);

    EEGlab = EEGlabR;

    disp('Saving..')
    name_split = split(name, '.');
    save(strcat('../Discrimination_', num2str(RAT),'/', string(name_split(1)), '_CRT.mat') , 'EEGlab', '-v7.3')
    disp('Saved')


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    disp(' ')
    
    EEGlab = EEGlab_save;



    % Centered Movement Time
    disp('Movement Time')

    EEGlabM = EEGlab;

    [vM, sM] = sort(EEGlab.MovementTimes);

    minM = min(EEGlab.MovementTimes);
    maxM = max(EEGlab.MovementTimes);

    MovementCentered = zeros(EEGlab.nbchan, EEGlab.pnts + maxM - minM, EEGlab.trials);


    times = [1:1:7000+maxM-minM];

    starting_point = 2000 + maxM;
    times = times - starting_point;


    starting_pointM = zeros(1, EEGlab.trials);
    
    for i = 1:EEGlab.trials

        MovementCentered(:, :, i) = [zeros(64, maxM - EEGlab.MovementTimes(sM(i))), EEGlab.data(:, : , sM(i)), zeros(64, abs(minM - EEGlab.MovementTimes(sM(i))))];
        starting_pointM(i) = maxM - EEGlab.MovementTimes(sM(i));
    end



    EEGlabM.data = MovementCentered;
    EEGlabM.times = times;
    EEGlabM.pnts = max(size(EEGlabM.data));
    EEGlabM.xmin = min(EEGlabM.times);
    EEGlabM.xmax = max(EEGlabM.times);
    EEGlabM.starting_points = starting_pointM;
    EEGlabM.zero = find(EEGlabM.times == 0);

    EEGlab = EEGlabM;

    disp('Saving..')
    name_split = split(name, '.');
    save(strcat('../Discrimination_', num2str(RAT),'/', string(name_split(1)), '_CMT.mat'), 'EEGlab', '-v7.3')
    disp('Saved')
    disp('Done')
end
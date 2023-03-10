function LFP_trimming(RAT, varargin)

    %LFP_trimming
    %   
    %   This function receives 4 parameters, only one required, RAT number
    %   And prunes the trials whose RT or MT are too low, the rat could
    %   have not processed the information, or they are too deviated from 
    %   the median
    %
    %   * RAT: Number of the RAT, the file loaded will be LFP_*RAT*.mat'
    %   * RT_min: (200 (ms) default) min time for Reaction time, in ms
    %   * std_RT: (2 (stds) default) trials that are this
    %   stds away from the median RT will be removed
    %   * std_RT: (2 (stds) default) trials that are this
    %   stds away from the median MT will be removed
    %

    tic

    %RAT = 402617

    name = strcat('../Discrimination_', num2str(RAT), '/' ,'LFP_',num2str(RAT),'.mat');

    load(name);

    
    % Removing trials with too extreme times
    
    default_RT_min  = 200;  % in ms
    default_std_RT  = 2;
    default_std_MT  = 2;
     
    p = inputParser;

    addRequired(p,  'RAT');
    addParameter(p, 'RT_min', default_RT_min);
    addParameter(p, 'std_RT', default_std_RT);
    addParameter(p, 'std_MT', default_std_MT);
    

    parse(p, EEGlab, varargin{:});
    
    
    RT_min = p.Results.RT_min;
    std_RT = p.Results.std_RT;
    std_MT = p.Results.std_MT;

    fprintf('Parameters: \n RT_min:  %i\n std_RT:  %i\n std_MT:  %i\n', RT_min, std_RT, std_MT);

    tm32 = EEGlab.ReactionTimes;
    tm32_save = tm32;

    tm32 = tm32(tm32~=-1);
    tm32_median = median(tm32);
    tm32_std  = std(tm32);
    upper_bound_RT = tm32_median + std_RT*tm32_std;

    tm32 = tm32_save;

    filtering_RT = and(tm32>RT_min, tm32<upper_bound_RT);


    %%%%%%%

    tm40 = EEGlab.MovementTimes;
    tm40_save = tm40;

    tm40 = tm40(tm40~=-1);
    tm40_median = median(tm40);
    tm40_std  = std(tm40);

    upper_bound_MT = tm40_median + std_MT * tm40_std;


    tm40 = tm40_save;

    %filtering_MT = tm40<upper_bound_MT;
    filtering_MT = and(tm40>RT_min, tm40<upper_bound_MT);

    %%%%


    filtering_RT_MT = and(filtering_RT, filtering_MT);
    fprintf('\n\nUseful trials: %i/%i\n\n', sum(filtering_RT_MT), length(filtering_RT_MT))

    EEGlab.data           =   EEGlab.data(:,:,filtering_RT_MT);
    EEGlab.epoch          =   EEGlab.epoch(filtering_RT_MT);
    EEGlab.trials         =   sum(filtering_RT_MT)
    EEGlab.ReactionTimes  =   EEGlab.ReactionTimes(filtering_RT_MT);
    EEGlab.MovementTimes  =   EEGlab.MovementTimes(filtering_RT_MT);
    EEGlab.EventMatrix    =   EEGlab.EventMatrix(:,filtering_RT_MT);
    EEGlab.filtering      =   filtering_RT_MT;

    string_splitted = split(name, '.');
    
    string_splitted = split(string_splitted(end-1), '/')
    
    disp('Saving...')
    save(strcat('../Discrimination_', num2str(RAT), '/', string(string_splitted(end)), '_trimmed.mat'), 'EEGlab', '-v7.3')
    toc
end
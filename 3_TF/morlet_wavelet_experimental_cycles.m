function [struct_TF_data, baseline_data] = morlet_wavelet_experimental_cycles(EEGlab, varargin)


    %morlet_wavelet_auto_arguments
    %
    %   * EEGlab : struct with the LFP data
    %   * n_cycles_mode: 1, 2, 3 ['Orig fit', 'Cap @ 80', 'Fit 30c 120Hz']
    %   * RAT: 397550
    %   * frequency: initial, # frequencies, final [2 100 120]    
    %   * baseline: 1 (True) deactivate for Reaction time centered LFP data
    %   * baseline_range: [1200 1500]
    %   * verbose: 2
    %   * condition: 'all' options ('Csp_correct', 'Csm_correct', 'Csp_incorrect', 'Csm_incorrect', 'all')
    %   * save: 0 (1 to save)
    %   * save_name: 'tf_auto_LFP_data_file_RAT_####.mat'
    %   * test: to test how parameters affect data in 1 channel (false, true) (no str)
    %   * scale: scale of y, options ('log', 'linear')
    % 
    %
    % Example: morlet_wavelet('LFP_397550_all_trimmed.mat', 'baseline', 1, 'condition', 'Csp_correct', 'save', 0, 'test', true, 'scale', 'log')


    total_time = tic;

    %%% PARAMETERS FROM THE FUNCTION DEFAULTS


    
    if ischar(EEGlab) == 1
        number_of_rat = [];
        name = EEGlab;
        name = split(name, '.');
        name = string(name(1));
        
        for i = split(name, '_')
            number_of_rat = [number_of_rat str2double(string(i))];
        end
        
        number_of_rat = number_of_rat(not(isnan(number_of_rat)));
        
        big_number = [];
        for i = number_of_rat
            if i/100000>0
                big_number = [big_number 1];
            else
                big_number = [big_number 0];
            end
        end
        
        
        default_RAT = number_of_rat(big_number);
        
        
    elseif isstruct(EEGlab)
        default_RAT = str2double(EEGlab.subject);
    end
    
    
    default_n_cycles_mode     = 1;
    default_tosave            = 1;
    default_frequency         = [2 100 120];
    default_baseline          = 1;
    default_save_baseline     = 1;
    default_baseline_range    = [1200 1500];
    default_verbose           = 2;
    default_condition         = 'all';
    default_test              = false;
    default_scale             = 'log';


    default_save_name = ...
        strcat('TF_',num2str(default_RAT), '.mat');
        
        
    p = inputParser;

    addRequired(p,  'EEGlab');
    addOptional(p,  'RAT', default_RAT);
    addParameter(p, 'n_cycles_mode', default_n_cycles_mode);
    addParameter(p, 'save', default_tosave);
    addParameter(p, 'save_name', default_save_name);
    addParameter(p, 'frequency', default_frequency);
    addParameter(p, 'baseline', default_baseline);
    addParameter(p, 'save_baseline', default_baseline);
    addParameter(p, 'baseline_range', default_baseline_range);
    addParameter(p, 'verbose', default_verbose);
    addParameter(p, 'condition', default_condition);
    addParameter(p, 'test', default_test);
    addParameter(p, 'scale', default_scale);
    
    parse(p, EEGlab, varargin{:});

    tosave            = p.Results.save;
    save_name         = p.Results.save_name;
    RAT               = p.Results.RAT;
    n_cycles_mode     = p.Results.n_cycles_mode;
    frequency_arg     = p.Results.frequency;
    baseline          = p.Results.baseline;
    save_baseline     = p.Results.save_baseline;
    baseline_range    = p.Results.baseline_range;
    verbose           = p.Results.verbose;
    condition         = p.Results.condition; 
    test              = p.Results.test;   
    scale             = p.Results.scale;    

    
    if strcmp(save_name, default_save_name)
        dsn = split(default_save_name, '.');
        dsn = string(dsn(1));
        save_name = strcat(dsn, '_', condition, '_', scale ,'.mat')
    end
    
    if ischar(EEGlab) == 1
        load(EEGlab);
        
        
    elseif isstruct(EEGlab)
        % pass
        % I will work directly with the structure 
    end
    
    if test
            EEGlab.data = EEGlab.data(23, :, :)
    end
    
    number_channels = size(EEGlab.data, 1);
    
    Csp_correct      = sum(EEGlab.EventMatrix(1:2,:), 1);
    Csm_correct      = sum(EEGlab.EventMatrix(3:4,:), 1);
    Csp_incorrect    = sum(EEGlab.EventMatrix(5:6,:), 1);
    Csm_incorrect    = sum(EEGlab.EventMatrix(7:8,:), 1);
    all_conditions   = sum(EEGlab.EventMatrix(:,:), 1);
    
    
    if strcmp(condition, 'Csp_correct')
        condition_vector = Csp_correct;
    elseif strcmp(condition, 'Csm_correct')
        condition_vector = Csm_correct;
    elseif strcmp(condition, 'Csp_incorrect')
        condition_vector = Csp_incorrect;
    elseif strcmp(condition, 'Csm_incorrect')
        condition_vector = Csm_incorrect;
    elseif strcmp(condition, 'all')
        condition_vector = all_conditions;
    else
        disp('Condition not accepted, using all conditions')
        condition_vector = all_conditions;
    end
    

    if tosave
        fprintf('\n\nThese results will be saved in file: %s\n\n', save_name)
    else
        disp(' ')
        disp('These results will')
        disp('  ---->  NOT <----')
        disp('be saved')
        disp(' ')
    end

    fprintf('\n# of channels: %i\n\n', size(EEGlab.data, 1))
    fprintf('\n# of timepoints: %i\n\n', size(EEGlab.data, 2))
    fprintf('\n# of trials: %i\n\n', size(EEGlab.data, 3))

    if not(strcmp(condition, 'all'))
        fprintf('\nSizes of each condition: \n')
        fprintf('\nTotal trials: %i\n', length(Csp_correct))
        fprintf('\nCsp_correct: %i/%i', sum(Csp_correct), length(Csp_correct))
        fprintf('\nCsm_correct: %i/%i', sum(Csm_correct), length(Csm_correct))
        fprintf('\nCsp_incorrect: %i/%i', sum(Csp_incorrect), length(Csp_incorrect))
        fprintf('\nCsm_incorrect: %i/%i\n\n', sum(Csm_incorrect), length(Csm_incorrect))
    end



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    srate = 1000;
    if not(isfield(EEGlab, 'times'))
        disp('Time vector not included,') 
        disp('please include it in the EEGlab structure as EEGlab.times')
    end
    
    
    %number_channels = size(lfp_data, 1);
    hz = linspace(0,srate/2,floor(length(EEGlab.times)/2)+1);
    
    % Scale
    if strcmp(scale, 'linear')
        frex = linspace(frequency_arg(1), frequency_arg(3), frequency_arg(2)); % in hz
    elseif strcmp(scale, 'log')
        frex = logspace(log10(frequency_arg(1)), log10(frequency_arg(3)), frequency_arg(2)); % in hz
    end
    
    
    if n_cycles_mode == 1
        fprintf('MODE: %i', n_cycles_mode)
        n_cycles = 5.8176*exp(0.0154*frex);
        
    elseif n_cycles_mode == 2
        fprintf('MODE: %i', n_cycles_mode)
        n_cycles = zeros(length(frex),1);
        n_cycles(frex>80) = 20;
        n_cycles(frex<80) = 5.8176*exp(0.0154*frex(frex<80));

    elseif n_cycles_mode == 3
        fprintf('MODE: %i', n_cycles_mode)
        n_cycles = 5.859 * exp(0.01364*frex)
    end
    
    n_cycles_range = n_cycles;
    s = n_cycles_range./(2*pi*frex); % "number of cycles" parameter for wavelet


    % parameters for convolution
    wavetime = -1:1/EEGlab.srate:1-1/EEGlab.srate;
    nWave    = length(wavetime);
    nData    = length(EEGlab.times)*size(EEGlab.data,3);
    nConv    = nWave + nData - 1;
    halfWav  = floor(nWave/2)+1;


    tf = zeros(number_channels, length(frex),length(EEGlab.times));
    
    baseline_data = zeros(number_channels, length(frex));
    
    %%

    for channel = 1:number_channels
    
        channel_time = tic;


        %%% Recheck putting the 0s back into their positions, 
        %   and without leaving the 0s trials and see how it goes    
        
        if length(size(EEGlab.data))==3
            r_any = any(EEGlab.data(channel, :, :));
        elseif length(size(EEGlab.data))==2
            r_any = any(EEGlab.data(channel, :));
        end
        r_any = squeeze(r_any);

        %disp('Condition vector size: ')
        %size(condition_vector)
        %disp('r_any size: ')
        %size(r_any)

        good_trials_and_condition = and(condition_vector, r_any');

        %disp('Trials taken into account in the end')
        %size(good_trials_and_condition)


        if verbose >=1
            disp(' ')
            disp('----------------------------')
            fprintf('\nChannel: %i/%i \n', channel, number_channels)
            disp('Size: ')
            if length(size(EEGlab.data))==3
                disp(size(EEGlab.data(channel,:,good_trials_and_condition)))
            elseif length(size(EEGlab.data))==2
                disp(size(EEGlab.data(channel,:,:)))
            end
            disp(' ')
            fprintf('# of trials for condition %s:  %i/%i', condition, sum(condition_vector), length(condition_vector))
            disp(' ')
            fprintf('# of good trials for condition %s:  %i/%i', condition, sum(good_trials_and_condition), length(good_trials_and_condition))
            disp(' ')
            disp(' ')
            disp(' ')

            disp('PARAMETERS: ')
            fprintf('\nCondition:    %s\n', condition)
            fprintf('# cycles: %i - %i', n_cycles(1), n_cycles(end));
            disp(' ')
            fprintf('Frequencies: %i - %i  ; # of frequencies: %i \n', frequency_arg(1), frequency_arg(3), frequency_arg(2))

            disp('----------------------------')
        end

        lfp_data_reshape = reshape(EEGlab.data(channel,:,good_trials_and_condition) , 1,[]);
        size(lfp_data_reshape);

        dataX = fft(lfp_data_reshape, nConv);
        size(dataX);
        disp(' ')
        for fi=1:length(frex)
            if or(and(verbose >=2,mod(fi,15)==0), fi==length(frex))
                fprintf('%i/%i      Frequency: %1.1f,  cycles: %1.1f,   Channel time:  %i,   Total time: %i\n',...
                    fi, length(frex), frex(fi), n_cycles_range(fi), (tic-channel_time)*1e-9, (tic-total_time)*1e-9 )
            end

                % create the wavelet
            sinew = exp( 1i*2*pi*frex(fi)*wavetime);
            gaus  = exp( (-wavetime.^2) / (2*s(fi)^2) );
            cmw   = sinew .* gaus;
            cmwX  = fft(cmw,nConv);
            cmwX  = cmwX./max(cmwX); % amplitude-normalize wavelet

            % result of convolution (as = analytic signal)
            as    = ifft( dataX.*cmwX );

            % cut off the 'wings' of convolution
            as = as(halfWav:end-halfWav+1);
            %size(as)
            as = [ as 0];
            % reshape to time-by-trials
            as = reshape(as,length(EEGlab.times), []);




            %%% as = as(:badtrials) = nan
            %%% mean(as, 'omitnan')

            aspow = mean(abs(as).^2, 2);

            % This is for baseline which I will apply within the context of another
            % script
            %basepow = mean(aspow(1000:1300));

            % extract power and average over trials
            tf(channel, fi,:) = aspow;

        end

        fprintf('\n\n\nTime elapsed for channel %i:   %i\n', channel, (tic-channel_time)*1e-9)
        fprintf('\nTotal time elapsed: %i', (tic-total_time)*1e-9)
        fprintf('\n ############## \n\n')


    % This part has to come before making the actual baslining, otherwise,
    % tf is tainted
    if save_baseline
        channel_mean = mean(tf(channel, :, baseline_range(1):baseline_range(2)), 3);
        
        baseline_data(channel, :) = mean(tf(channel, :, baseline_range(1):baseline_range(2)), 3);
    end
    
    if baseline
        channel_mean = mean(tf(channel, :, baseline_range(1):baseline_range(2)), 3);
        
        baseline_data(channel, :) = mean(tf(channel, :, baseline_range(1):baseline_range(2)), 3);

        tf_baseline_data(channel, :, :) = 10*log10(tf(channel, : ,:) ./ channel_mean);
        tf_baseline_data(channel, :, :) = flipud(tf_baseline_data(channel, :, :));
        tf(channel,:,:) = tf_baseline_data(channel, :, :);

    end
    
    end  
    
    disp(' ')

    TF_data = tf;

    struct_TF_data.TF_data  = TF_data;
    struct_TF_data.frex     = frex;
    struct_TF_data.times    = EEGlab.times;
    times = EEGlab.times;
    struct_TF_data.n_cycles = n_cycles;

    if tosave == 1
        disp('Saving TF data')
        save(save_name, 'TF_data', 'frex', 'times', 'n_cycles');
        
        %if not(test)
            %disp('Saving baseline data')
            %split_result = split(save_name, '.')
            %baseline_name = strcat(string(split_result(1)), '_baseline.mat')
            %save(baseline_name, 'baseline_data')
        %end
    end

end
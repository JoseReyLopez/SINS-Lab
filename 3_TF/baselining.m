function baselining(RAT)

%{

% Already done by default for the normal ones, just leaving here this code
'in case'

load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csm_incorrect.mat'))

load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_incorrect.mat'))

size_baseline = size(tf_Csp_correct.TF_data, 3);
n_frex        = size(tf_Csp_correct.TF_data, 2);


tf_csp_correct_baseline           = tf_Csp_correct;
tf_csp_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_csm_correct_baseline           = tf_Csm_correct;
tf_csm_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_csm_incorrect_baseline           = tf_Csm_incorrect;
tf_csm_incorrect_baseline.TF_data = zeros(64, n_frex, size_baseline);


for channel_i = 1:64
    baseline_cspc = repmat(baseline_Csp_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmc = repmat(baseline_Csm_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmi = repmat(baseline_Csm_incorrect(channel_i, :), [size_baseline, 1])';


    %tf_csp_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc);
    %tf_csm_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc);
    %tf_csm_incorrect_baseline.TF_data(channel_i, :, :) = 10*log10(squeeze(tf_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi);
    
    tf_csp_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc;
    tf_csm_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc;
    tf_csm_incorrect_baseline.TF_data(channel_i, :, :) = squeeze(tf_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi;
end

tf_csp_correct_baseline.zero   = 2000;
tf_csm_correct_baseline.zero   = 2000;
tf_csm_incorrect_baseline.zero = 2000;

save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csp_correct_baseline.mat'),   'tf_csp_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csm_correct_baseline.mat'),   'tf_csm_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_csm_incorrect_baseline.mat'),  'tf_csm_incorrect_baseline');

%}

%%%%%%



load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csm_incorrect.mat'))

load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_incorrect.mat'))


size_baseline = size(tf_CRT_Csp_correct.TF_data, 3);
n_frex        = size(tf_CRT_Csp_correct.TF_data, 2);


tf_CRT_csp_correct_baseline           = tf_CRT_Csp_correct;
tf_CRT_csp_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_CRT_csm_correct_baseline           = tf_CRT_Csm_correct;
tf_CRT_csm_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_CRT_csm_incorrect_baseline           = tf_CRT_Csm_incorrect;
tf_CRT_csm_incorrect_baseline.TF_data = zeros(64, n_frex, size_baseline);




for channel_i = 1:64
    baseline_cspc = repmat(baseline_Csp_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmc = repmat(baseline_Csm_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmi = repmat(baseline_Csm_incorrect(channel_i, :), [size_baseline, 1])';


    tf_CRT_csp_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_CRT_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc);
    tf_CRT_csm_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_CRT_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc);
    tf_CRT_csm_incorrect_baseline.TF_data(channel_i, :, :) = 10*log10(squeeze(tf_CRT_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi);
    
    %tf_CRT_csp_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_CRT_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc;
    %tf_CRT_csm_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_CRT_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc;
    %tf_CRT_csm_incorrect_baseline.TF_data(channel_i, :, :) = squeeze(tf_CRT_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi;
end


load(strcat('../Discrimination_', num2str(RAT), '/LFP_', num2str(RAT), '_trimmed_CRT.mat'))
tf_CRT_csp_correct_baseline.zero   = EEGlab.zero;
tf_CRT_csm_correct_baseline.zero   = EEGlab.zero;
tf_CRT_csm_incorrect_baseline.zero = EEGlab.zero;

save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csp_correct_baseline.mat'),   'tf_CRT_csp_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csm_correct_baseline.mat'),   'tf_CRT_csm_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CRT_csm_incorrect_baseline.mat'), 'tf_CRT_csm_incorrect_baseline');


%%%%%%%


load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csm_incorrect.mat'))

load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csp_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_correct.mat'))
load(strcat('../Discrimination_', num2str(RAT), '/', 'baseline_csm_incorrect.mat'))


size_baseline = size(tf_CMT_Csp_correct.TF_data, 3);
n_frex        = size(tf_CMT_Csp_correct.TF_data, 2);


tf_CMT_csp_correct_baseline           = tf_CMT_Csp_correct;
tf_CMT_csp_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_CMT_csm_correct_baseline           = tf_CMT_Csm_correct;
tf_CMT_csm_correct_baseline.TF_data   = zeros(64, n_frex, size_baseline);


tf_CMT_csm_incorrect_baseline         = tf_CMT_Csm_incorrect;
tf_CMT_csm_incorrect_baseline.TF_data = zeros(64, n_frex, size_baseline);


for channel_i = 1:64
    baseline_cspc = repmat(baseline_Csp_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmc = repmat(baseline_Csm_correct(channel_i, :),   [size_baseline, 1])';
    baseline_csmi = repmat(baseline_Csm_incorrect(channel_i, :), [size_baseline, 1])';


    tf_CMT_csp_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_CMT_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc);
    tf_CMT_csm_correct_baseline.TF_data(channel_i, :, :)   = 10*log10(squeeze(tf_CMT_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc);
    tf_CMT_csm_incorrect_baseline.TF_data(channel_i, :, :) = 10*log10(squeeze(tf_CMT_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi);

    %tf_CMT_csp_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_CMT_Csp_correct.TF_data(channel_i, :, :))./baseline_cspc;
    %tf_CMT_csm_correct_baseline.TF_data(channel_i, :, :)   = squeeze(tf_CMT_Csm_correct.TF_data(channel_i, :, :))./baseline_csmc;
    %tf_CMT_csm_incorrect_baseline.TF_data(channel_i, :, :) = squeeze(tf_CMT_Csm_incorrect.TF_data(channel_i, :, :))./baseline_csmi;
end

load(strcat('../Discrimination_', num2str(RAT), '/LFP_', num2str(RAT), '_trimmed_CMT.mat'))
tf_CMT_csp_correct_baseline.zero   = EEGlab.zero;
tf_CMT_csm_correct_baseline.zero   = EEGlab.zero;
tf_CMT_csm_incorrect_baseline.zero = EEGlab.zero;


save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csp_correct_baseline.mat'),   'tf_CMT_csp_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csm_correct_baseline.mat'),   'tf_CMT_csm_correct_baseline');
save(strcat('../Discrimination_', num2str(RAT), '/', 'TF_CMT_csm_incorrect_baseline.mat'), 'tf_CMT_csm_incorrect_baseline');

end

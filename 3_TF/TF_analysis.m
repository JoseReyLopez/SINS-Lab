function TF_analysis(RAT)

load(strcat('../Discrimination_',num2str(RAT),'/LFP_', num2str(RAT) ,'_trimmed.mat'))
EEGlab_test = EEGlab;

% How to do filtered analysis:
%filtered_channels = [5, 16, 18, 27, 39, 45, 57, 62];
%EEGlab_test.data = EEGlab_test.data(filtered_channels, :, :)
%EEGlab_test.nbchans = length(filtered_channels);


[tf_Csp_correct,   baseline_Csp_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csp_correct', 'baseline', 1, 'save_baseline', 1)
save(strcat('../Discrimination_',num2str(RAT),'/TF_csp_correct.mat'),        'tf_Csp_correct')
save(strcat('../Discrimination_',num2str(RAT),'/baseline_csp_correct.mat'),  'baseline_Csp_correct')
clear tf_Csp_correct
clear baseline_Csp_correct


load(strcat('../Discrimination_',num2str(RAT),'/LFP_', num2str(RAT) ,'_trimmed.mat'))
EEGlab_test = EEGlab;
[tf_Csm_correct,   baseline_Csm_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csm_correct', 'baseline', 1, 'save_baseline', 1)
save(strcat('../Discrimination_',num2str(RAT),'/TF_csm_correct.mat'),       'tf_Csm_correct')
save(strcat('../Discrimination_',num2str(RAT),'/baseline_csm_correct.mat'), 'baseline_Csm_correct')
clear tf_Csm_correct
clear baseline_Csm_correct



load(strcat('../Discrimination_',num2str(RAT),'/LFP_', num2str(RAT) ,'_trimmed.mat'))
EEGlab_test = EEGlab;
[tf_Csm_incorrect, baseline_Csm_incorrect] = morlet_wavelet_log_lin(EEGlab_test, 'Csm_incorrect', 'baseline', 1, 'save_baseline', 1)
save(strcat('../Discrimination_',num2str(RAT),'/TF_csm_incorrect.mat'),       'tf_Csm_incorrect')
save(strcat('../Discrimination_',num2str(RAT),'/baseline_csm_incorrect.mat'), 'baseline_Csm_incorrect')
clear tf_Csm_incorrect
clear baseline_Csm_incorrect






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






load(strcat('../Discrimination_',num2str(RAT),'/LFP_', num2str(RAT) ,'_trimmed_CRT.mat'))
EEGlab_test = EEGlab;

%filtered_channels = [5, 16, 18, 27, 39, 45, 57, 62];

%EEGlab_test.data = EEGlab_test.data(filtered_channels, :, :)
%EEGlab_test.nbchans = length(filtered_channels);


[tf_CRT_Csp_correct,   baseline_CRT_Csp_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csp_correct', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CRT_csp_correct.mat'),  'tf_CRT_Csp_correct')
clear tf_CRT_Csp_correct

[tf_CRT_Csm_correct,   baseline_CRT_Csm_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csm_correct', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CRT_csm_correct.mat'),  'tf_CRT_Csm_correct')
clear tf_CRT_Csm_correct

[tf_CRT_Csm_incorrect, baseline_CRT_Csm_incorrect] = morlet_wavelet_log_lin(EEGlab_test, 'Csm_incorrect', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CRT_csm_incorrect.mat'),  'tf_CRT_Csm_incorrect')
clear tf_CRT_Csp_incorrect






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






load(strcat('../Discrimination_',num2str(RAT),'/LFP_', num2str(RAT) ,'_trimmed_CMT.mat'))
EEGlab_test = EEGlab;

%filtered_channels = [5, 16, 18, 27, 39, 45, 57, 62];

%EEGlab_test.data = EEGlab_test.data(filtered_channels, :, :)
%EEGlab_test.nbchans = length(filtered_channels);


[tf_CMT_Csp_correct,   baseline_CMT_Csp_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csp_correct', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CMT_csp_correct.mat'),  'tf_CMT_Csp_correct')
clear tf_CMT_Csp_correct

[tf_CMT_Csm_correct,   baseline_CMT_Csm_correct]   = morlet_wavelet_log_lin(EEGlab_test,   'Csm_correct', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CMT_csm_correct.mat'),  'tf_CMT_Csm_correct')
clear tf_CMT_Csm_correct

[tf_CMT_Csm_incorrect, baseline_CMT_Csm_incorrect] = morlet_wavelet_log_lin(EEGlab_test, 'Csm_incorrect', 'baseline', 0, 'save_baseline', 0)
save(strcat('../Discrimination_',num2str(RAT),'/TF_CMT_csm_incorrect.mat'),  'tf_CMT_Csm_incorrect')
clear tf_CMT_Csm_incorrect

delete TF*.mat
end
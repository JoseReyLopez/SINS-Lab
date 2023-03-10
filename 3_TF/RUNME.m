%RAT = input('Enter the Rat number: ')

RAT = 397550

if ~exist('../Discrimination_397550', 'dir')
    mkdir ../Discrimination_397550
    disp('Data must be downloaded using the "download_data.sh" file')
    return;
end

if ~length(dir(strcat('../Discrimination_', num2str(RAT), '/*notch*.mat')))
    disp('Data must be downloaded using the "download_data.sh" file')'
end
    

generating_LFP_structure(RAT);
LFP_trimming(RAT);
LFP_centering(RAT);
TF_analysis(RAT);
baselining(RAT);

% python scripts might need to be called by hand %
system('python3 Plot_topographical_TF.py')
system('python3 Plot_difference_in_activations.py')
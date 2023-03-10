function [tf_combined, baseline, baseline_linear, baseline_log] = morlet_wavelet_log_lin(EEGlab, condition, varargin)

    default_baseline       = 0;
    default_save_baseline  = 1;
    
    p = inputParser;
    
    addRequired(p,  'EEGlab');
    addRequired(p,  'condition');
    addOptional(p, 'baseline', default_baseline);
    addOptional(p, 'save_baseline', default_save_baseline);
    
    parse(p, EEGlab, varargin{:});
    
    baseline = p.Results.baseline;
    save_baseline = p.Results.save_baseline;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    [tf_log,    baseline_log]    = morlet_wavelet_experimental_cycles(EEGlab, 'condition', condition, 'frequency', [2,  20, 26.0149],  'baseline', baseline, 'save_baseline', save_baseline, 'scale', 'log');
    [tf_linear, baseline_linear] = morlet_wavelet_experimental_cycles(EEGlab, 'condition', condition, 'frequency', [30, 30, 120],      'baseline', baseline, 'save_baseline', save_baseline, 'scale', 'linear');
    
    tf_combined = combining_log_lin(tf_log, tf_linear);
    baseline = [baseline_log, baseline_linear];
    
end
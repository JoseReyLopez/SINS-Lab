

discrimination_head = ["trial", "subtrial", "currentTone", "PokeCode", "correctCSp", "correctCSp_corr", "incorrectCSp", "incorrectCSp_corr", "correctCSm", "correctCSm_corr", "incorrectCSm", "incorrectCSm_corr", "initializationTime", "ReactionTime", "MovementTime", "initialization_failures", "timeOut_CentralNosePoke", "ephys_markers"];


reversal_head       = ["trial", "subtrial", "currentTone", "SwapSideTrial", "PokeCode", "correctCSp", "correctCSp_corr", "incorrectCSp", "incorrectCSp_corr", "correctCSm", "correctCSm_corr", "incorrectCSm", "incorrectCSm_corr", "initializationTime", "ReactionTime", "MovementTime", "initialization_failures", "timeOut_CentralNosePoke", "ephys_markers"];


conditions_discrimination =  struct('r401056', struct('group', 1, 'CSp', 8000, 'CSm', 2000, 'reward', 1, 'other_side', 3), ...
                                    'r401057', struct('group', 1, 'CSp', 8000, 'CSm', 2000, 'reward', 3, 'other_side', 1), ...
                                    'r397550', struct('group', 1, 'CSp', 2000, 'CSm', 8000, 'reward', 1, 'other_side', 3), ...
                                    'r397551', struct('group', 1, 'CSp', 2000, 'CSm', 8000, 'reward', 3, 'other_side', 1), ...
                                    'r402616', struct('group', 2, 'CSp', 2000, 'CSm', 8000, 'reward', 1, 'other_side', 3), ...
                                    'r402617', struct('group', 2, 'CSp', 2000, 'CSm', 8000, 'reward', 3, 'other_side', 1));
                                

                                
conditions_reversal       =  struct('r401056', struct('group', 1, 'CSp', 2000, 'CSm', 8000, 'reward', 1, 'other_side', 3), ...
                                    'r401057', struct('group', 1, 'CSp', 2000, 'CSm', 8000, 'reward', 3, 'other_side', 1), ...
                                    'r397550', struct('group', 1, 'CSp', 8000, 'CSm', 2000, 'reward', 1, 'other_side', 3), ...
                                    'r397551', struct('group', 1, 'CSp', 8000, 'CSm', 2000, 'reward', 3, 'other_side', 1), ...
                                    'r402616', struct('group', 2, 'CSp', 8000, 'CSm', 2000, 'reward', 1, 'other_side', 3), ...
                                    'r402617', struct('group', 2, 'CSp', 8000, 'CSm', 2000, 'reward', 3, 'other_side', 1));
                                
                                
groups = struct('g1', [401056, 401057, 397550, 397551], ...
                'g2', [402616, 402617, 407772, 407773]);
            
            
save('rat_information.mat', 'conditions_discrimination', 'conditions_reversal', 'discrimination_head', 'reversal_head', 'groups')
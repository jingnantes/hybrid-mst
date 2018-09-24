function  test_on_mst(Number_stimuli, Number_observations, Score, std,error_rate)
%% test on mst model
trial = 0;
    pcm = zeros(Number_stimuli, Number_stimuli);
    full_pair_num = Number_stimuli*(Number_stimuli-1)/2;
    
    tic
    while(trial < Number_observations)
        %if sum(sum(pcm))-full_pair_num < full_pair_num % initialization will occupy 1 fpc number
        %[pcm] = Active_Learning_BT(pcm, Score, std, 1, error_rate);
        %else
        [pcm] = Active_Learning_MST(pcm, Score, std, error_rate);
        %end
        
        trial = sum(sum(pcm))-full_pair_num; % due to initialization 
        %round = round + 1;
        
        %MST.BT{round} = Learning_performance_evaluation(pcm, Score,  'logit');
        
        %MST.trial_number{round} = trial;
    end
    toc
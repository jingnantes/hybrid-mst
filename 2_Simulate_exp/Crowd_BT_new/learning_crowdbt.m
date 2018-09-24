function res = learning_crowdbt(ite,Score_tmp,std_tmp,alg_params,L,M,N)

 Score = Score_tmp(ite,:)';
    gt_score = Score;
    std = std_tmp(ite,:)';
    



alpha_init = 10;
beta_init = 1;
eta_init = 1;
mu_init = 1;
sigma_init = 1/9;
kappa  = 10e-4;


params.alpha = ones(L,1)*alpha_init;
params.beta = ones(L,1)*beta_init;
params.eta =  ones(L,1)*eta_init;
params.mu =  rand(L,1)*mu_init;
params.emu = exp(params.mu);
params.sigma =  ones(L,1)*sigma_init; %sigma squared
params.history = zeros(alg_params.L,alg_params.L);


for i=1:M % iterate throgh people
    
    pairs = get_pairs(alg_params.N,params);
   
    
    
    for j=1:size(pairs,1)
        a = pairs(j,1);
        b = pairs(j,2);
        %% update the Xt
        Xt = normrnd(Score,std);
        pref = get_preference(Xt,a,b,alg_params);
        
        if(pref == -1)
            [a,b] = deal (b,a); %swap, so a always > b
        end
        params.history(a,b)=params.history(a,b)+1;
        new_params = get_updated_parameters(a,b,[params.history(a,b),params.history(b,a)],params); % o_a > o_b
        
        
        
        %update
        params.mu(a) = new_params.mu_a;
        params.mu(b) = new_params.mu_b;
        
        params.sigma(a) = new_params.sigma_a;
        params.sigma(b) = new_params.sigma_b;
        
        params.emu(a) = exp(params.mu(a));
        params.emu(b) = exp(params.mu(b));
    end
    
    
    
    b = params.mu;

    res.kendall(i)=corr(b,gt_score,'type','Kendall');
    res.plcc(i)=corr(b,gt_score);
    [res.CC(i), res.MAE(i), res.RMSE(i), res.ROCC(i)]=statistic_analysis(b,gt_score);
end

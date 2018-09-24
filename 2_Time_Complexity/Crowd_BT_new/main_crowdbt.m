 %check get_preference function to set probabilities of wrong answes
path(path,'./Heap')
verbose = false;

alg_params.L = [500];% 16, 20; % obj num

alg_params.N = 1;   % batch amount (every guy answers N questions)
alg_params.M = 1 %alg_params.L * (alg_params.L-1)/2; % iteration limit (how many people do we have)
alg_params.layers = [0.25, 0.7,1.0]; % for what?
run_time =1;
error_rate = 0.1;

L = alg_params.L;
M = alg_params.M;
N =  alg_params.N;

str=strcat('../GTdata/GTscore1000.mat');
load(str); % load reference

for ite = 1:run_time
    Score_tmp = Score;
    Score = Score_tmp(ite,1:L)';
    gt_score = Score;
    std = std(ite,1:L)';
    
tic
%Xt = randperm(alg_params.L);
%[~,ixXt] = sort(Score);

%Q =[];
%%

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
    %% You can use this code to sample random N pairs
    %     pairs = zeros(alg_params.N,1);
    %     for ii=1:alg_params.N
    %         while(true)
    %
    %             pairs(ii,1) = randi(L,1);
    %             pairs(ii,2) = randi(L,1);
    %
    %             if(pairs(ii,2)~=pairs(ii,1))
    %                 break;
    %             end
    %         end
    %     end
    
    
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
    
    if(verbose)
        clf
        imagesc(params.history);
        x = [-1:0.1:1];
        for obj=1:L
            f = normpdf(x,params.mu(obj),params.sigma(obj)^(1/2));
            plot(f);
            
            drawnow
            hold on
        end
    end
    
    b = params.mu;
    %kendall(i)=corr(b,gt_score,'type','Kendall');
    %plcc(i)=corr(b,gt_score);
    %[CC(i), MAE(i), RMSE(i), ROCC(i)]=statistic_analysis(b,gt_score);
    
    
end
toc
    %kendall_result(ite,:)=kendall';
    %plcc_result(ite,:)=plcc';
    %cc_result(ite,:)=CC';
    %rmse_result(ite,:)=RMSE';
    %rocc_result(ite,:)=ROCC';
    
end

function [pcm] = Active_Learning_MST(pre_pcm, Score, data_ref)
%% this function is used to simulate the pair comparison procedure for single learning based on kl divergence
%% input
% given scores and std
% observer may make a mistake during judgment, error_rate
% pre_pcm is the current observed pcm, which could be used to generate the
% prior
% the eig is calculated by Gaussian-hermit of prior and posterior
% local distribution

%% output
% current pcm
% BT and Thurstone rating, status, performance: 
% BT.b = b_bt;
% BT.stats = stats_bt;
% BT.pfit = pfit_bt;
% BT.performance = [CC_bt, Kendall_bt, Spearman_bt];

Number_stimuli = length(Score);
pcm = zeros(Number_stimuli, Number_stimuli);

if sum(sum(pre_pcm))==0
    pre_pcm = Initial_learning(pre_pcm);
end

[b_prior,stats] = paired_comparisons(pre_pcm,'logit');

covb = stats.covb; 
 mu_v = b_prior;
 n=30;
 eig = zeros(Number_stimuli, Number_stimuli);
 
 
 for i = 1:Number_stimuli-1
     for j = i+1:Number_stimuli
        mu(i,j) = mu_v(i)-mu_v(j);
        sigma(i,j) = sqrt(covb(i,i)+covb(j,j)-2.*covb(i,j));
        eig(i,j) = Gaussian_Hermite_BT(mu(i,j), sigma(i,j), n);
        eig(j,i) = eig(i,j);
     end
 end
 
 
 eig_inverse = 1./eig;
 eig_inverse(find(eig_inverse==Inf))= 0;
 [res_pair, ~] = prim(eig_inverse);
 
 num_pair = size(res_pair,1);

for pair_idx = 1: num_pair
    i = res_pair(pair_idx,1);
    j = res_pair(pair_idx,2);

    idx = find(data_ref(:,1)==i & data_ref(:,2)==j);
    idx1 = find(data_ref(:,2)==i & data_ref(:,1)==j);
    all = [idx;idx1];
    randidx = randperm(length(all));
    use_idx = data_ref(all(randidx(1),:),:);
    
    pcm(use_idx(1), use_idx(2)) = pcm(use_idx(1), use_idx(2)) + 1;
    
    
end    
pcm = pcm + pre_pcm;

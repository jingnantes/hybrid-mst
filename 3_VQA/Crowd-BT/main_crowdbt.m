%check get_preference function to set probabilities of wrong answes
clc
clear all
close all

matlabpool open 30


alg_params.L = 16;% 20; % obj num
alg_params.N = 1;   % batch amount (every guy answers N questions)
alg_params.M = 16*15/2*15; % iteration limit (how many people do we have)
alg_params.layers = [0.25, 0.7,1.0]; % for what?
run_time =100;
ref_num = 10;


L = alg_params.L;
M = alg_params.M;
N =  alg_params.N;

path(path,'./results/');

for ref = 1: ref_num
    str=strcat('../VQA_Data/','data',num2str(ref),'.mat');
    load(str);
    use_ref{ref} = data_ref;
end

clear data_ref

parfor ref = 1: ref_num

    
    
    data_ref = use_ref{ref};
    gt_score = get_gt(L, data_ref);


for ite = 1:run_time

   res = learning_crowdbt(alg_params,L,N,M,data_ref, gt_score);

   savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
   parsave(strcat('./results/',savename,'.mat'), res);
   
    
end

end

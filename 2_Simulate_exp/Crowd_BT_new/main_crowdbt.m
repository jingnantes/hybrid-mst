%check get_preference function to set probabilities of wrong answes

matlabpool open 50


alg_params.L = [60];% 20; % obj num
alg_params.N = 1;   % batch amount (every guy answers N questions)
alg_params.M = 60*59/2*15; % iteration limit (how many people do we have)
alg_params.layers = [0.25, 0.7,1.0]; % for what?
run_time =100;
error_rate = 0.1;

L = alg_params.L;
M = alg_params.M;
N =  alg_params.N;

str=strcat('../GTdata/GTscore.mat');
load(str); % load reference
Score_tmp = Score;
std_tmp = std;

parfor ite = 1:run_time

    
   res = learning_crowdbt(ite,Score_tmp,std_tmp,alg_params,L,M,N) 
   
    
   savename = strcat('RepeatNo_',num2str(ite));
 parsave(strcat('./results/',savename,'.mat'), res); 


    
    
end


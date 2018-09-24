%% ARD method



tic
clc;
clear;

matlabpool open 30

N=60; % stimuli Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time =100;
error_rate = 0.1;

res_pair = Rectangular_design(10,6);


str=strcat('../GTdata/GTscore.mat');
load(str); % load reference

parfor ite = 1:run_time
    gt_score=Score(ite,:)';
    gt_std = std(ite,:)';
    
    
    %aaaaaaaaaaaaaaaaaaaaaaa=time
    
    
    
    
    
    
    
    res = ard_process(N,totalnum,error_rate,gt_score,gt_std,res_pair)
    
 savename = strcat('RepeatNo_',num2str(ite));
 parsave(strcat('./results/',savename,'.mat'), res); 
    
    
end





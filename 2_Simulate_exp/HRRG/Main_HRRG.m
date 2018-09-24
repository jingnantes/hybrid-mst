
tic
clc;
clear;

matlabpool open 30


N=60; % stimuli Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time = 100;
error_rate = 0.1;





% load ground truth
str=strcat('../GTdata/GTscore.mat');
load(str);

parfor ite = 1:run_time



    gt_score=Score(ite,:)';
    gt_std = std(ite,:)';
    
    
    ground_truth_score=Score(ite,:)';
    
    res = hrrg_learning(N,totalnum,error_rate,gt_score,gt_std,ground_truth_score)
    
    savename = strcat('RepeatNo_',num2str(ite));
    parsave(strcat('./results/',savename,'.mat'), res); 
    
    
end




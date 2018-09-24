%% this code is used to generate data
%% DO NOT CHANGE THIS CODE.
%% The results are saved in UFR server
clear all
close all
clc

matlabpool open 70

path(path,'./tools');
N=60; % stimuli Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time =100 % 100;
error_rate = 0.1;

str=strcat('../GTdata/GTscore.mat');
load(str); % load gt

parfor ite = 2:run_time    
    gt_score=Score(ite,:)';
    gt_std = std(ite,:)';

    mstres = test_on_mst(N, totalnum, gt_score, gt_std, error_rate);

 savename = strcat('RepeatNo_',num2str(ite));
 parsave(strcat('./results/',savename,'.mat'), mstres);
end

%% this code is used to generate data
%% DO NOT CHANGE THIS CODE.
%% The results are saved in UFR server
clear all
close all
clc



path(path,'./tools');
path(path,'../GTdata/');
N=500; % 16, 20 stimuli Number
initialnum = 0;
totalnum=499% N*(N-1)/2;
run_time =1 % 100;
error_rate = 0.1;

%generate_GTData;
%str=strcat('../GTdata/GTscore100.mat');
%load(str); % load gt

load('GTscore1000.mat')




for ite = 1:run_time    
    gt_score=Score(ite,1:N)';
    gt_std = std(ite,1:N)';

    test_on_mst(N, totalnum, gt_score, gt_std, error_rate);
 
end

%% this code is used to generate data
%% DO NOT CHANGE THIS CODE.
%% The results are saved in UFR server
clear all
close all
clc

matlabpool open 30

path(path,'./tools');
N=16; % stimuli Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time = 100;
ref_num = 15;


for ref = 1: ref_num
    str=strcat('../IQA_Data/','data',num2str(ref),'.mat');
    load(str);
    use_ref{ref} = data_ref;
end

clear data_ref

parfor ref = 1: ref_num
    data_ref = use_ref{ref};
    gt_score = get_gt(N,data_ref);
    
    for ite = 1:run_time

    mstres = test_on_mst(N, totalnum, gt_score,data_ref);

    savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
    parsave(strcat('./results/',savename,'.mat'), mstres);
    end
end

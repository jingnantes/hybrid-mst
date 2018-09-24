clc
clear all
close all

path(path,'./results/');

iteration_num = 100;

for ite = 1: iteration_num
        
        savename = strcat('RepeatNo_',num2str(ite));
        load(strcat('./results/',savename,'.mat'), 'res');

	kendall_result(ite,:)=res.random_kendall';
        plcc_result(ite,:)=res.random_plcc';
        cc_result(ite,:)=res.random_CC';
        rmse_result(ite,:)=res.random_RMSE';
        rocc_result(ite,:)=res.random_ROCC';      
 	
	trial(ite,:) = [1:length(res.random_kendall)]; 


end
    
    save('hrrg_random.mat');

clc
clear all
close all

path(path,'./results/');

iteration_num = 100;

for ite = 1: iteration_num
        
        savename = strcat('RepeatNo_',num2str(ite));
        load(strcat('./results/',savename,'.mat'), 'res');

	kendall_result(ite,:)=res.kendall';
        plcc_result(ite,:)=res.plcc';
        cc_result(ite,:)=res.CC';
        rmse_result(ite,:)=res.RMSE';
        rocc_result(ite,:)=res.ROCC';      
 	
	trial(ite,:) = [1:length(res.kendall)]; 


end
    
    save('crowdbt.mat');

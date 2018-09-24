clc
clear all
close all

path(path,'./results/');

iteration_num = 100;
ref_num = 15;

for ref = 1: ref_num

for ite = 1: iteration_num
        
        savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
        load(strcat('./results/',savename,'.mat'), 'res');

	kendall_result(ite,:)=res.kendall';
        plcc_result(ite,:)=res.plcc';
        cc_result(ite,:)=res.CC';
        rmse_result(ite,:)=res.RMSE';
        rocc_result(ite,:)=res.ROCC';      
 	
	trial(ite,:) = [1:length(res.kendall)]; 


end
    
str_result=strcat('./data/ref',num2str(ref),'.mat');
save(str_result);
end

clc
clear all
close all

path(path,'./results/');

iteration_num = 100;

ref_num = 10;

for ref = 1: ref_num


for ite = 1: iteration_num
        
        savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
        load(strcat('./results/',savename,'.mat'), 'active');

	kendall_result(ite,:)=active.kendall';
        plcc_result(ite,:)=active.plcc';
        cc_result(ite,:)=active.CC';
        rmse_result(ite,:)=active.RMSE';
        rocc_result(ite,:)=active.ROCC'; 

         trial(ite,:) = [1:length(active.kendall)]; 



	%load(strcat('./results/',savename,'.mat'), 'random');

	%kendall_result(ite,:)=random.kendall';
        %plcc_result(ite,:)=random.plcc';
        %cc_result(ite,:)=random.CC';
        %rmse_result(ite,:)=random.RMSE';
        %rocc_result(ite,:)=random.ROCC'; 

         %trial(ite,:) = [1:length(random.kendall)]; 
      


end
    
    str_result=strcat('./data_active/ref',num2str(ref),'.mat');
save(str_result);
end

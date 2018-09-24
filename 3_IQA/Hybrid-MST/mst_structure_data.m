clc
clear all
close all

path(path,'./results/');

iteration_num = 100;
ref_num = 15;

for ref = 1: ref_num

for ite = 1: iteration_num
        
        savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
        load(strcat('./results/',savename,'.mat'), 'mstres');

        for kk = 1:length(mstres.BT)

	kendall_result(ite,kk)=mstres.BT{kk}.kendall;
        plcc_result(ite,kk)=mstres.BT{kk}.plcc';
        cc_result(ite,kk)=mstres.BT{kk}.CC';
        rmse_result(ite,kk)=mstres.BT{kk}.RMSE';
        rocc_result(ite,kk)=mstres.BT{kk}.ROCC';      

 trial(ite,kk) = mstres.trial_number{kk}; 
end
end
 str_result=strcat('./data/ref',num2str(ref),'.mat');
save(str_result);
end

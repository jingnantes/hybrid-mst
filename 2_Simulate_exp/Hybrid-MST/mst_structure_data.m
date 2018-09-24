clc
clear all
close all

path(path,'./results/');

iteration_num = 100;

for ite = 1: iteration_num
        
        savename = strcat('RepeatNo_',num2str(ite));
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
    
    save('hybridmst.mat');

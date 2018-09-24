clc;
clear;

matlabpool open 50



N=16; % Node Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time =100;
lambda = 1;
outlier_ratio=0;
solve_model =1;
% 1:uniform;  2:Bradley-Terry  3:Thurstone-Mosteller   4:Angular transform
eps = 1e-4;
ref_num=15;
ref_vector = [2:4 6:8 10:ref_num];

start_idx = [100,85,53,99,100,93,60,43,100,71,26,37,25,87,62];

for ref = 1: ref_num
    str=strcat('../IQA_Data/','data',num2str(ref),'.mat');
    load(str);
    use_ref{ref} = data_ref;
end

clear data_ref

parfor ref= 1:ref_num %reference index, there are 15 references in PC-IQA dataset
    data_ref = use_ref{ref};
    
    [ground_truth_score, s_bar,edge, w] = get_gt(data_ref,N);
    s_bar = ground_truth_score ;
    
    i = edge(:,1);
    j = edge(:,2);
    ii = (i-1)*N + i;
    jj = (j-1)*N + j;
    ij = (j-1)*N + i;
    
    m = length(edge);
    d = sparse([1:m;1:m]',[i;j],[ones(1,m),-ones(1,m)],m,N);
    
   for ite=start_idx(ref):run_time

            
       [active,random] = hrrg_learning(ground_truth_score,s_bar,N,edge,lambda,totalnum,data_ref,i,j,ii,jj,ij,d);
           
        
        

    savename = strcat('Ref_',num2str(ref),'_RepeatNo_',num2str(ite));
    parsave(strcat('./results/',savename,'.mat'), active,random);
    end
   
    


end

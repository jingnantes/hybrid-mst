
tic
clc;
clear;

N=60; % stimuli Number
initialnum = 0;
totalnum=N*(N-1)/2*15 ;
run_time =100;
error_rate = 0.1;


    str=strcat('../GTdata/GTscore.mat');
    load(str); % load reference

for ite = 1:run_time    
    gt_score=Score(ite,:)';
    gt_std = std(ite,:)';
    
    
        %aaaaaaaaaaaaaaaaaaaaaaa=time
        tic
        
        
        
        num = 0;
        round = 1;
        pcm = zeros(N,N); % initialization
        while num<=totalnum
            
            
            
                for i = 1:N-1
		  for j = i+1:N
                    
                    aa = normrnd(gt_score(i),gt_std(i));
                    bb = normrnd(gt_score(j),gt_std(j));
                    if aa > bb
                        if rand > error_rate
                            pcm(i,j)=pcm(i,j)+1;
                        else
                            pcm(j,i)=pcm(j,i)+1;
                        end
                    elseif aa < bb
                        if rand > error_rate
                            pcm(j,i)=pcm(j,i)+1;
                        else
                            pcm(i,j)=pcm(i,j)+1;
                        end
                    else
                        if rand > 0.5
                            pcm(j,i)=pcm(j,i)+1;
                        else
                            pcm(i,j)=pcm(i,j)+1;
                        end
                   
                    end
                end    
                    
                end
            
                b = paired_comparisons(pcm,'logit');
                
                trial_num(round) = sum(sum(pcm));
            num =  sum(sum(pcm));
            
            
            kendall(round)=corr(b,gt_score,'type','Kendall');
            plcc(round)=corr(b,gt_score);
            [CC(round), MAE(round), RMSE(round), ROCC(round)]=statistic_analysis(b,gt_score);
            round = round + 1;
        end
        
        
        
        kendall_result(ite,:)=kendall';
        plcc_result(ite,:)=plcc';
        cc_result(ite,:)=CC';
        rmse_result(ite,:)=RMSE';
        rocc_result(ite,:)=ROCC';
        
        toc
        
        
end
    
    str_result=strcat('fpc.mat');
    save(str_result);



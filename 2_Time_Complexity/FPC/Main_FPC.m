
tic
clc;
%clear;

N=500; % 16, 20, stimuli Number

initialnum = 0;
totalnum=100%N*(N-1)/2;
run_time =1;
error_rate = 0.1;


    str=strcat('../GTdata/GTscore1000.mat');
    load(str); % load reference

for ite = 1:run_time    
    gt_score=Score(ite,1:N)';
    gt_std = std(ite,1:N)';
    
    
        %aaaaaaaaaaaaaaaaaaaaaaa=time
        
        
        tic
        
        num = 0;
        round = 1;
        pcm = zeros(N,N); % initialization
        while num<totalnum
            
            
            
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
            
                %b = paired_comparisons(pcm,'logit');
                
                %trial_num(round) = sum(sum(pcm));
            num = sum(sum(pcm))
            
            
            
        end
        
        
        
        
        
        toc
        
        
end
    
    



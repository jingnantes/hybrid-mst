
tic
clc;
%clear;

N=500; % stimuli Number
res_pair = Rectangular_design(10,50);
%res_pair = Rectangular_design(4,4); % when N = 16
%res_pair = Rectangular_design(4,5); % when N = 20


initialnum = 0;
totalnum=14500 %N*(N-1)/2;
run_time =1;
error_rate = 0.1;




str=strcat('../GTdata/GTscore1000.mat');
load(str); % load reference

for ite = 1: run_time

    gt_score=Score(ite,1:N)';
    gt_std = std(ite,1:N)';
    
    
    aaaaaaaaaaaaaaaaaaaaaaa=tic
    
    
    
    
    num = 0;
    round = 1;
    pcm = zeros(N,N); % initialization
    while num<totalnum
        
        if sum(sum(pcm))==0
            sort_b_idx = randperm(N);
        else
            b = paired_comparisons(pcm,'logit');
            [~, sort_b_idx] = sort(b);
        end
        
        
        for pair_idx = 1:length(res_pair)
            i_idx = res_pair(pair_idx,1);
            j_idx = res_pair(pair_idx,2);
                    
            i = sort_b_idx (i_idx);
            j = sort_b_idx (j_idx);
            
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
        
        
        
        num = sum(sum(pcm));
        
    end
    
    
    
    
    toc
    
    
end





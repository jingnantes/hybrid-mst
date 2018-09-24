function res = ard_process(N,totalnum,error_rate,gt_score,gt_std,res_pair)

num = 0;
    round = 1;
    pcm = zeros(N,N); % initialization
    while num<=totalnum
        
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
        
        b = paired_comparisons(pcm,'logit');
        
        res.trial_num(round) = sum(sum(pcm));
        num = sum(sum(pcm));
        
        
        res.kendall(round)=corr(b,gt_score,'type','Kendall');
        res.plcc(round)=corr(b,gt_score);
        [res.CC(round), res.MAE(round), res.RMSE(round), res.ROCC(round)]=statistic_analysis(b,gt_score);
        round = round + 1;
    end
    

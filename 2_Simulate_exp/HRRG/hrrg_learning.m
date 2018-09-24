function res = hrrg_learning(N,totalnum,error_rate,gt_score,gt_std,ground_truth_score)
   %% active learning default parameters
lambda = 1;
outlier_ratio=0;
solve_model =1;
eps = 1e-4;

    s_bar=ground_truth_score;
    edge = [];
    for temp1 = 1:N-1
        for temp2 = temp1+1:N
            edge = [edge; temp1,temp2];
        end
    end
    w = zeros(1,length(edge));
    i = edge(:,1);
    j = edge(:,2);
    ii = (i-1)*N + i;
    jj = (j-1)*N + j;
    ij = (j-1)*N + i;
    
    m = length(edge);
    d = sparse([1:m;1:m]',[i;j],[ones(1,m),-ones(1,m)],m,N);
    
    
    edge_index = [];
    Sigma_0_inv=1/lambda*eye(N);
    s_initial = zeros(N,1);
    s_initial = s_initial - mean(s_initial);
    s_random = s_initial;
    Sigma_0_inv_random = Sigma_0_inv;
    
    active_sample=[];
    active_kendall=zeros(totalnum,1);
    random_kendall=zeros(totalnum,1);
    for num=1:totalnum
        p = (s_initial(i) - s_initial(j) + 1)/2;
        d_S0_inv_d = Sigma_0_inv(ii) + Sigma_0_inv(jj) - 2*Sigma_0_inv(ij);
        d_s0 = d*s_initial;
        d_S1_inv_d = d_S0_inv_d - d_S0_inv_d.^2./(1+d_S0_inv_d);
        
        ds_Sigma0_ds = ((1 + d_s0).^2-4*d_s0.*p).*d_S0_inv_d./(1+d_S0_inv_d).^2;
        informationgain = ds_Sigma0_ds - log(1- d_S1_inv_d) - d_S1_inv_d;
        
        index=find(informationgain == max(informationgain));
        maxgain_index = index(1);
        edge_index = [edge_index,maxgain_index];
        
        %% this is the original procedure of simulating observer results
        aa = normrnd(gt_score(i(maxgain_index)),gt_std(i(maxgain_index)));
        bb = normrnd(gt_score(j(maxgain_index)),gt_std(j(maxgain_index)));
        
        Sigma0_inv_d = Sigma_0_inv*d(maxgain_index,:)';
        if aa > bb
            if rand > error_rate
                active_score = s_initial + Sigma0_inv_d*(1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            else
                active_score = s_initial + Sigma0_inv_d*(-1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            end
        elseif aa < bb
            if rand > error_rate
                active_score = s_initial + Sigma0_inv_d*(-1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            else
                active_score = s_initial + Sigma0_inv_d*(1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            end
            
        else
            if rand > 0.5
                active_score = s_initial + Sigma0_inv_d*(-1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            else
                active_score = s_initial + Sigma0_inv_d*(1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            end
        end
        
        
        Sigma_0_inv = Sigma_0_inv - Sigma0_inv_d*Sigma0_inv_d'/(1+d_S0_inv_d(maxgain_index));
        s_initial = active_score;
        
        res.active_kendall(num)=corr(active_score,s_bar,'type','Kendall');
        res.active_plcc(num)=corr(active_score,s_bar);
        [res.active_CC(num), res.active_MAE(num), res.active_RMSE(num), res.active_ROCC(num)]=statistic_analysis(active_score,s_bar);
        
        
        
        %%%%%%------ random sampling ------%%%%%
        temp = randperm(length(edge));
        random_temp = temp(1);
        Sigma_0_inv_random_d = Sigma_0_inv_random*d(random_temp,:)';
        aa = normrnd(gt_score(i(random_temp)),gt_std(i(random_temp)));
        bb = normrnd(gt_score(j(random_temp)),gt_std(j(random_temp)));
        
       
        if aa > bb
            if rand > error_rate
                random_score = s_random + Sigma_0_inv_random_d*(1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d);  
            else
                random_score = s_random + Sigma_0_inv_random_d*(-1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d); 
            end
        elseif aa < bb
            if rand > error_rate
                random_score = s_random + Sigma_0_inv_random_d*(-1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d); 
           else
                random_score = s_random + Sigma_0_inv_random_d*(1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d);  
            end
            
        else
            if rand > 0.5
                random_score = s_random + Sigma_0_inv_random_d*(-1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d); 
           else
                random_score = s_random + Sigma_0_inv_random_d*(1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d);  
            end
        end
        
        s_random = random_score;
        Sigma_0_inv_random = Sigma_0_inv_random - Sigma_0_inv_random_d * Sigma_0_inv_random_d'/(1+d(random_temp,:)*Sigma_0_inv_random_d);
        
        
        res.random_kendall(num)=corr(random_score,s_bar,'type','Kendall');
        res.random_plcc(num)=corr(random_score,s_bar);
        [res.random_CC(num), res.random_MAE(num), res.random_RMSE(num), res.random_ROCC(num)]=statistic_analysis(random_score,s_bar);
        
        
    end

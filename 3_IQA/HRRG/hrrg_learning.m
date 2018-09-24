function [active,random] = hrrg_learning(ground_truth_score,s_bar,N,edge,lambda,totalnum,data_ref,i,j,ii,jj,ij,d)
        edge_index = [];
        Sigma_0_inv=1/lambda*eye(N);
        s_initial = zeros(N,1);
        s_initial = s_initial - mean(s_initial);
        s_random = s_initial;
        Sigma_0_inv_random = Sigma_0_inv;
        
        active_sample=[];
        active_match_ratio=zeros(totalnum,1);
        random_match_ratio=zeros(totalnum,1);
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
            
%             tep=rand(1);
            aa = i(maxgain_index);
            bb = j(maxgain_index);
            
            idx = find(data_ref(:,1)==aa & data_ref(:,2)==bb);
            idx1 = find(data_ref(:,2)==aa & data_ref(:,1)==bb);
            all = [idx;idx1];
            randidx = randperm(length(all));
            use_idx = data_ref(all(randidx(1),:),:);
            
            
            Sigma0_inv_d = Sigma_0_inv*d(maxgain_index,:)';
            if aa == use_idx(1)
                active_score = s_initial + Sigma0_inv_d*(1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            else
                active_score = s_initial + Sigma0_inv_d*(-1-d_s0(maxgain_index))/(1+d_S0_inv_d(maxgain_index));
            end
            
            Sigma_0_inv = Sigma_0_inv - Sigma0_inv_d*Sigma0_inv_d'/(1+d_S0_inv_d(maxgain_index));
            s_initial = active_score;
            
            active.kendall(num)=corr(active_score,ground_truth_score,'type','Kendall');
            active.plcc(num)=corr(active_score,ground_truth_score);
            [active.CC(num), active.MAE(num), active.RMSE(num), active.ROCC(num)]=statistic_analysis(active_score,s_bar);
        
            
            
            
            %%% random sampling
            temp = randperm(length(edge));
            random_temp = temp(1);
            aa = i(random_temp);
            bb = j(random_temp);
            
            idx = find(data_ref(:,1)==aa & data_ref(:,2)==bb);
            idx1 = find(data_ref(:,2)==aa & data_ref(:,1)==bb);
            all = [idx;idx1];
            randidx = randperm(length(all));
            use_idx = data_ref(all(randidx(1),:),:);
            
            Sigma_0_inv_random_d = Sigma_0_inv_random*d(random_temp,:)';
            if aa == use_idx(1)
                random_score = s_random + Sigma_0_inv_random_d*(1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d);
            else
                random_score = s_random + Sigma_0_inv_random_d*(-1-d(random_temp,:)*s_random)/(1+d(random_temp,:)*Sigma_0_inv_random_d);
            end
            
            s_random = random_score;
            Sigma_0_inv_random = Sigma_0_inv_random - Sigma_0_inv_random_d * Sigma_0_inv_random_d'/(1+d(random_temp,:)*Sigma_0_inv_random_d);
            
            random.kendall(num)=corr(random_score,ground_truth_score,'type','Kendall');
            random.plcc(num)=corr(random_score,ground_truth_score);
            [random.CC(num), random.MAE(num), random.RMSE(num), random.ROCC(num)]=statistic_analysis(random_score,s_bar);
        end 
            

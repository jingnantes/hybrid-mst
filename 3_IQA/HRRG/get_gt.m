function [ground_truth_score, s_bar,edge,w] = get_gt(data_ref,N) 

data_ref_temp = data_ref;
    Z = zeros(N,N);
    for i=1:length(data_ref)
        Z(data_ref(i,1),data_ref(i,2)) = Z(data_ref(i,1),data_ref(i,2))+1;
        data_ref_temp(i,1)=min(data_ref(i,:));
        data_ref_temp(i,2)=max(data_ref(i,:));
    end
    
    ground_truth_score=paired_comparisons(Z,'logit');
    s_bar=ground_truth_score-mean(ground_truth_score);
    
    
    edge=unique(data_ref_temp,'rows');
    w = zeros(1,length(edge));
function gt_score = get_gt(N,data_ref)

Z = zeros(N,N);
    for i=1:length(data_ref)
        Z(data_ref(i,1),data_ref(i,2)) = Z(data_ref(i,1),data_ref(i,2))+1;
    end
    
    gt_score = paired_comparisons(Z,'logit');
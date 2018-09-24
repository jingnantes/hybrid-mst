function pref = get_preference_jing(data_ref,a,b,alg_params )
    
%     val_at_a = Xt(a);
%     val_at_b = Xt(b);
    
%     layers = alg_params.layers*alg_params.L;
%     a_layer = find(layers>val_at_a,1,'first');
%     b_layer = find(layers>val_at_b,1,'first');
    idx = find(data_ref(:,1)==a & data_ref(:,2)==b);
            idx1 = find(data_ref(:,2)==a & data_ref(:,1)==b);
            all = [idx;idx1];
            randidx = randperm(length(all));
            use_idx = data_ref(all(randidx(1),:),:);
    if use_idx(1) == a        
    pref = 1;
    else
        pref= -1;
    end
    
    
    
end


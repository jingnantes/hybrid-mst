function pcm = Initial_learning(pcm)
%% this is used for the initialization of the pair comparison test


% we adopt the initial method of Ye Peng, 'active sampling for subjective IQA'

pcm = 0.5.*ones(size(pcm));
for i = 1:size(pcm,1)
    pcm(i,i)=0;
end
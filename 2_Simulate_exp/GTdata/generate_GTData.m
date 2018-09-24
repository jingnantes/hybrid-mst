% generate ground truth data
% gaussian random std
iteration_num = 100;

Number_stimuli = [60];
for ite = 1: iteration_num

% 1 simulation of gaussian? with 0.7 std

    Score(ite,:) = 5*rand(1,Number_stimuli);
    std(ite,:) = 0.7*rand(1,Number_stimuli);
end

save('GTscore.mat','Score','std');
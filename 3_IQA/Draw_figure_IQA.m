%% function draw_figure
%%%-------------Draw figure-------------
clc
clear all
close all
%color_trans = {'k','r','g','c','m','b'};
%line_type = {'k-.','r-','g-','c-','m-','b-','k-','r:','g:','b:','m:','c:','k:'};
color_trans = {'c','m','b'};
line_type = {'c-','m-','b-','k-','r:','g:','b:','m:','c:','k:'};
    LineWidth =2;
    FontSize = 30;
    MarkerSize = 12;
path(path,'./ARD');
path(path,'./FPC');
path(path,'./HRRG');
path(path,'./Hybrid-MST');
path(path,'./Neighbor');
path(path,'./Crowd_BT_new');

full_trial = 16*15/2;
ref_num = 15;

for i = [1 2 3 4 5 6 8 9]
ylim_range_cc{i}=[0.98];
yylabelnumber_cc{i} = [];
end
for i = [9]
ylim_range_cc{i}=[0.985];
yylabelnumber_cc{i} = [];
end
for i = [7 11 12 13 15]
ylim_range_cc{i}=[0.95];
end
for i = [10 14]
ylim_range_cc{i} = [0.96];
end

%data_name = {'FPC/data','ARD/data','HRRG/data_random','Crowd_BT_new/data','HRRG/data_active','Hybrid-MST/data'};
%display_name = {'FPC','ARD','HRRG','Crowd-BT','Hodge-active','Hybrid-MST'};

data_name = {'Crowd_BT_new/data','HRRG/data_active','Hybrid-MST/data'};
display_name = {'Crowd-BT','Hodge-active','Hybrid-MST'};


for ref = 1:ref_num

for i = 1:length(data_name)
    experiment{i} = load(strcat('./',data_name{i},'/ref',num2str(ref),'.mat'));
    if strcmp(data_name{i},'ARD/data') || strcmp(data_name{i},'FPC/data') || strcmp(data_name{i},'Neighbor/data')
        experiment{i}.trial = experiment{i}.trial_num;
    end
end


% cc
    h=figure;
    for i = 1:length(data_name)
    tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = nanmean(experiment{i}.cc_result);
    tmpci = 1.96.*nanstd(experiment{i}.cc_result)./10;
    
%     if i ~= 1 || i ~= 2
%     tmpx = tmpx(1:length(tmpx)/100:end);
%     tmpm = tmpm(1:length(tmpm)/100:end);
%     tmpci = tmpci(1:length(tmpci)/100:end);
%     end
    
    maxnum(i) = max(tmpm+tmpci);
    minnum(i) = min(tmpm-tmpci);
    
    %plot(tmpx,tan(pi./2.*tmpm),line_type{i}, 'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    %h1 = fill([tmpx, fliplr(tmpx)],[tan(pi./2.*(tmpm-tmpci)),fliplr(tan(pi./2.*(tmpm+tmpci)))],color_trans{i});
    plot(tmpx,atanh(tmpm),line_type{i}, 'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    h1 = fill([tmpx, fliplr(tmpx)],[atanh(tmpm-tmpci),fliplr(atanh(tmpm+tmpci))],color_trans{i});
    
    set(h1,'EdgeColor','none');
    alpha(0.5);
    end
    
    
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.01 0.98 round(max(maxnum)*1000)/1000]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    ylim(atanh([0.0001 round(max(maxnum)*1000)/1000]))
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', atanh([0.01 0.98 round(max(maxnum)*1000)/1000])),  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
    %set(h,'visible','off');
    xlabel('Standard trial number');
    %legend(display_name,'Location','southeast'); 
    ylabel('PLCC');
    title(strcat('Ref',num2str(ref)));
    hold off; 
   % saveas(gca,strcat('./figures/1atanh_Ref_',num2str(ref),'_plcc.png'));

    
    % rmse
    h=figure;
    for i = 1:length(data_name)
    tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = nanmean(experiment{i}.rmse_result);
    tmpci = 1.96.*nanstd(experiment{i}.rmse_result)./10;
    
%     if i ~= 1 || i ~= 2
%     tmpx = tmpx(1:length(tmpx)/100:end);
%     tmpm = tmpm(1:length(tmpm)/100:end);
%     tmpci = tmpci(1:length(tmpci)/100:end);
%     end
    
    maxnum(i) = max(tmpm+tmpci);
    minnum(i) = min(tmpm-tmpci);
    
    plot(tmpx,-1./tmpm,line_type{i},'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    h1 = fill([tmpx, fliplr(tmpx)],[-1./(tmpm-tmpci),fliplr(-1./(tmpm+tmpci))],color_trans{i});
    set(h1,'EdgeColor','none');
    alpha(0.5);
    end
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.2 0.5 1.5]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', -1./[0.2 0.5 1.5]),  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
    %set(h,'visible','off');
    xlabel('Standard trial number');
    %legend(display_name); 
    ylabel('RMSE');
    title(strcat('Ref',num2str(ref)));
    hold off;    
    %saveas(gca,strcat('./figures/1log_Ref_',num2str(ref),'_rmse.png'));

    % kendall
    h=figure;
    for i = 1:length(data_name)
    tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = nanmean(experiment{i}.kendall_result);
    tmpci = 1.96.*nanstd(experiment{i}.kendall_result)./10;
    
%     if i ~= 1 || i ~= 2
%     tmpx = tmpx(1:length(tmpx)/100:end);
%     tmpm = tmpm(1:length(tmpm)/100:end);
%     tmpci = tmpci(1:length(tmpci)/100:end);
%     end
    
    maxnum(i) = max(tmpm+tmpci);
    minnum(i) = min(tmpm-tmpci);
    
    %plot(tmpx,tan(pi./2.*tmpm),line_type{i}, 'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    %h1 = fill([tmpx, fliplr(tmpx)],[tan(pi./2.*(tmpm-tmpci)),fliplr(tan(pi./2.*(tmpm+tmpci)))],color_trans{i});
    plot(tmpx,atanh(tmpm),line_type{i}, 'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    h1 = fill([tmpx, fliplr(tmpx)],[atanh(tmpm-tmpci),fliplr(atanh(tmpm+tmpci))],color_trans{i});
   
    set(h1,'EdgeColor','none');
    alpha(0.5);
    end
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.01 0.8 round(max(maxnum)*100)/100]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    ylim(atanh([0.01 round(max(maxnum)*100)/100]))
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', atanh([0.01 0.8 round(max(maxnum)*100)/100]))  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
   % set(h,'visible','off');
    xlabel('Standard trial number');
    %legend(display_name,'Location','southeast'); 
    ylabel('Kendall');
    title(strcat('Ref',num2str(ref)));
    hold off;
    %saveas(gca,strcat('./figures/1atanh_Ref_',num2str(ref),'_kendall.png'));

    % rocc
%     figure;
%     for i = 1:length(data_name)
%     %errorbar(mean(experiment{i}.trial,1),mean(experiment{i}.cc_result),1.96.*std(experiment{i}.cc_result)./10,line_type{i},'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
%     plot(mean(experiment{i}.trial,1)./full_trial,mean(experiment{i}.rocc_result),line_type{i},'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
%     end
%     xlim(xlim_range)
%     set(gca,'FontSize',FontSize);
%     xlabel('trial number');
%     legend(display_name); 
%     title('ROCC');
%     hold off;
end    

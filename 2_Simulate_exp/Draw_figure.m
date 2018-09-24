%% function draw_figure
%%%-------------Draw figure-------------
clc
clear all
close all

line_type = {'k-.','r-','g-','c-','m-','b-','k-','r:','g:','b:','m:','c:','k:'};
    LineWidth =2;
    FontSize = 30;
    MarkerSize = 12;
path(path,'./ARD');
path(path,'./FPC');
path(path,'./HRRG');
path(path,'./Hybrid-MST');
path(path,'./Neighbor');
path(path,'./Crowd_BT_new');

full_trial = 60*59/2;
color_trans = {'k','r','g','c','m','b'};

data_name = {'fpc','ard','hrrg_random','crowdbt','hrrg_active','hybridmst'};
display_name = {'FPC','ARD','HRRG','Crowd-BT','Hodge-active','Hybrid-MST'};

for i = 1:length(data_name)
    experiment{i} = load(strcat(data_name{i},'.mat'));
    
end


% cc
    h=figure;
    for i = 1:length(data_name)
     tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = mean(experiment{i}.cc_result);
    tmpci = 1.96.*std(experiment{i}.cc_result)./10;
    
    tmpx = tmpx(1:length(tmpx)/500:end);
    tmpm = tmpm(1:length(tmpm)/500:end);
    tmpci = tmpci(1:length(tmpci)/500:end);
    
  
    
   plot(tmpx,atanh(tmpm),'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
   
     h1 = fill([tmpx, fliplr(tmpx)],[atanh(tmpm-tmpci),fliplr(atanh(tmpm+tmpci))],color_trans{i});
    set(h1,'EdgeColor','none');
    %alpha(0.5);

    end
    
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.1 0.995 0.999 1]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', atanh([0.1 0.995 0.999 1])),  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
    %set(h,'visible','off');
    xlabel('Standard trial number');
    
    ylabel('PLCC');
    hold off;    
    %saveas(gca,strcat('./figures/','atanh_plcc.png'));

    % rmse
    h=figure;
    for i = 1:length(data_name)
    %errorbar(mean(experiment{i}.trial,1)./full_trial,mean(experiment{i}.rmse_result),1.96.*std(experiment{i}.rmse_result)./10,line_type{i},'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = mean(experiment{i}.rmse_result);
    tmpci = 1.96.*std(experiment{i}.rmse_result)./10;
    
    tmpx = tmpx(1:length(tmpx)/500:end);
    tmpm = tmpm(1:length(tmpm)/500:end);
    tmpci = tmpci(1:length(tmpci)/500:end);
    
    plot(tmpx,-1./tmpm,'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    h1 = fill([tmpx, fliplr(tmpx)],[-1./(tmpm-tmpci),fliplr(-1./(tmpm+tmpci))],color_trans{i});
    set(h1,'EdgeColor','none');
    %alpha(0.5);

    end
   
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.05 0.1 0.2 0.5 1.5]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', -1./[0.05 0.1 0.2 0.5 1.5]),  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
    %set(h,'visible','off');
    xlabel('Standard trial number');
     
    ylabel('RMSE');
    hold off;    
    %saveas(gca,strcat('./figures/','log_rmse.png'));

    % kendall
    h=figure;
    for i = 1:length(data_name)
    %errorbar(mean(experiment{i}.trial,1)./full_trial,mean(experiment{i}.kendall_result),1.96.*std(experiment{i}.kendall_result)./10,line_type{i},'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    tmpx = mean(experiment{i}.trial,1)./full_trial;
    tmpm = mean(experiment{i}.kendall_result);
    tmpci = 1.96.*std(experiment{i}.kendall_result)./10;
    tmpx = tmpx(1:length(tmpx)/500:end);
    tmpm = tmpm(1:length(tmpm)/500:end);
    tmpci = tmpci(1:length(tmpci)/500:end);
    
    plot(tmpx,atanh(tmpm),'LineWidth',LineWidth,'MarkerSize',MarkerSize); hold on;
    h1 = fill([tmpx, fliplr(tmpx)],[atanh(tmpm-tmpci),fliplr(atanh(tmpm+tmpci))],color_trans{i});
    set(h1,'EdgeColor','none');
    %alpha(0.5);
    end
    
    for xx = 0:1:15
    xxlabel{xx+1} = num2str(xx);
    end
    d=0;
    for yy = [0.1 0.96 0.985]
        d = d+1;
        yylabel{d} = num2str(yy);
    end
    xlim([0 15]);
    ylim(atanh([0.01 0.988]))
    set(gca, 'XTick', [0:1:15]), 
    set(gca,'XTickLabel', xxlabel), 
    set(gca,'YTick', atanh([0.1 0.96 0.985]))  
    set(gca,'YTickLabel',yylabel);
    
    set(gca,'FontSize',FontSize);
   % set(h,'visible','off');
    xlabel('Standard trial number');
    %legend(display_name,'Location','southeast'); 
    ylabel('Kendall');
    hold off;
    %saveas(gca,strcat('./figures/','atanh_kendall.png'));
   
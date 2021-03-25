%%%%%%%%%%below is my test

axes('position',[0.03 0.74 0.03 0.15]);

text(0.3,0.5,'Annual','fontsize',10,'fontweight','bold','color','k')

axis('off')

 

axes('position',[0.03 0.58 0.03 0.15]);

text(0.3,0.5,'Winter','fontsize',10,'fontweight','bold','color','k')

axis('off')

 

axes('position',[0.03 0.42 0.03 0.15]);

text(0.3,0.5,'Spring','fontsize',10,'fontweight','bold','color','k')

axis('off')

 

axes('position',[0.03 0.26 0.03 0.15]);

text(0.3,0.5,'Summer','fontsize',10,'fontweight','bold','color','k')

axis('off')

 

axes('position',[0.03 0.10 0.03 0.15]);

text(0.3,0.5,'Fall','fontsize',10,'fontweight','bold','color','k')

axis('off')

 

 

axes('position',[0.15 0.74 0.8 0.13]);

h1=plot([n1:np2],mean(squeeze(season_tmp(:,:)),1),'-k')

hold on

h2=plot([n1:n2],mean(squeeze(sst_data(:,:)),1),'-b')

plot([2015 2015],[7 12.5],'r-','linewidth',2)

% ylim([7 12.5]);

xlim([n1 np2]);

grid on

legend([h1 h2],'cmip6','HD')

text(1980, 11, eval(['model',num2str(n)]))

set(gca,'xticklabel','');

 

 

axes('position',[0.15 0.58 0.8 0.13]);

h1=plot([n1:np2],mean(squeeze(season_tmp(1:3,:)),1),'-k')

hold on

h2=plot([n1:n2],mean(squeeze(sst_data(1:3,:)),1),'-b')

plot([2015 2015],[3 9],'r-','linewidth',2)

% ylim([3 9]);

xlim([n1 np2]);

grid on

 

 

set(gca,'xticklabel','');

 

 

axes('position',[0.15 0.42 0.8 0.13]);

h1=plot([n1:np2],mean(squeeze(season_tmp(4:6,:)),1),'-k')

hold on

h2=plot([n1:n2],mean(squeeze(sst_data(4:6,:)),1),'-b')

plot([2015 2015],[4 11],'r-','linewidth',2)

% ylim([4 11]);

xlim([n1 np2]);

grid on

 

set(gca,'xticklabel','');

 

axes('position',[0.15 0.26 0.8 0.13]);

h1=plot([n1:np2],mean(squeeze(season_tmp(7:9,:)),1),'-k')

hold on

h2=plot([n1:n2],mean(squeeze(sst_data(7:9,:)),1),'-b')

plot([2015 2015],[11.5 18],'r-','linewidth',2)

% ylim([11.5 18]);

xlim([n1 np2]);

grid on

 

set(gca,'xticklabel','');

 

set(gca,'xticklabel','');

 

axes('position',[0.15 0.10 0.8 0.13]);

 

h1=plot([n1:np2],mean(squeeze(season_tmp(10:12,:)),1),'-k')

hold on

h2=plot([n1:n2],mean(squeeze(sst_data(10:12,:)),1),'-b')

 

plot([2015 2015],[8.5 14.5],'r-','linewidth',2)

% ylim([8.5 14.5]);

xlim([n1 np2]);

grid on
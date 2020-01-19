cd ../..

figure('Position',[50,50,720,900]);

nr = 5; 
nc = 2;

yl = [-0.2 0.45;
    -0.2 0.4;
    -0.2 0.35;
    -0.2 0.35;
    -0.2 0.5];

bl = [0.2 0.2 1];
gr = [0 0.5 0];

% load RSA results
load('data\cms.mat'); 
% load precalculated significant region-time points
load('data\sgnf_cmf1.mat');
sgnf1 = sgnf;
load('data\sgnf_cmt1.mat');
sgnf2 = sgnf;

% make nonnan selection of participants
pp1 = find(~isnan(cms(1,:,1,1)));
pp2 = find(~isnan(cms(2,:,1,1)));

r = 37;
lin = 1;

my_subplot_wh(nr,nc,1+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerFaceColor',gr,'MarkerEdgeColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 38;
lin = 1;
my_subplot_wh(nr,nc,2+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 49;
lin = 2;

my_subplot_wh(nr,nc,1+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 50;
lin = 2;
my_subplot_wh(nr,nc,2+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 1;
lin = 3;

my_subplot_wh(nr,nc,1+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 2;
lin = 3;
my_subplot_wh(nr,nc,2+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 15;
lin = 4;

my_subplot_wh(nr,nc,1+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 16;
lin = 4;
my_subplot_wh(nr,nc,2+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 41;
lin = 5;

my_subplot_wh(nr,nc,1+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
[b,a]=butter(3,1/2,'low');
v = filtfilt(b,a,v')';
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
tt(tt<300)=[];
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);

r = 42;
lin = 5;
my_subplot_wh(nr,nc,2+(lin-1)*nc,0.1,0.05)

v = squeeze(nanmean(cms(1,pp1,r,:),2));
plot(0:10:500,v(1:51),'Color',bl,'LineWidth',1.5);hold on
tt = 10*(sgnf1.t(sgnf1.r==r)-1);
scatter(tt,-0.1*ones(size(tt)),10,'MarkerEdgeColor',bl,'MarkerFaceColor',bl,'Marker','o');

v = squeeze(nanmean(cms(2,pp2,r,:),2));
plot(0:10:500,v(1:51),'Color',gr,'LineWidth',1.5);hold on
tt = 10*(sgnf2.t(sgnf2.r==r)-1);
scatter(tt,-0.15*ones(size(tt)),10,'MarkerEdgeColor',gr,'MarkerFaceColor',gr,'Marker','o');

axis tight; box off;
ylim([yl(lin,1) yl(lin,2)]);



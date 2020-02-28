% -------------------------------------------------------------------------
% SLANT-STACK - LINEAR RADON TRANSFORM (TAU-P)
% 
% Last updated date: 16-12-2019.
% -------------------------------------------------------------------------
clear;
clc;
close all;

% Geometry parameters
dt = 0.004;
nt = 1200;
dx = 50;
nx = 20;
xmin = 50;

% Temporal and spatial axes
t = (0:nt-1)*dt;
x = xmin + (0:nx-1)*dx;

% Input Data: CDP gather
a = fopen('cdp_1000.bin','r');
cdp = fread(a,[nt,nx],'float');
fclose(a);
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% LRT
[radon,tau,p] = LRT_forward(cdp,t,x);

figure(1)
radon_ida=figure(1);
subplot(1,2,1)
wigb(cdp,1,x,t)
hTitle=title('CDP 1000', 'Interpreter','latex','fontsize',16);
xlabel('Afastamento ($m$)','Interpreter','latex','fontsize',14)
ylabel('Tempo ($s$)','Interpreter','latex','fontsize',14)
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
%
subplot(1,2,2)
wigb(radon,1,p,tau)
hTitle=title('Dom\''inio $\tau$-p', 'Interpreter','latex','fontsize',16);
xlabel('Inclina\c{c}\~{a}o ($s/m$)','Interpreter','latex','fontsize',14)
ylabel('$\tau$ ($s$)','Interpreter','latex','fontsize',14)
set(gcf,'color','w', 'Position', get(0, 'Screensize'));
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
export_fig('radon_ida','-pdf','-png');
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
hold on
npoints = 4;
idx_tau = zeros(1,npoints);
idx_p = zeros(1,npoints);

% Coordinate selection
for i = 1:npoints
    [idx_p(i), idx_tau(i)] = ginput(1);
end

np = length(p);
% Upper cut
tau_cut1 = linspace(idx_tau(1),idx_tau(2),np);
p_cut1 = linspace(idx_p(1),idx_p(3),np);

% Lower cut
tau_cut2 = linspace(idx_tau(3),idx_tau(4),np); 
p_cut2 = linspace(idx_p(2),idx_p(4),np);

% Cut-off filter
mask = ones(nt,np);

for ip = 1:np
    for it = 1:nt
       if (tau_cut1(ip) <= tau(it) && tau_cut2(ip) >= tau(it)) && (p_cut1(ip) <= p(ip) && p_cut2(ip) >= p(ip))
          mask(it,ip) = 0; 
       end
   end
end

figure(3)
Cut_off_Filter=figure(3);
subplot(1,2,1)
wigb(radon,1,p,tau)
hTitle=title('Dom\''inio $\tau$-p', 'Interpreter','latex','fontsize',16);
xlabel('Inclina\c{c}\~{a}o ($s/m$)','Interpreter','latex','fontsize',14)
ylabel('$\tau$ ($s$)','Interpreter','latex','fontsize',14)
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
%
subplot(1,2,2)
imagesc(p,tau,mask)
colorbar;
hTitle=title('Filtro de corte', 'Interpreter','latex','fontsize',16);
xlabel('Inclina\c{c}\~{a}o ($s/m$)','Interpreter','latex','fontsize',14)
ylabel('$\tau$ ($s$)','Interpreter','latex','fontsize',14)
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
set(gcf,'color','w', 'Position', get(0, 'Screensize'));
export_fig('Cut_off_Filter','-pdf','-png');

% -------------------------------------------------------------------------
radon = radon.*mask;
% Inverse LRT
[inv_cdp,t,x] = LRT_backward(radon,tau,p,x);

figure(2)
radon_volta=figure(2);
subplot(1,2,1)
wigb(radon,1,p,tau)
hTitle=title('Dom\''inio $\tau$-p', 'Interpreter','latex','fontsize',16);
xlabel('Inclina\c{c}\~{a}o ($s/m$)','Interpreter','latex','fontsize',14)
ylabel('$\tau$ ($s$)','Interpreter','latex','fontsize',14)
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
%
subplot(1,2,2)
wigb(inv_cdp,1,x,t)
hTitle=title('CDP 1000 reconstru\''ido', 'Interpreter','latex','fontsize',16);
xlabel('Afastamento ($m$)','Interpreter','latex','fontsize',14)
ylabel('Tempo ($s$)','Interpreter','latex','fontsize',14)
set(hTitle,'FontSize',16)
set(gca,'fontsize',14);
set(gcf,'color','w', 'Position', get(0, 'Screensize'));
export_fig('radon_volta','-pdf','-png');
% -------------------------------------------------------------------------
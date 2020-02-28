clc;
close all;
clear;
tic;
%-----------------------------------------------
% Carregar o arquivo txt ou dat
%-----------------------------------------------
cdp=load('cdp.txt');
%
figure(1)
plot(cdp(:,1),cdp(:,2),'*b')
grid on;
title('CDP com cobertura m\''axima', 'Interpreter','latex','fontsize',20,'fontweight','b')
xlabel('N\''umero de CDP','Interpreter','latex','fontsize',15,'fontweight','b')
ylabel('N\''umero de tra\c{c}os','Interpreter','latex','fontsize',15,'fontweight','b')
xlim([0 11000]);
set(gca,'FontSize',20);  % tamanho da fonte dos axis
set(gcf,'color','w', 'Position', get(0, 'Screensize'));
export_fig('CDP_iluminados','-pdf','-png');
% saveas(gcf,'CDP_iluminados.eps','epsc')
% saveas(1,'CDP_iluminados.png')

toc;

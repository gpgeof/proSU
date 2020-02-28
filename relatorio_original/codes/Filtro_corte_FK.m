%--------------------------------------------------------------------------
% Codigo: Filtragem no dominio f-k de uma secao tiro 
%--------------------------------------------------------------------------
% Objetivo: Adicionar ruido e ganho no dado e realizar filtragem iterativa
% no dominio f-k de uma secao tiro.
% Atualizacao: 26 de Junho de 2019.
% Programador: Murilo Santiago Vale Rodrigues (murilovj@gmail.com)
%--------------------------------------------------------------------------
clc;
close all;
clear;
tic;
%
% slCharacterEncoding('UTF-8'); % acentuacao nos graficos
%--------------------------------------------------------------------------
%           Desenho do filtro no dominio da frequencia
%--------------------------------------------------------------------------
nPt=1200;    % Num. pontos tempo do filtro Em-leque.
nPz=96;     % Num. pontos distancia do filtro Em-leque Tiro 50.

A=fopen('tiro_50.bin','r');        % leitura do arquivo binario
pw_int=fread(A,[nPt,nPz],'float'); % criacao da matriz 
fclose(A);

Dtt=0.004;      % intervalo temporal. 
fator= 0.25;    % fator de ruido.
%--------------------------------------------------------------------------
%           Desenho do filtro no dominio da frequencia
%--------------------------------------------------------------------------
agc_gate=2;   % gate agc
coef_a = 2;   % coeficiente a da funcao ganho.
coef_b = 0.5; % coeficiente b da funcao ganho.
%  pw_int_gain=gain1(pw_int,Dtt,'agc',agc_gate,1);
pw_int_gain=gain1(pw_int,Dtt,'time',[coef_a,coef_b],1);
%--------------------------------------------------------------------------
t=(0:nPt-1)*Dtt;       % vetor tempo
dist=1862:12.5:3050; % distancia para o tiro 50
%dist=[1:96];
%--------------------------------------------------------------------------
%                      Gerando ruido aleatorio
%--------------------------------------------------------------------------
ruido=fator*(2*randn(nPt,nPz)-0.5);
pw_int_ruido=pw_int+ruido;
%pw_int_ruido=pw_int_gain+ruido;
coefa_ruido=1.1;
coefb_ruido=0.3;
secao_tiro=gain1(pw_int,Dtt,'time',[1,1],1);
pw_int_ruido_gain=gain1(pw_int_ruido,Dtt,'time',[coefa_ruido,coefb_ruido],1);
%--------------------------------------------------------------------------
%                              Figuras
%--------------------------------------------------------------------------
figure(1)
% wigb(pw_int,1,dist,t)
wiggle(t,dist,secao_tiro,'vK')
grid on
title('Secao tiro 50','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)') 
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig1','epsc')
saveas(1,'fig1.png')
%
figure(2)
% wigb(pw_int_gain,1,dist,t)
wiggle(t,dist,pw_int_gain,'vK')
grid on
title('Secao tiro 50 com ganho','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)') 
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig2','epsc')
saveas(2,'fig2.png')
%
figure(3)
% wigb(pw_int_ruido,1,dist,t)
wiggle(t,dist,pw_int_ruido,'vK')
title('Secao tiro 50 com ruido','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)') 
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig3','epsc')
saveas(3,'fig3.png')
%
figure(4)
% wigb(pw_int_ruido_gain,1,dist,t)
wiggle(t,dist,pw_int_ruido_gain,'vK')
title('Secao tiro 50 com ruido e ganho','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)') 
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig4','epsc')
saveas(4,'fig4.png')
%%
%--------------------------------------------------------------------------
%                       Aplicacao do filtro Fk
%--------------------------------------------------------------------------
ntpad=nPt;
nx=1;

nxpad=1;
while nxpad < nx
    nxpad=2*nxpad;
end

percent=0;
ishift=1;

% [spec,f_int,kx_int]=fktran(pw_int,t,dist,ntpad,nxpad,percent,ishift);
 [spec,f_int,kx_int]=fktran(pw_int_ruido,t,dist,ntpad,nxpad,percent,ishift);


modulo_spec=sqrt((real(spec)).^2 +(imag(spec)).^2);

[nf,nk]=size(modulo_spec);

zz=1:nf;                              % vetor profundidade (indice j-z) 
xx=1:nk;                              % vetor distancia    (indice i-x)


modulo_spec_mute=modulo_spec;
spec_1=spec;

figure(5)
imagesc(modulo_spec)
colorbar;
grid on;
title('Espectro de amplitude da secao tiro 50 com ruido','fontsize',15,'fontweight','b')
xlabel('Indice de frequencia espacial') 
ylabel('Indice de frequencia temporal')
set(gca,'FontSize',15);
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig5','epsc')
saveas(5,'fig5.png')
 
num_point=2;
  
hold on
indice_j=zeros(1:num_point);
indice_i=zeros(1:num_point);
  for i = 1:num_point
        [indice_j(i),indice_i(i)] = ginput(1);
        plot(indice_j(i),indice_i(i),'m+','LineWidth',2)% ko is a circlur point. you can use '*' point.
  end

n_pontos=50;
ii = linspace(indice_i(1),indice_i(2),n_pontos); % vetor velocidade  
jj = linspace(indice_j(1),indice_j(2),n_pontos); % vetor velocidade  
  
mute=[jj;ii];
[~,n] = size(mute);

%--------------------------------------------------------------------------
%                           Corte na matriz 
%--------------------------------------------------------------------------
for i=1:nk                  % loop sobre o exio x
     for j=1:nf             % loop sobre o exio z
         for k=1:n           % loop sobre o vetor mute
          if(zz(j)<=mute(2,k)) && (xx(i)>=mute(1,k)) % se a coordenada em z e x for menor o arquivo mute
               modulo_spec_mute(j,i)=0.0;
               spec_1(j,i)=0.0;

          end
         end
     end
end
%--------------------------------------------------------------------------

modulo_spec_mute_aux1=modulo_spec_mute;
spec_21=spec_1;

figure(6)
imagesc(modulo_spec_mute)
hold on;
plot(mute(1,:),mute(2,:),'-*y')  
colorbar;
grid on;
title('Espectro de amplitude da secao tiro 50 com ruido','fontsize',15,'fontweight','b')
xlabel('Indice de frequencia espacial') 
ylabel('Indice de frequencia temporal')
set(gca,'FontSize',15);
hold off;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig6','epsc')
saveas(6,'fig6.png')
% 
num_point=2;
% 
hold on 
  for i = 1:num_point
        [indice_j(i),indice_i(i)] = ginput(1);
        plot(indice_j(i),indice_i(i),'m+','LineWidth',2)% ko is a circlur point. you can use '*' point.
  end
% 
n_pontos=50;
ii = linspace(indice_i(1),indice_i(2),n_pontos); % vetor velocidade  
jj = linspace(indice_j(1),indice_j(2),n_pontos); % vetor velocidade  
%   
mute=[jj;ii];
[~,n] = size(mute);

%--------------------------------------------------------------------------
%                           Corte na matriz 
%--------------------------------------------------------------------------

for i=1:nk                  % loop sobre o exio x
     for j=1:nf             % loop sobre o exio z
         for k=1:n           % loop sobre o vetor mute
         if(zz(j)<=mute(2,k)) && (xx(i)<=mute(1,k))    % se a coordenada em z e x for menor o arquivo mute
        %  if(zz(j)>=mute(2,k)) && (xx(i)<=mute(1,k))    % se a coordenada em z e x for menor o arquivo mute
              modulo_spec_mute_aux1(j,i)=0.0;
               spec_21(j,i)=0.0;
         end
        end
     end
end

modulo_spec_mute_aux=modulo_spec_mute_aux1;
spec_2=spec_21;
%
figure(7)
imagesc(modulo_spec_mute_aux1)
hold on;
plot(mute(1,:),mute(2,:),'-*y')
colorbar;
grid on;
title('Espectro de amplitude da secao tiro 50 com ruido','fontsize',15,'fontweight','b')
xlabel('Indice de frequencia espacial') 
ylabel('Indice de frequencia temporal')
set(gca,'FontSize',15);
hold off;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig7','epsc')
saveas(7,'fig7.png')
%
num_point=2;
  
hold on 
  for i = 1:num_point
        [indice_j(i),indice_i(i)] = ginput(1);
        plot(indice_j(i),indice_i(i),'m+','LineWidth',2)% ko is a circlur point. you can use '*' point.
  end

n_pontos=50;
ii = linspace(indice_i(1),indice_i(2),n_pontos); % vetor velocidade  
jj = linspace(indice_j(1),indice_j(2),n_pontos); % vetor velocidade  
  
mute=[jj;ii];
[m,n] = size(mute);

% i=1;
% j=1;
% k=1;
%--------------------------------------------------------------------------
%                           Corte na matriz 
%--------------------------------------------------------------------------

for i=1:nk                  % loop sobre o exio x
     for j=1:nf             % loop sobre o exio z
         for k=1:n           % loop sobre o vetor mute
         if(zz(j)>=mute(2,k)) && (xx(i)<=mute(1,k))    % se a coordenada em z e x for menor o arquivo mute
        %  if(zz(j)>=mute(2,k)) && (xx(i)<=mute(1,k))  % se a coordenada em z e x for menor o arquivo mute
              modulo_spec_mute_aux(j,i)=0.0;
               spec_2(j,i)=0.0;
         end
        end
     end
end

figure(8)
imagesc(modulo_spec_mute_aux)
hold on;
plot(mute(1,:),mute(2,:),'-*y')
colorbar;
grid on;
title('Espectro de amplitude da secao tiro 50 com ruido','fontsize',15,'fontweight','b')
xlabel('Indice de frequencia espacial') 
ylabel('Indice de frequencia temporal')
set(gca,'FontSize',15);
hold off;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig8','epsc')
saveas(8,'fig8.png')
% 
filt_spec=spec_2;
nfpad=0;
nkpad=0;
% 
[pw_ifk,t_fk,z_fk]=ifktran(filt_spec,f_int,kx_int,nfpad,nkpad,percent);
%   
figure(9)
% wigb(pw_ifk,1,dist,t) %pw_ifk(1:1001,:),1,dist,t(1:1001) % corte
wiggle(t,dist,pw_ifk,'vK')
grid on;
title('Secao filtrada sem ganho','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)')
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig9','epsc')
saveas(9,'fig9.png')
%
coef_a = 2;   % coeficiente a da funcao ganho.
coef_b = 0.5; % coeficiente b da funcao ganho.
pw_ifk_gain=gain1(pw_ifk,Dtt,'time',[coef_a,coef_b],1); % ganho na secao filtrada
% 
figure(10)
% wigb(pw_ifk_gain,1,dist,t) %pw_ifk(1:1001,:),1,dist,t(1:1001)
wiggle(t,dist,pw_ifk_gain,'vK')
grid on;
title('Secao filtrada com ganho','fontsize',15,'fontweight','b')
xlabel('Distancia -x, (m)')
ylabel('Tempo-t, (s)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig10','epsc')
saveas(10,'fig10.png')
% 
figure(11)
imagesc(ruido);
colorbar;
title('Ruido aleatorio','fontsize',15,'fontweight','b')
xlabel('Indice de Distancia')
ylabel('Indice temporal')
set(gcf, 'Position', get(0, 'Screensize'));
set(gca,'FontSize',15);  % tamanho da fonte dos axis
saveas(gcf,'fig11','epsc')
saveas(11,'fig11.png')
%
%--------------------------------------------------------------------------
%        Funcao ganho no tempo: g(t)=t^(a) * e^(-b*t)
%--------------------------------------------------------------------------
%
t_gain=0:0.01:2;     % vetor tempo
curva_gainho = t_gain.^coef_a.*exp(-coef_b.*t_gain);
figure(12)
plot(t_gain,curva_gainho,'LineWidth',2);
title('Curva de ganho aplicada','fontsize',15,'fontweight','b')
xlabel('Tempo-t, (s)')
ylabel('Ganho g(t)')
set(gca,'FontSize',15);  % tamanho da fonte dos axis
grid on;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'fig12','epsc')
saveas(12,'fig12.png')

toc;


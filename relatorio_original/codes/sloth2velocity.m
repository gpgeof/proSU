clear;
clc;
close;

% Este script converte os valores de sloth (S=1/V^2, V=velocidade em m/s)

% Este comando faz a leitura do arquivo binario no matlab, onde [350,1200]
% sao as dimensoes da matriz gerada no comando tri2uni.

H=fopen('geomodel.tri','r');
S=fread(H,[350,1200],'float');
fclose(H);

% Este comando faz o calculo de conversao de sloth para velocidade em m/s
A=1./S;
B=sqrt(A);
V=1000.*B;

x=0:0.010:12000; % distancia em x
z=0:0.010:3500;  % distancia em z

% Rho = zeros(350,1200);
%  for i=1:1200
%      for j=1:350
%      if(V(j,i)==1500)
%          Rho(j,i)=1;
%      else
%      Rho(j,i)=(0.452+0.4788*V(j,i))/1000;
% %     Rho(j,i)=1.741*(V(j,i)^0.25);   % criacao do modelo de densidade.
%      end
%      end
%  end

figure(1)
imagesc(x,z,V)
grid on;
colorbar;
xlabel('Distancia (m)')
ylabel('Profundidade (m)')
title('Modelo de velocidade (m/s)')
set(gca,'FontSize',15); 
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'modelo_de_velocidade','epsc')
saveas(1,'modelo_de_velocidade.png')
%
% figure(2)
% imagesc(x,z,Rho)
% grid on;
% colorbar;
% xlabel('Distancia (Km)')
% ylabel('Profundidade (Km)')
% title('Modelo de densidade')
% set(gca,'FontSize',15); 
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'modelo_de_densidade','epsc')
% saveas(2,'modelo_de_densidade.png')

% Este comando salva em formato binario o arquivo de velocidade ja convertido em m/s
J=fopen('modelo_velocidade.bin','w');
fwrite(J,V,'float');
fclose(J);
%
% Z=fopen('modelo_densidade.bin','w');
% fwrite(Z,Rho,'float');
% fclose(Z);
exit;

clear all
close all
clc

graphics_toolkit('fltk')      

%=================================================================================================================================
% Recuperation des modules de 0 a 180 degrés
%=================================================================================================================================

% frequence 50-500 Hz, demarre ligne 2, 1Hz par ligne.              Exemple: f=326 HZ => ligne 278
freq = 400;
L_freq = freq - 50 + 2;
mod_180 = ones(1,18);

for i = 1:1:19
	angle = i*10 -10;                               %evite l'indice 0 car ça merde pour les tableaux
	fid = fopen(['./donnees/monopole_' num2str(angle) '/FRF_ModPhase.txt']);
	titre = fgetl(fid);
	[donnees , plop ] = fscanf(fid, '%g %g %g', [3, inf]);       %donnees est une matrice 5*Inf ici, du coup f=donnees(1,:)      
	mod_180(1,i) = donnees(2,L_freq);
	fclose(fid);
end


%=================================================================================================================================
% Extrapolation à 360 degrés => système symétrique
%=================================================================================================================================

mod_180_inverse = fliplr(mod_180);
mod_360 = [mod_180 mod_180_inverse(2:18)];

%=================================================================================================================================
% Représentation graphique de la mesure
%=================================================================================================================================
angle = 0:10:350;

%experience
%----------
subplot(1,2,1)
h1 = polar(angle/360*2*pi,mod_360);
set(h1,'color','r','linewidth',3)
title('quadripole experimentale');


%theorie
%--------
monopole= cos(angle / 360 *2*pi);
%~ dipole= cos(angle / 360 *2*pi).*cos(angle / 360 *2*pi);
%~ quadripole_lin= cos(angle / 360 *2*pi).*cos(angle / 360 *2*pi + pi/3);
%~ quadripole= cos(angle / 360 *2*pi).*sin(angle / 360 *2*pi);

subplot(1,2,2)
h2 = polar(angle/360*2*pi,monopole);
set(h2,'color','b','linewidth',3)
title('quadripole theorique');
xlim([0 1]);
ylim([-0.5 0.5]);

%~ print -dpng monopole.png



clear all
cave
close all
clc

graphics_toolkit('fltk')          %affichage gnuplot

fid = fopen('masse_grosse_guitare_1_uniform/FRF_ModPhase.txt');
titre = fgetl(fid);
[donnees , plop ] = fscanf(fid, '%g %g', [5, inf]);      %donnees est une matrice 5*Inf ici, du coup f=donnees(1,:)      

f = donnees(1,:);
accelero_mod_frf = donnees(2,:);
micro_mod_frf = donnees(4,:);

taille_ecran= get(0,'ScreenSize');                                                % récupère les dimensions de l'écran   [Xdébut Ydébut Xfin Yfin]
fig = figure('Position',[1,1,taille_ecran(1,3),taille_ecran(1,4)-65]);            %65=correction barre tache %figure('Position',[startx,starty,width,height]);

subplot(2,1,1)
semilogy(f, accelero_mod_frf, 'Linewidth',3);
xlabel('Frequence en Hz','fontsize',17);
ylabel('abs(A/F)','fontsize',17);
set(gca, 'FontSize', 15); 


subplot(2,1,2)
semilogy(f,micro_mod_frf, 'linewidth',3);
ylabel('abs(P/F)','fontsize',17);
xlabel('Frequence en Hz','fontsize',17);
set(gca, 'FontSize', 15); 


print -dpng '-S(taille_ecran(1,3),(taille_ecran(1,4)-65))' FRF_masse_grosse.png



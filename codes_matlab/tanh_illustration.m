clear all
close all
clc

N = 200;

a = linspace(-5,5,N);

Re = 1;
beta = 1.35;


for i=1:1:N
	creneau(i) = 1;
	if (a(i)<0) creneau(i) = -1; end
end


taille_ecran = get(0,'ScreenSize');
fig = figure('Position',[1,1,taille_ecran(1,3), taille_ecran(1,4)-65]);


nb_courbes = 10;
Re = linspace(0.5, 5, nb_courbes);
couleurs_courbes = hsv(nb_courbes);

h = zeros(1,nb_courbes+1);
for i=1:1:nb_courbes
	hold on
	V = tanh(a*Re(i)*beta);
	h(i) = plot(a,V, 'color', couleurs_courbes(i,:), 'Linewidth', 2);
end

h(i+1) = plot(a,creneau,'Linewidth',3, 'k');


xlabel('X', 'fontsize', 17);
ylabel('V', 'fontsize', 17);
set(gca, 'fontsize', 15);

truc = zeros(nb_courbes,4);
for i = 1:1:nb_courbes
	truc(i,:) = 'Re= '; 
end

leg = legend(h, [truc,num2str((Re).') ; 'creneau'], 'Location', 'NorthWest');
m = findobj(leg, 'type','line');
set(m,'linewidth',12)
legend('boxoff')

legtxt = findobj(leg, 'type','text');
couleurs_courbes2 = flipud(couleurs_courbes);
for i=nb_courbes+1:-1:2
	set(legtxt(i), 'color',couleurs_courbes2(i-1,:))
end

%print -dpng '-S(taille_ecran(1,3),(taille_ecran(1,4)-65))' test.png

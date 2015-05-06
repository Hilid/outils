clear all
close all
clc

figure(1)

nb_courbes = 10;
couleurs_courbes = hsv(nb_courbes);

for n=1:1:nb_courbes
%	h(n)=plot(t,courben, 'color', couleurs(n,:));
	h(n) = line(rand(3,1),rand(3,1),'color',couleurs(n,:));
end


legend(h, num2str((1:nb_courbes).'));

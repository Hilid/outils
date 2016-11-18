clear all
close all
clc

%résolution des fonctions de transferts
N = 300;


% Cas du filtrge adaptatif
coefs_fa1 = [ 0.243527493120; 
		     -0.204788880640;
			  0.120007591680;
			 -0.045211119360;
			  0.008228661760];

somme = zeros(1,N);
kdx = linspace(0, pi, N);

for j = 2:1:length(coefs_fa1)
	somme = somme + 2*coefs_fa1(j)* cos(kdx*(j-1)); 
end

Dk1 = coefs_fa1(1) + somme;

figure(1)
plot(kdx,Dk1, 'Linewidth',3)
xlabel('k \Delta x','fontsize',17);
ylabel('Fonction de dissipation normalisée','fontsize',17);
set(gca, 'FontSize',15)

% Cas du filtrage de capture de chocs


c1 = -0.210383;
c2 =  0.039617;

%j=0, j=1
c0 = -c1; 

%j=-1, j=2
cm1 = -c2;
coefs_cc1 = [cm1; c0; c1; c2];

Dk2r = -2*c1 + 2 * (c1-c2)*cos(kdx) + 2*c2*cos(2*kdx);

hold on
plot(kdx, Dk2r,'r','Linewidth',3)
set(gca, 'FontSize',15)
leg = legend('filtrage adaptatif','capture de choc','Location','northwest');
m = findobj(leg,'type','line');
legend('boxoff')
set(m,'linewidth',3)

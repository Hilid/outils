clear all
close all


% premier indice de chaques ligne de la matrice entre 0 et 1 pour savoir ou on se situe sur la colormap
% deuxième indice entre 0 et 1 pour savoir combien il y a de rouge/vert/bleu 
% Exemple pour une colormap map bleu-blanc-rouge (le blanc est le mélange des 2 couleurs)

 MR=[0,0;     % Pas de rouge au debut
    0.5,1;    % Du rouge au milieu
    1,1];     % Du rouge a la fin

MG=[0,0;      % Pas de vert au début
    0.5,1;    % Du vert au milieu
    1,0];     % Pas de vert à la fin

MB=[0,1;      % Du bleu au debut
    0.5,1;    % Du bleu au milieu
    1,0];     % Pas de bleu à la fin

% Interpolation linéaire des points manquants avec la fonction dédiée
colormapmaison = colormapRGBmatrices(512,MR,MG,MB);
    
N = 256;

	% On trace des pics aléatoires
	figure(1)
	subplot(1,2,1);
	pcolor(peaks(N));
    
	shading flat 
    	set(gca,'fontsize',15);
        axis('image');
   
    
	colormap(colormapmaison)
	colorbar()
	

	yl1 = xlabel('Y en m');
	xl1 =ylabel('X en m');

	subplot(1,2,2)
	surf(peaks(N))

	shading flat 

	%-------------gestion affichage en général------
	 set([xl1  yl1], 'fontsize',15);

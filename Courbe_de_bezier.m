function []= Courbe_de_bezier()

resolution=20;       %nombre de points evalues sur la courbe de Bezier
K=0;              %variable d'etat
%a=2; b=4;
matrice = [0,0]; 
curve = [0,0];   %ensemble des points de controle

while K~=4 %arreter
   K=menu('Que voulez-vous faire ?','Partir de zero', 'Superposer une autre courbe','changer les parametres des derniers points','ARRETER');
   methode_interpolation=menu('Quelle Methode souhaitez-vous utiliser ?', 'Hermite', 'Lagrange');
   methode_tangente = 0
   c = 0
   if methode_interpolation == 1
        methode_tangente = menu('Comment choisir les tangentes ?', 'Estimation personnelle', 'Cardinal Spline')
		if methode_tangente = 2 
            ask_c =  inputdlg({'Valeur de c ?'});
            c = str2num(ask_c{1});
        end
   end
   figure(1)
   if K==1
    clf;                  %affichage d'une fenetre vide
   end
   hold on;              %tous les plot seront executes sur cette meme fenetre
   axis([0 10 0 10])    %les axes sont definitivement fixes
   axis on;
   if K~=3
       %Points de controle
       matrice_pk = [0,0];
       annotation('textbox', [0.35 0.9 .1 .1], 'String', 'Entrer les points', 'Fontsize', 12, ...
           'FitBoxToText', 'on', 'Tag', 'EntrerPC');
       for i=1:999         %on limite le nombre de points de controle a 1000
          [X,Y]=ginput(1);  %prise en compte d'un clic de souris
          if isempty(X)     %si on appuie sur <ENTER>
             break
          end
          matrice_pk(1,i)=X;   %coordonnees x des points de controle
          matrice_pk(2,i)=Y;   %coordonnees y des points de controle
          figure(1);
          plot(matrice_pk(1,i),matrice_pk(2,i),'o') %affichage du point de controle i
       end
       plot(matrice_pk(1,:),matrice_pk(2,:),'b') %affichage du polygone de controle
   end

   if methode_tangente~=0
       %Tangentes
       %tangentes internes
       if methode_tangente==1 %new   
		 matrice_mk = estimation(matrice_pk)           
       end 
       if methode_tangente==2
         matrice_mk = cardinal_spline(matrice_pk,c)
       end

       delete(findall(gcf,'Tag','EntrerPC'));
       annotation('textbox', [0.35 0.9 .1 .1], 'String', 'Entrer les tangentes', 'Fontsize', 12, ...
               'FitBoxToText', 'on', 'Tag', 'EntrerT');
        if K~=3
           %tangentes extermes donnees par user
           %premiere tangente
           [X,Y]=ginput(1);
           matrice_mk(1,1)= - (X - matrice_pk(1,1));
           matrice_mk(2,1) = -(Y - matrice_pk(2,1));
           plot(- matrice_mk(1,1) + matrice_pk(1,1),- matrice_mk(2,1) + matrice_pk(2,1),'x') %affichage du point extreme de tangente 1
           %affichage de la premiere tangente
           tangente_extremite = [[X;Y],matrice_pk(:,1)];
           plot(tangente_extremite(1,1:2),tangente_extremite(2,1:2),'r--');      
           %derniere tangente
           [X,Y]=ginput(1);
           nbpoints = size(matrice_pk, 2);
           matrice_mk(1,nbpoints)= (X - matrice_pk(1,nbpoints));
           matrice_mk(2,nbpoints) = (Y - matrice_pk(2,nbpoints));
           plot(matrice_mk(1,nbpoints) + matrice_pk(1,nbpoints), matrice_mk(2,nbpoints) + matrice_pk(2,nbpoints),'x') %affichage du extreme de tangente 1
           %affichage de la derniere tangente
           tangente_extremite = [[X;Y],matrice_pk(:,nbpoints)];
           plot(tangente_extremite(1,1:2),tangente_extremite(2,1:2),'r--');
           delete(findall(gcf,'Tag','EntrerT'))
        end
   end
   
   resultat_interpolation = [];
   for i=1:nbpoints-1
     %resultat_interpolation stock tous les points d'interpolation
     if methode_interpolation = 1
		 matrice_pk(:,i:i+1);
		 matrice_mk(:,i:i+1);
		 bk = hermite(matrice_pk(:,i:i+1),matrice_mk(:,i:i+1));
		 interpolation_hermite_morceau = interpolation_hermite(bk,resolution);
         resultat_interpolation = [resultat_interpolation interpolation_hermite_morceau];
	 end
	 if methode_interpolation = 2
        resultat_interpolation = lagrange(matrice_pk, resolution);
	 end
     plot(resultat_interpolation(1,:), resultat_interpolation(2,:),'r');
   end
      
   
   if K==7 %interpolation de Lagrange (a metre juste au dessus dans le cas methode_interpolation = 2
       
       couleur = inputdlg({'Couleur du tracé ? (r,m,c,b,g,y,k)'});
       
       for t=1:resolution
           Pk = aitken(matrice_pk,t);
           plot(Pk(1,t));
           plot(Pk(2,t));
           x(1,t) =  Pk(1,t);
           y(1,t) =  Pk(2,t);
       end
       
       %courbure 
       for i = 2:size(x,2)-1
          xmoins = x(i) - x(i-1);
          xplus = x(i+1) - x(i);
          ymoins = y(i) - y(i-1);
          yplus = y(i+1) - y(i);
          xdist = x(i-1) - x(i+1);
          ydist = y(i-1) - y(i+1);
          curve(i) = 2*(xmoins*yplus - xplus*ymoins);
          curve(i) = curve(i) / sqrt((xmoins^2 + ymoins^2)*(xplus^2 + yplus^2)*(xdist^2 + ydist^2));
       end
       curve(1) = curve(2);
       curve(size(x,2)) = curve(size(x,2)-1);
       figure(2)
       plot(curve, couleur{1});
   
   end 
  end
  close 
end

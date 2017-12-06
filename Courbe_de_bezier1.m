function []= Courbe_de_bezier()

resolution=20;       %nombre de points evalues sur la courbe de Bezier
K=0;              %variable d'etat
%a=2; b=4;
matrice = [0,0]; 
curve = [0,0];   %ensemble des points de controle

while K~=4 %arreter
   K=menu('Que voulez-vous faire ?','NEW -cardinal splines-  (bouton souris, puis <ENTER>', 'NEW -notre calcul des tangentes-',...
           'NEW -interpolation de Lagrange','Superposer une autre courbe','ARRETER');
   figure(1)
   clf;                  %affichage d'une fenetre vide
   hold on;              %tous les plot seront executes sur cette meme fenetre
   axis([0 10 0 10])    %les axes sont definitivement fixes
   axis off 

   c_couleur = inputdlg({'Valeur de c ?', 'Couleur du tracé ? (r,m,c,b,g,y,k)'});
   c=str2num(c_couleur{1});

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

  %Tangentes
   %tangentes internes
   if K==1 %new   
      matrice_mk = cardinal_spline(matrice_pk,c)    
   end 
   if K==2
       matrice_mk = estimation(matrice_pk)
   end
   
   delete(findall(gcf,'Tag','EntrerPC'));
   annotation('textbox', [0.35 0.9 .1 .1], 'String', 'Entrer les tangentes', 'Fontsize', 12, ...
           'FitBoxToText', 'on', 'Tag', 'EntrerT');
   if K==1|K==2
       
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
       plot(- matrice_mk(1,nbpoints) + matrice_pk(1,nbpoints), - matrice_mk(2,nbpoints) + matrice_pk(2,nbpoints),'x') %affichage du extreme de tangente 1
       %affichage de la derniere tangente
       tangente_extremite = [[X;Y],matrice_pk(:,nbpoints)];
       plot(tangente_extremite(1,1:2),tangente_extremite(2,1:2),'r--');
       delete(findall(gcf,'Tag','EntrerT'))

       bk = hermite(matrice_pk(:,1:2),matrice_mk(:,1:2));
       interpolation_hermite_morceau = interpolation_hermite(bk,resolution);
       points = interpolation_hermite_morceau;
       plot(interpolation_hermite_morceau(1,:),interpolation_hermite_morceau(2,:),'r');
       for i=2:nbpoints-1
         matrice_pk(:,i:i+1);
         matrice_mk(:,i:i+1);
         bk = hermite(matrice_pk(:,i:i+1),matrice_mk(:,i:i+1));
         interpolation_hermite_morceau = interpolation_hermite(bk,resolution);
         append(points, interpolation_hermite_morceau);
         plot(interpolation_hermite_morceau(1,:),interpolation_hermite_morceau(2,:),'r');
       end

       %courbure
       x = points(1,:);
       y = points(2,:);
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
       plot(curve, c_couleur{2});
   end
   
   if K==3 %interpolation de Lagrange
       
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
   
   
   if K==4 %ajouter une courbe
      L = menu('Quelle courbe voulez-cous superposer?','Spline Hermite avec cardinal splines', 'Spline hermite avec notre methode', 'interpolation de Lagrange');
      if L==1 | L==2
          c_couleur = inputdlg({'Valeur de c ?', 'Couleur du tracé ?(r,m,c,b,g,y,k)'});
          c=str2num(c_couleur{1});
          if L==1
            Hermite_points = hermite(matrice, c, 0, resolution);
          end
          if L==2
            Hermite_points = hermite(matrice, c, 1, resolution); 
          end
          figure(1)
          plot(Hermite_points(1,:), Hermite_points(2,:), c_couleur{2});
          x = Hermite_points(1,:)
          y = Hermite_points(2,:)
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
          plot(curve, c_couleur{2});
      end
   end
  end
 close 
end

function []= Courbe_de_bezier()

resolution=21;       //nombre de points evalues sur la courbe de Bezier
a=2;b=4;	     //domaine des parametres
K=0;                 //variable d'etat
matrice=0;           //ensemble des points de controle

while K~=4 //arreter
   K=uimenu('Que voulez-vous faire ?','NEW -cardinal splines-  (bouton souris, puis <ENTER>', 'NEW -autre calcul des tangentes','Superposer une autre courbe','ARRETER');
   if K==1 //new
      figure(1)
      clf;                  //affichage d'une fenetre vide
      hold on;              //tous les plot seront executes sur cette meme fenetre
      axis([0 10 0 10])    //les axes sont definitivement fixes
      axis off
      matrice=0;
      c_couleur = inputdlg({'Valeur de c ?', 'Couleur du tracé ? (r,m,c,b,g,y,k)'});
      c=str2num(c_couleur{1});
      //Points de controle
      for i=2:999         //on limite le nombre de points de controle � 1000
         [X,Y]=ginput(1);  //prise en compte d'un clic de souris
         if isempty(X)     //si on appuie sur <ENTER>
            break
         end
         matrice(1,i)=X;   //coordonnees x des points de controle
         matrice(2,i)=Y;   //coordonnees y des points de controle
         figure(1);
	     plot(matrice(1,i),matrice(2,i),'o') //affichage du point de controle i
         plot(matrice(1,:),matrice(2,:),'b') //affichage du polygone de controle
      end
      
      //Tangentes
      delete(findall(gcf,'Tag','EntrerPC'));
      //annotation('textbox', [0.35 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           //'String', 'Entrer les tangentes', 'Tag', 'EntrerTG');
      [X,Y]=ginput(1);
      matrice(1,1)=X;
      matrice(2,1)=Y;
	  plot(matrice(1,1),matrice(2,1),'x') //affichage du point 1
      plot(matrice(1,1:2),matrice(2,1:2),'r--') //affichage de la premiere tangente
      [X,Y]=ginput(1);
      nbpoints = size(matrice, 2)+1;
      matrice(1,nbpoints) = X;
      matrice(2,nbpoints) = Y;
	  plot(matrice(1,nbpoints),matrice(2,nbpoints),'x') //affichage du point 2
      plot(matrice(1,nbpoints-1:nbpoints),matrice(2,nbpoints-1:nbpoints),'r--') //affichage de la deuxieme tangente
      delete(findall(gcf,'Tag','EntrerTG'))
      
      hermite_points = hermite(matrice,c, 0, resolution);
      figure(1)
      plot(hermite_points(1,:), hermite_points(2,:), answer{2})
       
    elseif K==2 //Notre calcul des tangentes
      couleur=inputdlg({'Couleur du tracé ? (r,m,c,b,g,y,k)'});
      c=0;
      figure(1)
      clf                  
      hold on              
      axis([0 10 0 10])    
      axis off
      matrice=0;
      
      //Points de controle
      //annotation('textbox', [0.3 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           //'String', 'Entrer les points de controle', 'Tag', 'EntrerPC');
      for i = 2:999         
         [X,Y] = ginput(1);  
         if isempty(X)     
            break
         end
      matrice(1,i) = X;
      matrice(2,i) = Y;
      figure(1)
	  plot(matrice(1,i),matrice(2,i),'o') //affichage du point de controle i
      plot(matrice(1,2:i),matrice(2,2:i),'b') //affichage du polygone de controle
      end
  
  
      //Tangentes
      delete(findall(gcf,'Tag','EntrerPC'));
      //annotation('textbox', [0.35 0.9 .1 .1], 'FitHeightToText', 'ON', 'Fontsize', 12, ...
           //'String', 'Entrer les tangentes', 'Tag', 'EntrerTG');
      [X,Y] = ginput(1);
      matrice(1,1) = X;
      matrice(2,1) = Y;
	  plot(matrice(1,1),matrice(2,1),'x') //affichage du point 1
      plot(matrice(1,1:2),matrice(2,1:2),'r--') //affichage de la premiere tangente
      [X,Y] = ginput(1);
      nbpoints = size(matrice, 2)+1;
      matrice(1,nbpoints)=X;
      matrice(2,nbpoints)=Y;
	  plot(matrice(1,nbpoints),matrice(2,nbpoints),'x') //affichage du point 2
      plot(matrice(1,nbpoints-1:nbpoints),matrice(2,nbpoints-1:nbpoints),'r--') //affichage de la deuxieme tangente
      
      delete(findall(gcf,'Tag','EntrerTG'))
       
      hermite_points = hermite(matrice, c, 1, resolution);
      figure(1)
      plot(hermite_points(1,:), hermite_points(2,:), couleur{1})
      
      elseif K==3 //ajouter une courbe
      c_couleur = inputdlg({'Valeur de c ?', 'Couleur du tracé ?(r,m,c,b,g,y,k)'});
      c=str2num(c_couleur{1});
      hermite_points = hermite(matrice, c, 0, resolution);
      figure(1)
      plot(hermite_points(1,:), hermite_points(2,:), c_couleur{2});
      x = hermite_points(1,:)
      y = hermite_points(2,:)
      end
  end
  
end
close

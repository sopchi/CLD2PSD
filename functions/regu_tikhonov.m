function delta_min = regu_tikhonov(K,q,psi_exacte,part_size,d1,d2)

    
    
    delta = logspace(d1,d2,100) ;
    
    
    
    [U,S,V] = svd(K) ;
    
    %Il faut boucler sur delta calculer l'erreur à chaque fois
    
    i=0 ;
    liste_erreur = zeros(1,length(delta)) ;
    hold on
    while i <= length(delta)-1
        i=i+1 
        
        %on ajuste la matrice M
        [ligne,colonne]=size(S) ;
        mat_delt=delta(i)^2*eye(ligne) ;
        mat_cut=mat_delt(:,1:length(part_size)) ;
        M = S.*S + mat_cut ;
        diagM = diag(M) ;
        diagS = diag(S) ;
        diagS_f = diagS./diagM ;
        diagS_f = cat(1,diagS_f,zeros(ligne-length(diagS_f),1));
        square_S_f = diag(diagS_f);
        S_f = square_S_f(:,1:length(part_size))' ;
        psi_r = V*S_f*U'*q ;
        erreur = norm((psi_exacte-psi_r)./mean(psi_exacte)) ; %cette norme permet de ne pas avoir de soucis de division par zéro
        psi_regu = psi_r ;
        
        liste_erreur(i) = erreur ;
        %{
        x_axis = part_size ;
        y_axis_regu = psi_regu ;
        y_axis_exacte = psi_exacte ;
        %On trace les courbes régularisées pour 3 valeurs de delta
        if i==2 
            figure(1); plot(x_axis,y_axis_regu,'-o')
        elseif i==length(delta)/2
            figure(1); plot(x_axis,y_axis_regu,'-*')
        elseif i==(length(delta)-1)
            figure(1); plot(x_axis,y_axis_regu, '-+')
        
        end
        xlabel('r')
        ylabel('count')
        %}
    end
    %{
    legend('1','2','3')
    
    %Graphe de l'erreur

    figure(2); plot(delta,liste_erreur) ;
    xlabel('delta') ;
    ylabel('erreur')
    title('Estimation de l erreur en fonction de delta' )
    

    %on trace la distribution exacte pour comparer

    figure(3) ; plot(x_axis,y_axis_exacte,'b')
    hold off
    %On détermine le delta minimal
%}
    [erreur_min,idx]=min(liste_erreur) ;
    idx
    erreur_min
    delta_min = delta(idx)
    
    
    
    
    %{
    %graphe de comparaison entre la PSD connue et la PSD régularisée
    
    %{
    x_axis = part_size ;
    y_axis_regu = psi_regu_finale ;
    y_axis_exacte = psi_exacte ;
    figure(1); plot(x_axis,y_axis_regu,'g',x_axis,y_axis_exacte,'b')
    xlabel('r')
    ylabel('count')
    title('Comparaison entre les distributions exacte et régularisée')
    legend("regularisation","exacte")
    
    %}
    %}
    
    
end
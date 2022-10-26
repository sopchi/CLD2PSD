function [mat, vecteur, Q ]= calculQ_deuxpart(K1,psi1,K2,psi2,alpha)

    %concaténer les matrices
    
    mat= [alpha*K1 (1-alpha)*K2] ;
    
    %concaténer les vecteurs
    
    vecteur = [psi1 psi2]' ;
    
    %calcul de la distribution en longueur de cordes
    
    Q = mat * vecteur
end
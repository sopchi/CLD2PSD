function psi_r = calcul_psi(K,q,delta,part_size)                              
    
    [U,S,V] = svd(K) ;
    [ligne,colonne]=size(S) ;
    mat_delt=delta*eye(ligne) ;
    mat_cut=mat_delt(:,1:length(part_size)) ;
    M = S.*S + mat_cut ;
    diagM = diag(M) ;
    diagS = diag(S) ;
    diagS_f = diagS./diagM ;
    diagS_f = cat(1,diagS_f,zeros(ligne-length(diagS_f),1));
    square_S_f = diag(diagS_f);
    S_f = square_S_f(:,1:length(part_size))' ;
    psi_r = V*S_f*U'*q 

end
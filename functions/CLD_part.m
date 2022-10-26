function chord = CLD_part(a,b,c,r,random_shape) 
%% initial form
if random_shape == true
    [X,Y,Z]= random_particule();
    s_ini = surf(X*r,Y*r,Z*r); % growth factor r 
else
    [X,Y,Z] = ellipsoid(0,0,0,a,b,c);% parameters
    s_ini = surf(X*r,Y*r,Z*r); % growth factor r 
end

%% rotation 
N=100; % number of rotation
direction_y = [0 1 0];
theta= 2*pi.*rand(N,1);
direction_z = [0 0 1];
phi=acos(1-2*rand(N,1));

nb_face = size(X);
chord=[];


for i = 1:N  
    s1 = s_ini;
    rotate(s1,direction_y,(180/pi)*theta(i));
    rotate(s1,direction_z,(180/pi)*phi(i));
    X = s1.XData;
    Y = s1.YData;

    %% projection
    Z = zeros(nb_face(2),nb_face(2));

    %% env convexe 
    X_bis = reshape(X, 1, []);%nb_face(2)^2);
    Y_bis = reshape(Y, 1, []);%nb_face(2)^2);
    [k,av]= convhull(X_bis,Y_bis);

    X_env = X_bis(1,k);
    Y_env = Y_bis(1,k);
    
    %% random chord
    y_min = min(Y_env);
    y_max = max(Y_env);

    d = y_min + (y_max - y_min)*rand();

    dim= size(Y_env);
    nb = dim(2);
    x2 = linspace(min(X_env),max(X_env),nb);
    y2 = d(1)*ones(1,nb);
    [x,y]=curveintersect(X_env,Y_env,x2,y2);
    chord = [chord,abs(x(1) - x(2))];
    
end

end

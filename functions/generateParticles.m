function [particles1,particles2] = generateParticles(type1num, type2num,parameters)
    %%% This function returns "type1num" particles of Type 1 and
    %%% "type2num" particules of Type 2
    %%%
    %%% Type 1 particles : like ellipsoids 
    %%% Type 2 particles : like needles
    %%% 
    %%% output : 3-dimensional arrays containing the 3D coordinates of each
    %%%         point and for each object
    
    width = parameters(1);
    numberOfPoints = parameters(2);
    rotationsNumber = parameters(3);
    rotationAxis = parameters(4) ; 
   
    %% Create type 1 objects
    type1_Objects = zeros(3,numberOfPoints*rotationsNumber,type1num);
    for i = 1:type1num
        height_i = 50 + 50*rand(); % height in [50,100] interval
        curve2D_i = createParabole(height_i,width,numberOfPoints);
        curve3D_i = rotateCurve(curve2D_i,rotationsNumber,rotationAxis);
        type1_Objects(:,:,i) =  curve3D_i;
    end

    %% Create type 2 objects
    type2_Objects = zeros(3,numberOfPoints*rotationsNumber,type2num);
    for i = 1:type2num
        height_i = 1 + 9*rand(); % height in [1,10] interval
        curve2D_i = createParabole(height_i,width,numberOfPoints);
        curve3D_i = rotateCurve(curve2D_i,rotationsNumber,rotationAxis);
        type2_Objects(:,:,i) =  curve3D_i;
    end

    particles1 = type1_Objects; 
    particles2 = type2_Objects;

end
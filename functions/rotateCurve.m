function curve3D = rotateCurve(curve2D,rotationsNumber,axisnum)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% This function computes the result of the rotation of a 2D curve around a specified axis 
    %%% 
    %%% 
    %%% Inputs : 
    %%%     - curve2D : is the 2D-object from which the 3D will be created.
    %%%         It is an array of the form [x ; y] where x and y are
    %%%         both line vectors.
    %%%     - rotationsNumber : anthe number of rotations done to make a
    %%%         complete circle
    %%%     - axisnum is an int to specify the axis around which we
    %%%         rotation is done
    %%%             1 : rotation around x-axis
    %%%             2 : rotation around y-axis
    %%%             3 : rotation around z-axis
    %%% Outputs :
    %%%        - The matrix [X;Y;Z] of the coordinates of the 3D object
    %%%        where X, Y, Z are line vectors
    %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% Test inputs
    if size(curve2D,1) ~= 2
        error("The input array has not the right dimensions")
    end

    if ~(ismember(axisnum,[1,2,3]))
        error("The axis number is not valid (must be 1, 2 or 3)")
    end

    %% Extraction of values
    X = curve2D(1,:); % extract X values
    Y = curve2D(2,:); % extract Y values
    Numel = length(X); % number of elements
    Z = zeros(1,Numel);
    
    % Initialize 3D curve object
    curve3D = zeros(3,Numel*rotationsNumber); 
    
    curve3D(:,1:Numel) = [X ; 
                          Y ;
                          Z]; % First fill of the 3D curve
    
    % Rotation parameters
    alpha = 2*pi/rotationsNumber ;
    if axisnum == 1
        rotationMatrix = [ 1  0           0 
                           0  cos(alpha) -sin(alpha);
                           0  sin(alpha)  cos(alpha)];
    elseif axisnum == 2 % rotation around y-axis
        rotationMatrix = [ cos(alpha)  0     sin(alpha); 
                           0           1     0;
                           -sin(alpha) 0     cos(alpha)];
    else  % rotation around z-axis
        rotationMatrix = [ cos(alpha) -sin(alpha) 0 ;
                           sin(alpha)  cos(alpha) 0 ;
                           0           0          1];  
    end
    
    %% Applying rotation
    for i = 1:Numel
        currentPoint = [X(i);Y(i);Z(i)];
        for j = 1:rotationsNumber
            % Apply rotation to current vector and updating it
            currentPoint = rotationMatrix*currentPoint;
            
            % Updating matrix values
            curve3D(:,(i-1)*rotationsNumber+j) = currentPoint;
        end
    end
end
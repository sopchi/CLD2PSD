function output = params()
    width = 100;
    numberOfPoints = 100 ; % Number of points for the 2D-curve
    rotationsNumbers = 20 ; % Number of rotations to make a complete circle
    rotationAxis = 1 ; % For rotation around x-axis. Set 2 (resp. 3) for y-axis (resp z-axis) 
    output = [width,numberOfPoints,rotationsNumbers, rotationAxis];
end

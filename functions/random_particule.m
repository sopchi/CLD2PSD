function [X,Y,Z]= random_particule()
PointsRange = 10;
width = 50;
numberOfPoints = 5;
precision = 0.2;
Points = width*rand(2,numberOfPoints); % generate points in [0;100]

%% Create the interpolated curve
x_values = min(Points(1,:)):precision:max(Points(1,:));
y_values = spline(Points(1,:),Points(2,:),x_values);

%% Creation of 3D form
particle = rotateCurve([x_values; y_values],100,1);

%% Creating the convex hull of the 3D-shape
pointsToInterpolate = [particle(1,:)' particle(2,:)' particle(3,:)'];
conv = convhull(pointsToInterpolate);

%% Put the X,Y and Z data compatible with surf function
% We need to have X, Y and Z data shaped like matrixes (and not vectors) to
% be compatible with surf or mesh functions

% But we can't forsee the number of elements of 'conv' object. But we empirically know
% it is always an even number. 

% We therefore change the vector of size numel(conv), into a 2-by-numel(conv)/2] matrix,

X = reshape(pointsToInterpolate(conv,1),2,numel(conv)/2) ;
Y = reshape(pointsToInterpolate(conv,2),2,numel(conv)/2) ;
Z = reshape(pointsToInterpolate(conv,3),2,numel(conv)/2) ;

end

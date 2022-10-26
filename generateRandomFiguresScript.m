%%% This script creates random 3D forms obtained with randomly generated
%%% points interpolated with a spline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

%% Generate random points
PointsRange = 10;
width = 100;
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

X_convex = reshape(pointsToInterpolate(conv,1),2,numel(conv)/2) ;
Y_convex = reshape(pointsToInterpolate(conv,2),2,numel(conv)/2) ;
Z_convex = reshape(pointsToInterpolate(conv,3),2,numel(conv)/2) ;


%% Plots
% Generated points and 2D-line
figure
subplot(3,1,1)
plot(Points(1,:),Points(2,:),'o', x_values',y_values')
legend('Randomly Generated points','Interpolated curve')
title('Randomly generated curve')

% The rotation of the line around x-axis
subplot(3,1,2)
plot3(particle(1,:),particle(2,:),particle(3,:))
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
title('Rotation of the curve around x-axis')

% The convex hull
subplot(3,1,3)
surf(X_convex, Y_convex,Z_convex);
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
title('Convex hull of the 3D-object')






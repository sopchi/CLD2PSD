%%% This script creates 3D forms obtained by a rotation of a parabola
%%% around an axis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear ;
close all;
clc 

addpath('Functions')
parameters = params(); % parameters for the simulation
numberOfPoints = parameters(2);
rotationsNumber = parameters(3);

%% generate objects
type1num = 1;
type2num = 1;

[particles1,particles2] = generateParticles(type1num,type2num,parameters);

%% Set objects into good format
particles1_otherFormat = zeros(numberOfPoints,rotationsNumber,3,type1num);
particles2_otherFormat = zeros(numberOfPoints,rotationsNumber,3,type2num);

% The goal here is to set the particles in the good format so that it is
% compatible with surf or mesh functions

for i=1:type1num % We first loop on the differents particules
    for j=1:3 % Then on coordinates (X, Y or Z)
        particles1_otherFormat(:,:,j,i) = reshape(particles1(j,:),[numberOfPoints rotationsNumber]);
    end
end

% Same loop for type 2 particles
for i=1:type2num 
    for j=1:3
        particles2_otherFormat(:,:,j,i) = reshape(particles2(j,:),[numberOfPoints rotationsNumber]);
    end
end

%% Plots
surf(particles1_otherFormat(:,:,1),particles1_otherFormat(:,:,2),particles1_otherFormat(:,:,3))
axis equal
title('Rounded particle')

figure
surf(particles2_otherFormat(:,:,1),particles2_otherFormat(:,:,2),particles2_otherFormat(:,:,3))
axis equal
title('Elongated particle')

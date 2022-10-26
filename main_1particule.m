clear ;
close all;
clc 

addpath('Functions')

%% Parameters
m = 20; % number of columns of K 
% PSD 
mu_1 = 5;
sigma_1 = 1;
% particule size
part_min = 1;
part_max=20;
part_size = part_min:(part_max-part_min)/(m-1):part_max;
%% Creating particles distributions
distrib_part_1 = [];
for x = part_size
    distrib_part_1 = [ distrib_part_1, normcdf(x+1,mu_1,sigma_1) - normcdf(x-1,mu_1,sigma_1)];
end
% Normalization
distrib_part_1 = distrib_part_1/sum(distrib_part_1);
%% Ellipsoids parameters
% Form = [length in x-axis, length in y-axis, length in z-axis ]
form_1 = [1 1 1];
method = "random" % random for random form generation

%% Parameters for histogram 
n = 100; % number of rows of K
max_form_1 = max(form_1);
chord_size_1= 0 : max_form_1*2*part_max/(n-1) : part_max*2*max_form_1;
%% Compute K1 et K2
K1 = get_K(part_size,form_1, n, method);
q1 = K1*distrib_part_1.';
%{
pert = rand(n,1).*q1;
epsilon=0.0005;
q1=  q1 + epsilon*pert;
%}
psi1 = distrib_part_1;
d1= -7;
d2 = 0;
delta_min = regu_tikhonov(K1,q1,psi1,part_size,d1,d2);
psi_r = calcul_psi(K1,q1,delta_min,part_size); % global recovered PSD

part_histo=repelem(part_size,abs(floor(psi_r*1000)))/10;
part_histo_ex=repelem(part_size,abs(floor(distrib_part_1*1000)))/10;
part_repartition=[distrib_part_1(1)];
for j = 2:m
    part_repartition = [part_repartition, part_repartition(j-1)+psi_r(j)];
end
figure(3)
plot(part_size,part_repartition,'LineWidth',2)
title('Fonction de repartition de la PSD reconstruite')

figure(4)
histogram(part_histo*10)
hold on
 x = [0:.1:20];
y = normpdf(x,5,1)*1000;
plot(x,y,'LineWidth',2)
legend('Histogramme de la PSD recontruite','Densité de la PSD théorique')
title('Densité de la PSD reconstruite')
hold off

q_histo=repelem(chord_size_1,floor(q1*1000))%/10;
q_repartition = [q1(1)];
for l = 2:n
    q_repartition = [ q_repartition ,q_repartition(l-1) + q1(l)];
end
figure(5)
plot(chord_size_1,q_repartition,'LineWidth',2,'color','g')
title('Fonction de repartition de la CLD')
figure(2)
histogram(q_histo,'facecolor','g')
title('Histogramme de la CLD générée')
close all
addpath('Functions')
%% Parameters
m = 20; % number of columns of K 
% PSD 
mu_1 = 5;
sigma_1 = 1;
mu_2 = 8;
sigma_2 = 1;
% particule size
part_min = 1;
part_max=20;
part_size = part_min:(part_max-part_min)/(m-1):part_max;

%% Creating particles distributions
distrib_part_1 = [];
distrib_part_2 = [];

for x = part_size
    distrib_part_1 = [ distrib_part_1, normcdf(x+1,mu_1,sigma_1) - normcdf(x-1,mu_1,sigma_1)];
    distrib_part_2 = [ distrib_part_2, normcdf(x+1,mu_2,sigma_2) - normcdf(x-1,mu_2,sigma_2)];
end
% Normalization
distrib_part_1 = distrib_part_1/sum(distrib_part_1);
distrib_part_2 = distrib_part_2/sum(distrib_part_2);

%% Ellipsoids parameters
% Form = [length in x-axis, length in y-axis, length in z-axis ]
form_1 = [1 1 1];
form_2 = [1 1 0.9];
method = "ellipse"; % random for random form generation

%% Parameters for histogram 
n = 200; % number of rows of K
max_form_1 = max(form_1);
max_form_2 = max(form_2);
chord_size_1= 0 : max_form_1*2*part_max/(n-1) : part_max*2*max_form_1;
chord_size_2= 0 : max_form_2*2*part_max/(n-1) : part_max*2*max_form_2;

%% Compute K1 et K2
K1 = get_K(part_size,form_1, n,method);
K2= get_K(part_size,form_2, n,method);


%% Compute CLD and PSD
%q = K*distrib_part.';
% compute CLD 
q1 = K1*distrib_part_1.';
q2 = K2*distrib_part_2.';

% Compute theoritical PSD
psi1 = distrib_part_1;
psi2 = distrib_part_2;
part_size_1 = part_size;
part_size_2 = part_size;

alpha = 0.5; % proportion of each form 

% range for delta
d1= -7;
d2 = 0;



[K, psi_exacte, q] = calculQ_deuxpart(K1,psi1,K2,psi2,alpha);

% perturbation for q 
pert = rand(n,1).*q;
epsilon=0;
q_pert=  q + epsilon*pert;

part_size_2part = [part_size_1 part_size_2] ;
delta_min = regu_tikhonov(K,q_pert,psi_exacte,part_size_2part,d1,d2);
psi_r = calcul_psi(K,q_pert,delta_min,part_size_2part); % global recovered PSD

L=length(psi_r);
psi_r_1 = psi_r(1:L/2);
psi_r_2 = psi_r(L/2+1:L);

distrib_part = [distrib_part_1 distrib_part_2];

%% plots 

part_histo=repelem(part_size_2part,abs(floor(psi_r*1000)))/10;
part_histo_ex=repelem(part_size_2part,abs(floor(distrib_part*1000)))/10;
part_histo_ex2= repelem(part_size, abs(floor(distrib_part_2*1000)))/10;
part_histo_ex1= repelem(part_size, abs(floor(distrib_part_1*1000)))/10;
part_histo_1 = repelem(part_size, abs(floor(psi_r_1*1000)))/10;
part_histo_2 = repelem(part_size, abs(floor(psi_r_2*1000)))/10;

% recovered PSD
figure(22)
h=histogram(part_histo_1*10)
set(h(1),'facecolor','#E63946 ')
 %set(gcf, 'color', 'none');
 %set(gca, 'color', 'none')
hold on 
x = [0:.1:20];
y = normpdf(x,5,1)*1000;
plot(x,y, 'LineWidth',2,'color',[211/255 99/255 109/255 ])
h2=histogram(part_histo_2*10)
set(h2(1),'facecolor','#457B9D')
 %set(gcf, 'color', 'none');
 %set(gca, 'color', 'none');
 x = [0:.1:20];
y = normpdf(x,8,1)*1000;
plot(x,y,'LineWidth',2, 'color',[69/255 123/255 157/255 ])
title('PSD initiales et reconstruites')
legend('histogramme de la forme 1', 'PSD théorique de la forme 1','histogramme de la forme 2', 'PSD théorique de la forme 2')
hold off

% Theoretical PSD
figure(15)
h2= histogram(part_histo_ex2)
set(h2(1),'facecolor','#457B9D')
hold on 
h=histogram(part_histo_ex1)
set(h(1),'facecolor','#A4383B ')
hold off


% CLD
chord_size=[chord_size_1 chord_size_2];

q_histo=repelem(chord_size_1,floor(q*1000))%/10;
q_histo1=repelem(chord_size_1,floor(q1*1000))%/10;
q_histo2=repelem(chord_size_1,floor(q2*1000))%/10;

% global CLD
figure(12)
h=histfit(q_histo,n,'kernel')
set(h(1),'facecolor','#FF0000' ); set(h(2),'color','m')

% global CLD with contributions of two forms
figure(11)
h=histogram(q_histo1)
set(h(1),'facecolor','#A4383B ' );% set(h(2),'color','#E63946')
 %set(gcf, 'color', 'none');
 %set(gca, 'color', 'none');
hold on
h2=histogram(q_histo2) 
set(h2(1),'facecolor',[29/255 53/255 87/255] )%; set(h2(2),'color',[69/255 123/255 157/255 ])%'#A8DADC')
 %set(gcf, 'color', 'none');
 %set(gca, 'color', 'none');
 title('Histogramme de la CLD de echantillon ')
hold off

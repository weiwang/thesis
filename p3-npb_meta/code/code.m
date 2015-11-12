% example from GPStuff tutorial 

lik = lik_gaussian('sigma2', 0.2^2);
gpcf = gpcf_sexp('lengthScale', [1.1 1.2], 'magnSigma2', 0.2^2)
pn=prior_logunif();
lik = lik_gaussian(lik, 'sigma2_prior', pn);
pl = prior_unif();
pm = prior_sqrtunif();
gpcf = gpcf_sexp(gpcf, 'lengthScale_prior', pl, 'magnSigma2_prior', pm);
gp = gp_set('lik', lik, 'cf', gpcf);

data=load('/Users/weiwang/GPstuff-4.6/gp/demodata/dat.1');

x = [data(:,1) data(:,2)];
y = data(:,3);
[n, nin] = size(x);


disp('MAP estimate for the parameters')
% Set the options for the optimization
opt=optimset('TolFun',1e-3,'TolX',1e-3);
% Optimize with the scaled conjugate gradient method
gp=gp_optim(gp,x,y,'opt',opt);

% get optimized parameter values for display
[w,s]=gp_pak(gp);
% display exp(w) and labels
disp(s), disp(exp(w))

% predict at new X's
[xt1, xt2] = meshgrid(-1.8:0.1:1.8, -1.8:0.1:1.8);
xt=[xt1(:),xt2(:)];
[Eft_map, arft_map] = gp_pred(gp, x, y, xt); 

%%%%%%%%%%%%%%%
%% real data %%
%%%%%%%%%%%%%%%
cd ~/Dropbox/Research/Thesis/p3-npb_meta/code/

%% prepare data
data=csvread('math1_8schools.csv', 1);
x = [data(:,3)  data(:,8) data(:,1) data(:,2) data(:,5) data(:,9)]; % trt, schoolid, gender, eth,  lunch, lunch_school
y = data(:,4); 
[n, nin] = size(x);
[xn,xmean,xstd]=normdata(x);
[yn,ymean,ystd]=normdata(y);
% Set the options for the optimization
opt=optimset('TolFun',1e-3,'TolX',1e-3);


%% set up gp model
% common categorical covariance for school
cc1=gpcf_cat('selectedVariables',1);
% nonlinear part for treatment
cc2=gpcf_cat('selectedVariables',4);
cfc=gpcf_constant('constSigma2',1,'constSigma2_prior',prior_t());
% own constant term for each school
cfci=gpcf_prod('cf',{cfc cc});
% nonlinear part with treatment, gender, eth, lunch
gpcf = gpcf_sexp('selectedVariables', [4 2 3 5], 'lengthScale', [1 1 1 1], 'magnSigma2', 0.2^2) % trt, gen, eth, lunch, lunch_rate
gpcf = gpcf_sexp(gpcf, 'lengthScale_prior', prior_t(), 'magnSigma2_prior', prior_t());
lik=lik_gaussian('sigma2',.1,'sigma2_prior',prior_sinvchi2('s2',0.01,'nu',1));

gp = gp_set('lik', lik, 'cf', {cc, cfc, gpcf});

%% alternative model
gpcf = gpcf_sexp('metric',metric_euclidean('components',{[1] [2] [3] [4] [5] [6]},...
                                        'deltadist', [1 1 0 0 0 0], ...
                                        'lengthScale_prior',prior_t())) % trt, schoolid, gen, eth, lunch, lunch_rate
lik=lik_gaussian('sigma2',.1,'sigma2_prior',prior_sinvchi2('s2',0.01,'nu',1));
gp = gp_set('lik', lik, 'cf', gpcf);

%% inference 
% Optimize with the scaled conjugate gradient method
gp=gp_optim(gp,xn,yn,'opt',opt);
% get optimized parameter values for display
[w,s]=gp_pak(gp);
% display exp(w) and labels
disp(s), disp(exp(w))

%% prepare xnew such as it is a matrix for all possible combinations of X
trt = unique(xn(:,1));
schoolid = unique(xn(:,2));
gender = unique(xn(:,3));
eth = unique(xn(:,4));
lunch = unique(xn(:,5));
[a, b, c, d ,e] = ndgrid(trt, schoolid, gender, eth, lunch)
xnew = [a(:) b(:) c(:) d(:) e(:)]
sid = unique(xn(:, [2, 6]), 'rows')
[~,ii] = ismember(xnew(:,2),sid(:,1));
xnew = [xnew, sid(ii,2)];

[Ef, Varf]=gp_pred(gp,xn,yn,xnew);
grid_x = denormdata(xnew, xmean, xstd)
mean_math = denormdata(Ef, ymean, ystd)
std_math = sqrt(Varf) * ystd
inf = [mean_math, std_math, grid_x]
inf = dataset({inf 'mean', 'std', 'trt', 'schoolid', 'gen', 'eth', 'lunch', 'lunch_rate'})


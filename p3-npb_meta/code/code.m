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


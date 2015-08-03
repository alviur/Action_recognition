if 1
  O = 320;
  T = 20;
  nex = 60;
  M = 4;
  Q = 3;
else
  O = 320;          %Number of coefficients in a vector 
  T = 2000;        %Number of vectors in a sequence 
  nex = 1;        %Number of sequences 
  M = 2;          %Number of mixtures 
  Q = 6;          %Number of states 
end
cov_type = 'full';

data = randn(O,T,nex);

% initial guess of parameters
prior0 = normalise(rand(Q,1));
% transmat0 = mk_stochastic(rand(Q,Q));
transmat0 = mk_rightleft_transmat(Q, 0.5);

if 1
  Sigma0 = repmat(eye(O), [1 1 Q M]);
  % Initialize each mean to a random data point
  indices = randperm(T*nex);
  mu0 = reshape(data(:,indices(1:(Q*M))), [O Q M]);
  mixmat0 = mk_stochastic(rand(Q,M));
else
  [mu0, Sigma0] = mixgauss_init(Q*M, data, cov_type);
  mu0 = reshape(mu0, [O Q M]);
  Sigma0 = reshape(Sigma0, [O O Q M]);
  mixmat0 = mk_stochastic(rand(Q,M));
end

[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
    mhmm_em(data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 5,'cov_type','diag');


loglik = mhmm_logprob(data, prior1, transmat1, mu1, Sigma1, mixmat1);


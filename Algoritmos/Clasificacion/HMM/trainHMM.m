function [LL, prior1, transmat1, mu1, Sigma1, mixmat1] = trainHMM(data,numberGaussians,ergodic,states,iteraciones)

prior0 = normalise(rand(states,1));

if strcmp(ergodic,'si')
    transmat0=mk_stochastic(rand(states,states));
else
    transmat0=mk_leftright_transmat(states,0.5);
end

observaciones=size(data,1);

[mu0, Sigma0] = mixgauss_init(states*numberGaussians, data,'spherical');
mu0 = reshape(mu0, [observaciones states numberGaussians]);
Sigma0 = reshape(Sigma0, [observaciones observaciones states numberGaussians]);
mixmat0 = mk_stochastic(rand(states,numberGaussians));


[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
    mhmm_em(data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter',iteraciones);

end


function loglik= validateHMM(data,prior, transmat, mu, Sigma, mixmat)

    loglik = mhmm_logprob(data, prior, transmat, mu, Sigma, mixmat);

end
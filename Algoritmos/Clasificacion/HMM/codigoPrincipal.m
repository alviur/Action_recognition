function [Eficiencia,MatrizConfusion,indicesPCA]=codigoPrincipal(Datos1,Datos2,Datos3,ind,Mix,ergodic,num_states)

    [foldEnt1,foldEnt2,foldEnt3,foldTest]=crossValidation(Datos1,Datos2,Datos3,ind);

    Datos=[foldEnt1;foldEnt2;foldEnt3];
    [DatosNorm,MU,SIG]=zscore(Datos);
    
    modelo=extraerPCA(DatosNorm,0.05);
    
    Matriz1=armarMatriz(Datos1);
    Matriz2=armarMatriz(Datos2);
    Matriz3=armarMatriz(Datos3);

    DatosNorm1=normalizar(Matriz1,MU,SIG);
    DatosNorm2=normalizar(Matriz2,MU,SIG);
    DatosNorm3=normalizar(Matriz3,MU,SIG);

    DatosPCA1=aplicarPCA(DatosNorm1,modelo);
    DatosPCA2=aplicarPCA(DatosNorm2,modelo);
    DatosPCA3=aplicarPCA(DatosNorm3,modelo);
    
    indicesPCA=size(DatosPCA1,2);
    
    [~,prior1,transmat1,mu1,Sigma1,mixmat1]=trainHMM(DatosPCA1',Mix,ergodic,num_states,10);
    [~,prior2,transmat2,mu2,Sigma2,mixmat2]=trainHMM(DatosPCA2',Mix,ergodic,num_states,10);
    [~,prior3,transmat3,mu3,Sigma3,mixmat3]=trainHMM(DatosPCA3',Mix,ergodic,num_states,10);
    
    probabilidad=[];
    N=length(foldTest);
    
    for i=1:N
        
        DatosEval=foldTest(i).Caracteristicas;
        Esperado(i)=foldTest(i).Etiqueta;
        
        DatosEvalNorm=normalizar(DatosEval,MU,SIG);
        DatosEvalPCA=aplicarPCA(DatosEvalNorm,modelo);

        prob1=validateHMM(DatosEvalPCA',prior1,transmat1,mu1,Sigma1,mixmat1);
        prob2=validateHMM(DatosEvalPCA',prior2,transmat2,mu2,Sigma2,mixmat2);
        prob3=validateHMM(DatosEvalPCA',prior3,transmat3,mu3,Sigma3,mixmat3);
        
        probabilidad=[probabilidad;[prob1,prob2,prob3]];
        
    end
    
    [~,Prueba]=max(probabilidad,[],2);
    MatrizConfusion=confusionmat(Esperado',Prueba);
    Eficiencia=sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));

end
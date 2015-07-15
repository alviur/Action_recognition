function [Eficiencia,MatrizConfusion,indicesPCA]=codigoPrincipal6Clases(Datos,ind,Mix,ergodic,num_states)

    namesField=fieldnames(Datos);

    Datos1=Datos(1).(namesField{1});
    Datos2=Datos(2).(namesField{1});
    Datos3=Datos(3).(namesField{1});
    Datos4=Datos(4).(namesField{1});
    Datos5=Datos(5).(namesField{1});
    Datos6=Datos(6).(namesField{1});

    [foldTrain,foldTest]=crossValidation(Datos,ind);
    
    namesField=fieldnames(foldTrain);

    foldTrain1=foldTrain(1).(namesField{1});
    foldTrain2=foldTrain(2).(namesField{1});
    foldTrain3=foldTrain(3).(namesField{1});
    foldTrain4=foldTrain(4).(namesField{1});
    foldTrain5=foldTrain(5).(namesField{1});
    foldTrain6=foldTrain(6).(namesField{1});
    
    DatosWork=[foldTrain1;foldTrain2;foldTrain3;foldTrain4;foldTrain5;foldTrain6];
    
    [DatosNorm,MU,SIG]=zscore(DatosWork);

    modeloPCA=extraerPCA(DatosNorm,0.05);
    
    Matriz1=armarMatriz(Datos1);
    Matriz2=armarMatriz(Datos2);
    Matriz3=armarMatriz(Datos3);
    Matriz4=armarMatriz(Datos4);
    Matriz5=armarMatriz(Datos5);
    Matriz6=armarMatriz(Datos6);

    DatosNorm1=(Matriz1 - repmat(MU,size(Matriz1,1),1))./repmat(SIG,size(Matriz1,1),1);
    DatosNorm2=(Matriz2 - repmat(MU,size(Matriz2,1),1))./repmat(SIG,size(Matriz2,1),1);
    DatosNorm3=(Matriz3 - repmat(MU,size(Matriz3,1),1))./repmat(SIG,size(Matriz3,1),1);
    DatosNorm4=(Matriz4 - repmat(MU,size(Matriz4,1),1))./repmat(SIG,size(Matriz4,1),1);
    DatosNorm5=(Matriz5 - repmat(MU,size(Matriz5,1),1))./repmat(SIG,size(Matriz5,1),1);
    DatosNorm6=(Matriz6 - repmat(MU,size(Matriz6,1),1))./repmat(SIG,size(Matriz6,1),1);

    DatosPCA1=aplicarPCA(DatosNorm1,modeloPCA);
    DatosPCA2=aplicarPCA(DatosNorm2,modeloPCA);
    DatosPCA3=aplicarPCA(DatosNorm3,modeloPCA);
    DatosPCA4=aplicarPCA(DatosNorm4,modeloPCA);
    DatosPCA5=aplicarPCA(DatosNorm5,modeloPCA);
    DatosPCA6=aplicarPCA(DatosNorm6,modeloPCA);
    
    indicesPCA=size(DatosPCA1,2);
    
    [~,prior1,transmat1,mu1,Sigma1,mixmat1]=trainHMM(DatosPCA1',4,ergodic,3,10);
    [~,prior2,transmat2,mu2,Sigma2,mixmat2]=trainHMM(DatosPCA2',4,ergodic,3,10);
    [~,prior3,transmat3,mu3,Sigma3,mixmat3]=trainHMM(DatosPCA3',4,ergodic,3,10);
    [~,prior4,transmat4,mu4,Sigma4,mixmat4]=trainHMM(DatosPCA4',4,ergodic,3,10);
    [~,prior5,transmat5,mu5,Sigma5,mixmat5]=trainHMM(DatosPCA5',4,ergodic,3,10);
    [~,prior6,transmat6,mu6,Sigma6,mixmat6]=trainHMM(DatosPCA6',Mix,ergodic,num_states,10);
    
    probabilidad=[];
    N=length(foldTest);
    
    for i=1:N
        
        DatosEval=foldTest(i).Caracteristicas;
        Esperado(i)=foldTest(i).Etiqueta;
        
        DatosEvalNorm=(DatosEval - repmat(MU,size(DatosEval,1),1))./repmat(SIG,size(DatosEval,1),1);
        DatosEvalPCA=aplicarPCA(DatosEvalNorm,modeloPCA);

        prob1=validateHMM(DatosEvalPCA',prior1,transmat1,mu1,Sigma1,mixmat1);
        prob2=validateHMM(DatosEvalPCA',prior2,transmat2,mu2,Sigma2,mixmat2);
        prob3=validateHMM(DatosEvalPCA',prior3,transmat3,mu3,Sigma3,mixmat3);
        prob4=validateHMM(DatosEvalPCA',prior4,transmat4,mu4,Sigma4,mixmat4);
        prob5=validateHMM(DatosEvalPCA',prior5,transmat5,mu5,Sigma5,mixmat5);
        prob6=validateHMM(DatosEvalPCA',prior6,transmat6,mu6,Sigma6,mixmat6);
        
        probabilidad=[probabilidad;[prob1,prob2,prob3,prob4,prob5,prob6]];
        
    end
    
    [~,Prueba]=max(probabilidad,[],2);
    MatrizConfusion=confusionmat(Esperado',Prueba);
    Eficiencia=sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));

end
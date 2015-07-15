function [Eficiencia,MatrizConfusion,modeloCRF] = codigoPrincipalCRF3Clases(Datos,fold,tam_ventana)

    %%%%% Se aplica crossvalidation para separar los datos en los folds
    
    [MatrizCompleta,sequenciasFoldEntrenamiento,sequenciasFoldValidacion]=crossValidation(Datos,fold);
    
    namesField=fieldnames(MatrizCompleta);

    %%%%% Se extraen los folds de entrenamiento
    
    foldTrain1=MatrizCompleta(1).(namesField{1});
    foldTrain2=MatrizCompleta(2).(namesField{1});
    foldTrain3=MatrizCompleta(3).(namesField{1});
    
    DatosWork=[foldTrain1;foldTrain2;foldTrain3];
    
    %%%%% Se aplica zcore y se extraen la media y la desviacion estandar
    
    [DatosNorm,MU,SIG]=zscore(DatosWork);

    %%%%% Se aplica PCA y se extrae la matriz de transformación
    
    modeloPCA=extraerPCA(DatosNorm,0.05);

    %%%%% Etapa de aplicar la normalizacion y PCA %%%%%

%     DatosW=[Datos1,Datos2,Datos3,Datos4,Datos5,Datos6];
    [sequenciasFoldEntrenamiento,~]=aplicarNormPCA(sequenciasFoldEntrenamiento,MU,SIG,modeloPCA);
    sequenciasFoldValidacion=aplicarNormPCA(sequenciasFoldValidacion,MU,SIG,modeloPCA);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%% Se convierten los datos al formato del toolbox, que es por celdas
    %%%%% y dentro de cada celda estan las secuencias de observaciones, donde las observaciones son cada columna
    
    EtiquetasEntrenamiento=(extractfield(sequenciasFoldEntrenamiento,'Etiqueta'));
    EtiquetasCelda=extenderLabel2Cell(sequenciasFoldEntrenamiento,EtiquetasEntrenamiento,'struct');
    intLabelsTrain=cellInt32(EtiquetasCelda);
    
    %%% Label prueba
    
    EtiquetasValidacion=(extractfield(sequenciasFoldValidacion,'Etiqueta'));
%     EtiquetasValidacion=[sequenciasFoldValidacion.Etiqueta]';
    
    %%%%%
    
    seqEnt=field2cell(sequenciasFoldEntrenamiento,'Caracteristicas');
    seqVal=field2cell(sequenciasFoldValidacion,'Caracteristicas');
    
    modeloCRF=entrenarCRF(seqEnt,intLabelsTrain,tam_ventana);
    
    ll = validateCRF(modeloCRF,seqVal,EtiquetasValidacion);
    
    PruebaMedia=zeros(length(ll),1);
    
    for i=1:length(ll)
        
        sub=ll{i};
        media=mean(sub,2);
        [~,PruebaMedia(i)]=max(media);
        
    end
        
    PruebaMedia=PruebaMedia-1;
    MatrizConfusion=confusionmat(EtiquetasValidacion,Prueba');
    Eficiencia=sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));

end
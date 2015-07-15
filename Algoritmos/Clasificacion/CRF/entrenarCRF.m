
%%%%% Función para entrenar un modelo CRF en base a unas secuencias de
%%%%% entrenamiento y unos labels de entrenamiento. Cada secuencia de
%%%%% entrenamiento tienen unas observaciones y un solo label que describe
%%%%% toda la secuencia.

%%%%% La función recibe como parametros:
%%%%%       seqs: Es un array de celdas en el cual cada celda tiene la
%%%%%             secuencia de observaciones con la que se va a entrenar. Esta secuencia
%%%%%             tiene en cada columna el vector de observaciones.
%%%%%       labels: Es un vector que contiene el label de cada secuencia.
%%%%%               Los valores deben se numericos, no se permiten valores
%%%%%               categoricos.
%%%%%       tam_ventana: Es un valor que indica el tamaño de la ventana de
%%%%%                    observación de cada que tiene el HCRF. Este es un valor
%%%%%                    numerico, si el valor es 0 el modelo no tiene ventana.

function modelo = entrenarCRF(seqs,labels,tam_ventana)

    matHCRF('createToolbox','crf','bfgs',0,tam_ventana); %%% Se crea un toolbox con los parametros del modelo a entrenar
    matHCRF('setData',seqs,labels);  %%% Se le asigna al toolbox las secuencias de entrenamiento
    matHCRF('set','maxIterations',300); %%% Se asigna el número máximo de iteraciones del algoritmo de entrenamiento
    matHCRF('set','minRangeWeights',-1); %%% Se asigna el valor minimo que pueden tomar los pesos de las funciones "features"
    matHCRF('set','maxRangeWeights',1); %%% Se asigna el valor maximo que pueden tomar los pesos de las funciones "features"
    matHCRF('set','debugLevel',0); %%% Se asigna si se muestran o no mensajes, en este caso no se muestran mensajes
    matHCRF('train'); %%% Con esta linea se inicia el entrenamiento
    
    %%% Se guardan los datos del modelo entrenado %%%
    
    [modelo.model,modelo.features]=matHCRF('getModel'); 
    modelo.optimizer='bfgs'; 
    modelo.windowSize=tam_ventana;
    modelo.debugLevel=0;
    modelo.modelType='crf';
    modelo.caption='CRF';
    
    matHCRF('clearToolbox');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
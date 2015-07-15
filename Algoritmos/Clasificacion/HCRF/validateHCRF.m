
%%%%% Función para asignar un label a una un set de secuencias de
%%%%% validación.

%%%%% La función recibe como parametros:
%%%%%       model: Estructura que contiene toda la información del modelo
%%%%%              HCRF entrenado.
%%%%%       seqs: Es un array de celdas en el cual cada celda tiene la
%%%%%             secuencia de observaciones a evaluar. Esta secuencia
%%%%%             tiene en cada columna el vector de observaciones.

function ll = validateHCRF(model,seqs)

    matHCRF('createToolbox',model.modelType,model.optimizer,model.nbHiddenStates,model.windowSize); %%% Se crea un toolbox con los parametros del modelo entrenado previamente
    matHCRF('set','debugLevel',model.debugLevel); %%% Se asigna si se muestran o no mensajes
    matHCRF('setModel',model.model,model.features); %%% Se le asigna el modelo al toolbox

    ll=cell(1,size(seqs,1));  %%% Se crea un vector de celdas para guardas las probabilidades de cada una de las secuencias

    for i=1:length(seqs)

        %%% Asignar un label a toda una secuencia %%%
        
        subSeq=seqs(i); %%% Se extrae la secuencia a evaluar
        matHCRF('setData',subSeq,[],int32(0)); %%% Se le asigna al toolbox las secuencias a evaluar
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        matHCRF('test'); %%% Esta linea evalua las secuencias
        llSeq=matHCRF('getResults'); %%% Se obtienen las probabilidades
        ll{i}=llSeq{1}; %%% Esta linea va guardando las probabilidades obtenidas. (Una etiqueta para toda la secuencia)
        
    end

end
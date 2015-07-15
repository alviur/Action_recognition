clc
clear all
close all

load('DatosWork.mat', 'Datos')
DatosW(1).Data=Datos(1).Data;
DatosW(2).Data=Datos(2).Data;
DatosW(3).Data=Datos(3).Data;
    
for num_estados=2:5

    for tam_ventana=0:3
        
        for fold=1:10

            disp('Entrenando modelo ...');
            [EtiquetasValidacion,seqVal,modeloHCRF]=codigoPrincipalHCRF3ClasesTrain(DatosW,fold,num_estados,tam_ventana);
            disp('Fin del Entrenamiento');

            texto=['DatosValidacion_NumeroEstados(',num2str(num_estados),')_TamañoVentana(',num2str(tam_ventana),')_Fold(',num2str(fold),').mat'];
            save(texto,'EtiquetasValidacion','seqVal','modeloHCRF');
        
        end

    end

end



close all
clear all
clc

load('DatosWork.mat', 'Datos')
DatosW(1).Data=Datos(1).Data;
DatosW(2).Data=Datos(2).Data;
DatosW(3).Data=Datos(3).Data;

for num_states=2:5

    for tam_ventana=0:3

        for fold=1:10

            disp('Entrenando modelo ...');
            [Eficiencia,MatrizConfusion,modeloHCRF]=codigoPrincipalHCRF3Clases(DatosW,fold,num_states,tam_ventana,'ghcrf');
    %         [EficienciaModa,MatrizConfusionModa,EficienciaMedia,MatrizConfusionMedia,modeloCRF] = codigoPrincipalCRF3Clases(DatosW,fold,tam_ventana);
            disp('Fin del Entrenamiento');

            texto=['Resultados_NumeroEstados(',num2str(num_states),')_TamañoVentana(',num2str(tam_ventana),')_Fold(',num2str(fold),').mat'];
            save(texto,'Eficiencia','MatrizConfusion','modeloHCRF');

        end

    end

end
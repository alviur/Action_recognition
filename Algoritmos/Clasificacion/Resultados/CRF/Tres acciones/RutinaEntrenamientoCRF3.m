
close all
clear all
clc

load('DatosWork.mat', 'Datos')
DatosW(1).Data=Datos(1).Data;
DatosW(2).Data=Datos(2).Data;
DatosW(3).Data=Datos(3).Data;

for tam_ventana=4:6

    for fold=1:10

        disp('Entrenando modelo ...');
        [EficienciaModa,MatrizConfusionModa,EficienciaMedia,MatrizConfusionMedia,modeloCRF] = codigoPrincipalCRF3Clases(DatosW,fold,tam_ventana);
        disp('Fin del Entrenamiento');

        texto=['Resultados_TamañoVentana(',num2str(tam_ventana),')_Fold(',num2str(fold),').mat'];
        save(texto,'EficienciaModa','MatrizConfusionModa','EficienciaMedia','MatrizConfusionMedia','modeloCRF');

    end

end

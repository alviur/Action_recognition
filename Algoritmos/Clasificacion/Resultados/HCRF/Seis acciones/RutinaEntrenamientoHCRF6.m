
close all
clear all
clc

load('DatosWork.mat', 'Datos')

for num_states=2:5

    for tam_ventana=0:3

        for fold=1:10

            disp('Entrenando modelo ...');
            [Eficiencia,MatrizConfusion,modeloHCRF]=codigoPrincipalHCRF6Clases(Datos,fold,num_states,tam_ventana,'hcrf');
            disp('Fin del Entrenamiento');

            texto=['Resultados_NumeroEstados(',num2str(num_states),')_TamañoVentana(',num2str(tam_ventana),')_Fold(',num2str(fold),').mat'];
            save(texto,'Eficiencia','MatrizConfusion','modeloHCRF');

        end

    end

end

function EtiquetasCelda = extenderLabel2Cell(Datos,Label,tipo)

    N=length(Datos);
    EtiquetasCelda=cell(1,N);
    
    if strcmp(tipo,'struct')
        
        namesField=fieldnames(Datos);

        for i=1:N

            longitud=size(Datos(i).(namesField{1}),1);
            LabelExt=Label(i)*ones(longitud,1);
            EtiquetasCelda{i}=LabelExt;

        end
    elseif strcmp(tipo,'cell')
        
        for i=1:N

            longitud=size(Datos{i},2);
            LabelExt=Label(i)*ones(longitud,1);
            EtiquetasCelda{i}=LabelExt;

        end

    end
        
end
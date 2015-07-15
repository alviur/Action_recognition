
function [foldTrain,foldTest] = crossValidation(Datos,fold,num_folds)

    numDatos=length(Datos);
    foldTest=[];
    field=fieldnames(Datos);
    
    for cont=1:numDatos
        
        DatosExtraer=Datos(cont).(field{1});
        name=fieldnames(DatosExtraer);
        
        tope=length(DatosExtraer);
        N=ceil(tope/num_folds);
        i=(N*(fold-1))+1;

        if (i+N-1)<=tope
            foldTest=[foldTest,DatosExtraer(i:i+N-1)];
            ind=i:i+N-1;
        else
            foldTest=[foldTest,DatosExtraer(i:tope)];
            ind=i:tope;
        end
        
        DatosExtraer(ind)=[];

        foldEnt=[];

        for i=1:length(DatosExtraer)
            foldEnt=[foldEnt;DatosExtraer(i).(name{1})];     
        end

        foldTrain(cont).Data=foldEnt;
        
    end
        
end
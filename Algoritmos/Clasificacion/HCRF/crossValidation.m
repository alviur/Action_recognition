
function [foldTrain,foldValidation,foldTest] = crossValidation(Datos,fold)

    numClases=length(Datos);
    foldTest=[];
    foldValidation=[];
    field=fieldnames(Datos);
    
    for cont=1:numClases
        
        DatosExtraer=Datos(cont).(field{1});
        name=fieldnames(DatosExtraer);
        
        tope=length(DatosExtraer);
        N=ceil(tope/10);
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
            foldValidation=[foldValidation;DatosExtraer(i)];
        end

        foldTrain(cont).Data=foldEnt;
        
    end
        
end
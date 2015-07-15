
%%% Datos es una estructura con las observaciones en cada campo %%%

function [Datos,indicesPCA] = aplicarNormPCA(Datos,MU,SIG,modeloPCA)

    N=length(Datos);
    namesField=fieldnames(Datos);
    
    for i=1:N
        
        DatosWork=Datos(i).(namesField{1});
        DatosNorm1=(DatosWork - repmat(MU,size(DatosWork,1),1))./repmat(SIG,size(DatosWork,1),1);
        DatosPCA1=aplicarPCA(DatosNorm1,modeloPCA);
        indicesPCA=size(DatosPCA1,2);
        Datos(i).(namesField{1})=DatosPCA1;
        
    end

end
function Derivada=sacarDerivada(Serie,Grado)

    longitud=length(Serie);
    Serie=[Serie;0;0];
    Derivada=zeros(longitud,1);
    
    if Grado==1
        for i=1:longitud

            h=Serie(i+2)-Serie(i);
            Derivada(i)=(-Serie(i+2)+4*Serie(i+1)-3*Serie(i))/2*h;

        end
    elseif Grado==2
        for i=1:longitud

            h=Serie(i+2)-Serie(i);
            Derivada(i)=(Serie(i+2)-2*Serie(i+1)+Serie(i))/h^2;

        end
    end

end
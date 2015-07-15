function Datos=armarBD(D,E)

    N=length(D);
    
    for i=1:N

        load(D(i).name);
        Datos(i).Caracteristicas=C(:,1:240);
        Datos(i).Etiqueta=E;
        Datos(i).name=D(i).name;
        clear C;
    
    end

end
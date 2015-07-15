function Matriz = armarMatriz(Datos)

    N=length(Datos);
    Matriz=[];
    
    for i=1:N
        
        Matriz=[Matriz;Datos(i).Caracteristicas];
        
    end

end
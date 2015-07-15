function Salida = field2cell(Estructura,Campo)

    N=length(Estructura);
    Salida=cell(N,1);
    
    for i=1:N
        
        Salida{i}=(Estructura(i).(Campo)');
        
    end

end
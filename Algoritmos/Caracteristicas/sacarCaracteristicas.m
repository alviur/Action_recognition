function Caracteristicas=sacarCaracteristicas(ventanaTiempo,ventanaFrecuencia)

    Maximo=sacarMaximo(ventanaTiempo);
    Minimo=sacarMinimo(ventanaTiempo);
    Media=sacarMedia(ventanaTiempo);
    Desviacion=sacarDesviacion(ventanaTiempo);
    Kurtosis=sacarKurtosis(ventanaTiempo);
    Skewness=sacarSkewness(ventanaTiempo);
    Energia=sacarEnergia(ventanaTiempo);
    
    %%%%%% ===>>> Faltan estas
    Entropia=sacarEntropia(ventanaTiempo);
    Frecuencia=sacarFrecuenciaMaxima(ventanaFrecuencia);
    EnergiaFrecuencia=sacarEnergiaFrecuencia(ventanaFrecuencia);
    
    Caracteristicas=[Maximo,Minimo,Media,Desviacion,Kurtosis,Skewness,Energia,Entropia,Frecuencia,EnergiaFrecuencia];

end
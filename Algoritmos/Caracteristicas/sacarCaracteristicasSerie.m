function Caracteristicas=sacarCaracteristicasSerie(Serie,longVentana)

    CaracteristicasX=[];
    CaracteristicasY=[];
    VentanaHamming=hamming(longVentana);
    solape=round(longVentana/2);
    
    SerieX=Serie(:,1);
    SerieY=Serie(:,2);
    
    SerieX=SerieX-mean(SerieX);
    SeriePriDer=sacarDerivada(SerieX,1);
    SerieSegDer=sacarDerivada(SeriePriDer,1);
    
    for i=1:solape:length(SerieX)
        
        if i+longVentana-1<=length(SerieX)

            SerieVentana=SerieX(i:i+longVentana-1);
            SerieVenPriDer=SeriePriDer(i:i+longVentana-1);
            SerieVenSegDer=SerieSegDer(i:i+longVentana-1);
            FourierSerie=SerieVentana.*VentanaHamming;
            FourierSeriePriDer=SerieVenPriDer.*VentanaHamming;
            FourierSerieSegDer=SerieVenSegDer.*VentanaHamming;
            
            CarSerie=sacarCaracteristicas(SerieVentana,FourierSerie);
            CarSeriePriDer=sacarCaracteristicas(SerieVenPriDer,FourierSeriePriDer);
            CarSerieSegDer=sacarCaracteristicas(SerieVenSegDer,FourierSerieSegDer);
            CaracteristicasX=[CaracteristicasX;[CarSerie,CarSeriePriDer,CarSerieSegDer]]; 
            
        else
            break;
        end
        
    end
    
    SerieY=SerieY-mean(SerieY);
    SeriePriDer=sacarDerivada(SerieY,1);
    SerieSegDer=sacarDerivada(SeriePriDer,1);
    
    for i=1:solape:length(SerieY)

        if i+longVentana-1<=length(SerieY)

            SerieVentana=SerieY(i:i+longVentana-1);
            SerieVenPriDer=SeriePriDer(i:i+longVentana-1);
            SerieVenSegDer=SerieSegDer(i:i+longVentana-1);
            FourierSerie=SerieVentana.*VentanaHamming;
            FourierSeriePriDer=SerieVenPriDer.*VentanaHamming;
            FourierSerieSegDer=SerieVenSegDer.*VentanaHamming;
            
            CarSerie=sacarCaracteristicas(SerieVentana,FourierSerie);
            CarSeriePriDer=sacarCaracteristicas(SerieVenPriDer,FourierSeriePriDer);
            CarSerieSegDer=sacarCaracteristicas(SerieVenSegDer,FourierSerieSegDer);
            CaracteristicasY=[CaracteristicasY;[CarSerie,CarSeriePriDer,CarSerieSegDer]];
            
        else
            break;
        end
        
    end
    
    Caracteristicas=[CaracteristicasX,CaracteristicasY];
    Caracteristicas(isnan(Caracteristicas))=0;
    
end
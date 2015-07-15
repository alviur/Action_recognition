function sacarEf6clases()

    D=dir('*.mat');
    N=length(D);
    V=zeros(1,N-1);
    IndPCA=zeros(1,N-1);
    valC1=zeros(1,N-1);
    valC2=zeros(1,N-1);
    valC3=zeros(1,N-1);
    valC4=zeros(1,N-1);
    valC5=zeros(1,N-1);
    valC6=zeros(1,N-1);
    
    for i=1:N-1

        load(D(i).name)
        V(i)=Eficiencia;
        IndPCA(i)=indicesPCA;
        
        valC1(i)=MatrizConfusion(1,1)/sum(MatrizConfusion(1,:));
        valC2(i)=MatrizConfusion(2,2)/sum(MatrizConfusion(2,:));
        valC3(i)=MatrizConfusion(3,3)/sum(MatrizConfusion(3,:));
        valC4(i)=MatrizConfusion(4,4)/sum(MatrizConfusion(4,:));
        valC5(i)=MatrizConfusion(5,5)/sum(MatrizConfusion(5,:));
        valC6(i)=MatrizConfusion(6,6)/sum(MatrizConfusion(6,:));
       
        clear MatrizConfusion
        clear Eficiencia
        clear indPCA
        
    end

    Ef=mean(V);
    IC=std(V);
    C1Ef=mean(valC1);
    C2Ef=mean(valC2);
    C3Ef=mean(valC3);
    C4Ef=mean(valC4);
    C5Ef=mean(valC5);
    C6Ef=mean(valC6);
    
    C1IC=std(valC1);
    C2IC=std(valC2);
    C3IC=std(valC3);
    C4IC=std(valC4);
    C5IC=std(valC5);
    C6IC=std(valC6);
    
    save('Resultados.mat','Ef','IC','IndPCA','C1Ef','C2Ef','C3Ef','C4Ef','C5Ef','C6Ef','C1IC','C2IC','C3IC','C4IC','C5IC','C6IC');

end
function [Ef,IC,C1Ef,C2Ef,C3Ef,C1IC,C2IC,C3IC]=sacarEf()

    D=dir('*.mat');
    N=length(D);
    V=zeros(1,N-1);
%     IndPCA=zeros(1,N-1);
    valC1=zeros(1,N-1);
    valC2=zeros(1,N-1);
    valC3=zeros(1,N-1);
    
    for i=1:N-1

        load(D(i).name)
        V(i)=Eficiencia;
%         IndPCA(i)=indPCA;
        
        valC1(i)=MatrizConfusion(1,1)/sum(MatrizConfusion(1,:));
        valC2(i)=MatrizConfusion(2,2)/sum(MatrizConfusion(2,:));
        valC3(i)=MatrizConfusion(3,3)/sum(MatrizConfusion(3,:));
       
        clear matConfusion
        clear Eficiencia
        clear indPCA
        
    end

    Ef=mean(V);
    IC=std(V);
    
    valC1(isnan(valC1))=0;
    valC2(isnan(valC2))=0;
    valC3(isnan(valC3))=0;
    
    C1Ef=mean(valC1);
    C2Ef=mean(valC2);
    C3Ef=mean(valC3);
    C1IC=std(valC1);
    C2IC=std(valC2);
    C3IC=std(valC3);

end
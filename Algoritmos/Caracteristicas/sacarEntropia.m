function Entropia=sacarEntropia(Ventana)

	y=int8(Ventana);
	N = histc(y,0: max(y));
	Entropia=0;
    
	for i=1:size(N,1)
		
        if (N(i)==0)
            a=0;
        end

        if (N(i)~=0)
            a=log2((size(Ventana,1))/N(i));
        end
	
        Entropia=Entropia+(N(i)/size(Ventana,1))*a;
        
	end

end
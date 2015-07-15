function Serie=sacarSerie()

    lista=dir('*.pgm');
    longitud=length(lista);

    Serie=zeros(longitud,2);
    
    for i=1:longitud

        image =imshow(lista(i).name);
        waitforbuttonpress
        Serie(i,:)=ImageClickCallback ( image , 'ButtonDownFcn' );
        
    end

end
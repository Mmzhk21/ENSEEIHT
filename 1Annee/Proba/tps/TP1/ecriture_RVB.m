function image_RVB = ecriture_RVB(image_originale)
        [nc, nl] = size(image_originale);

        A = zeros(nc/2,nl/2,3);
        A(1:nc/2,1:nl/2,1) = image_originale(1:2:nc-1, 2:2:nl);
        A(1:nc/2,1:nl/2,3) = image_originale(2:2:nc, 1:2:nl-1);
        A(1:nc/2,1:nl/2,2) = (image_originale(1:2:nc-1, 2:2:nl-1) + image_originale(2:2:nc, 2:2:nl))/2 ;
        image_RVB = A;
end



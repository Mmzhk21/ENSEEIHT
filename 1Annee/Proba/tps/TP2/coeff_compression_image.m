function coeff_compression = coeff_compression_image(histogramme,dico)
    nbr_pixel = sum(histogramme);
    image_mem = nbr_pixel*8;
    A = cellfun('length', dico);
    A = A(:, 2);
    image_encod = histogramme*A;
    coeff_compression = image_mem/image_encod;
end
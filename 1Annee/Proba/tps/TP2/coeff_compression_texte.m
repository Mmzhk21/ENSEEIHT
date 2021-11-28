function coeff_compression = coeff_compression_texte(texte,texte_encode)
        bit = 8;
        a = lenght(texte)*bit;
        b = lenght(texte_encode);
        coeff_compression = a/b;
end
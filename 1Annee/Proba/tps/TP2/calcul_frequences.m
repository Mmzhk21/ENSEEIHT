function frequences = calcul_frequences(texte,alphabet)
    frequences=zeros(1,length(alphabet));
    for i = 1:length(alphabet)
    Output = 0;
    for j = 1:length(texte)
        if alphabet(i) == texte(j)
            Output = Output + 1;
        end
    end
    frequences(i)= Output/length(texte)
end
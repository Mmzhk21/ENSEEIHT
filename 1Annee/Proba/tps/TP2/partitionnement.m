function bornes = partitionnement(selection_frequences)
    [frequences_triees, indices_frequences_triees] = sort(selection_frequences, 'descend');
    [0 0+selection_frequences(1)];
    bornes(1, :) = [0 0+selection_frequences(1)];
    for i = 2:length(selection_frequences)
        bornes(i, :) = [bornes(i-1, 2) bornes(i-1, 2)+selection_frequences(i)];
    end
end
function [selection_frequences,selection_alphabet] = selection(frequences,alphabet)
        position = find(frequences>0)
        selection_frequences = frequences(position)
        selection_alphabet = alphabet(frequences>0)
        
        
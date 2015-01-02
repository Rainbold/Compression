function [ img ] = reconstruction( vectors )

    colonne = sum(vectors{1});
    ligne = length(vectors);
    
    img = zeros(ligne, colonne);
    s = 1;
    L = [];
    for i=1:ligne
        for j=1:length(vectors{i})
            v = vectors{i};
            L = [L (ones(1, v(j))*s)];
            s = mod(s+1, 2);
        end
        img(i,:) = L;
        L = [];
        s = 1;
    end
end
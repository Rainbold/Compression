path = 'football/gray/';

% Lire et afficher deux images cons?cutives I1 et I2 de la s?quence
% football

img_n_1 = imread(strcat(path,'football000.ras'));
img_n = imread(strcat(path,'football001.ras'));


% Ecrire une fonction qui estime le mouvement de I1 vers I2 pas Block
% Matching

window = 15;
bloc = 8;
win_size = fix(15/2);

[bloc_y_M, bloc_x_M] = size(img_n);     % [Lignes, Colonnes]
bloc_y_M = bloc_y_M/8;
bloc_x_M = bloc_x_M/8;

R = nan(bloc_y_M, bloc_x_M);
vect = cell(bloc_y_M, bloc_x_M);

figure
imshow(img_n);

for k=1:bloc_y_M
    for l=1:bloc_x_M
        
        I = k;      % ligne
        J = l;      % colonne
        R = nan(bloc_y_M, bloc_x_M);
        bloc_n = img_n( ((I-1)*bloc+1):(I*bloc), ((J-1)*bloc+1):(J*bloc) );

        for i=max(1, I - win_size):1:min(bloc_y_M, I + win_size)    
            for j=max(1, J - win_size):1:min(bloc_x_M, J + win_size)
                bloc_n_1 = img_n(((i-1)*bloc+1):(i*bloc), ((j-1)*bloc+1):(j*bloc));
                R(i,j) = sum(sum(abs(bloc_n-bloc_n_1)));
                %SAD(blocfixeIMG_N, blocIMG_N-1(i,j));
            end
        end
        [R, m] = min(R);
        [z, n] = min(R);
        
        vect{k, l} = [m(n) n];
        quiver(k,l, m(n), n);
   end
end


%vect
%vect{1,1}


%% TP Compression - Maxime Peterlin - Gabriel Vermeulen
clear all;
close all;
%% Partie 1 Compression

x = [ 0 0 0 0 1 1 0 0 1 1 1 0 0 0 0 0 1 ];

fprintf('Detection des sequences de 0 et de 1 :\n');
line = nb_seq(x)

%% Chargement des fichiers

white = input_file('white_codes.txt');
black = input_file('black_codes.txt');

%% Codage d'une ligne
fprintf('Codage d''une ligne');
line_code = code_line(line, white, black)

%% Ajout d'autres lignes
line_code = [line_code code_line(line, white, black)];
line_code = [line_code code_line(line, white, black)];
line_code

%% Ecriture dans un fichier

fd = fopen('line.txt', 'w+');
fwrite(fd, line_code);

%% Partie 2
%% Decompression
close all;
clear all;

%% Lecture du fichier

fd = fopen('line.txt', 'r');
line = fgetl(fd);

%% Chargement des arbres
load('tree_codes.mat');

%% Decodage
vectors = decode_doc(line, white_tree, black_tree);

%% Reconstruction
img = reconstruction(vectors)

%% Partie 3
clear all;
close all;

img = double(imread('test_bin.tif'));
white = input_file('white_codes.txt');
black = input_file('black_codes.txt');
%% Encodage
fd = fopen('test_img.bin', 'wb+');
l = length(img);
for i=1:l
    line = code_line(nb_seq(img(i,:)), white, black);
    line = (line-48) == 1;
    fprintf('Ligne %d / %d, taille: %d\n', i, l, length(line));
    fwrite(fd, line, 'ubit1', 'ieee-be');
end
fclose(fd);

%% Taux de compression
% test_bin.tif = 15 930 octets
% test_img.bin = 8 722  octets
% ratio = 1.8264

% img raw = 39 190 octets
% test_img.bin = 8 722  octets
% ratio = 4.49

%% Decompression
clear all;
close all;

img_origine = double(imread('test_bin.tif'));
figure(1);
imshow(img_origine);
title('image d''origine');

fd = fopen('test_img.bin', 'r');
data = fread(fd, inf, 'bit1', 0, 'b');
data = data == -1;

load('tree_codes.mat');

vectors = decode_doc(data, white_tree, black_tree);

img_reconstruite = reconstruction(vectors);

figure(2);
imshow(img_reconstruite);
title('image reconstruite');

%% recherche d'erreurs

err = sum(sum(img_origine - img_reconstruite));
fprintf('Nombre d''erreurs : %d\n', err);

%% Comparaison avec imwrite

imwrite(img_origine == 1, 'img_fax3.tif', 'Compression', 'fax3');
imwrite(img_origine == 1, 'img_fax4.tif', 'Compression', 'fax4');


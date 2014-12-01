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
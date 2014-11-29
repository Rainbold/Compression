% Chargement et visualisation de l'image
img = imread('cameraman.tif');

figure
imshow(img);

% R?cup?ration du bloc choisi par l'utilisateur
[x, y] = ginput(1);

bloc_size = 8;
bloc_array = img(y:y+bloc_size-1, x:x+bloc_size-1);

% Recentrage et application de la DCT
bloc_dct = dct2(bloc_array-128);

Q = [ 16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55 ;
    14 13 16 24 40 57 69 56 ;
    14 17 22 29 51 87 80 62 ;
    18 22 37 56 68 109 103 77; 
    24 35 55 64 81 104 113 92 ;
    49 64 78 87 103 121 120 101; 
    72 92 95 98 112 100 103 99];

%alpha = 50./Q.*(1<=Q).*(Q<=50) + 50./Q.*(50<=Q).*(Q<=99);

q = 16;
alpha = 50;

Fq = fix(mean(bloc_dct/(alpha.*Q)))

% DONE
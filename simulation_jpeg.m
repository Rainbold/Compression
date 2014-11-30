clear all;
close all;
%% Chargement et visualisation de l'image
img = double(imread('cameraman.tif'));

figure
imshow(img/255);

% R?cup?ration du bloc choisi par l'utilisateur
[x, y] = ginput(1);
x=fix(x); y=fix(y);
bloc_size = 8;
bloc_array = img(y:y+bloc_size-1, x:x+bloc_size-1);
imshow(bloc_array/255);
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

q = 30;
if(q<=50)
    alpha = 50/q;
else
    alpha = (100-q)/50;
end

Fq = fix(bloc_dct/(alpha.*Q));

% Reconstruction

dF = Fq * (alpha.*Q);
bloc = idct2(dF)+128;
figure,
imshow(bloc/255);

%% 
clear all;
close all;
%% Image entière (4s)
img = imread('cameraman.tif');
imgd = double(img);
taille_bloc = 8;

q = 50;

fun = @(block_struct) jpeg_bloc(block_struct.data, q);
fun2 = @(block_struct) jpeg_bloc_img(block_struct.data, q);

img_jpeg = blockproc(img,[taille_bloc taille_bloc],fun);
img_jpeg_show = blockproc(img,[taille_bloc taille_bloc],fun2);
figure;
imshow(img);
figure;
imshow(img_jpeg_show/255);

fprintf('Entropie de img : %d\n', my_entropy(double(img)));
fprintf('Entropie de img_jpeg : %d\n', my_entropy(img_jpeg));

%% Calculs (15s-20s)
R=zeros(1, 99);
for q=1:length(R)
fun = @(block_struct) jpeg_bloc(block_struct.data, q);
img_jpeg = blockproc(img,[taille_bloc taille_bloc],fun);
R(1,q) = my_entropy(img_jpeg);
end

%% Representation des resultats
figure;
plot(1:length(R), R);
xlabel('facteur de qualite q'); ylabel('Entropie');
%% Analyse des performances (45s)
psnr=zeros(1, 99);
for q=1:length(psnr)
fun = @(block_struct) jpeg_bloc_img(block_struct.data, q);
img_jpeg = blockproc(img,[taille_bloc taille_bloc],fun);
psnr(1,q) = 20 * log10(255/((1/(length(imgd)*length(imgd(:,1))))*(sum(sum(abs(imgd-img_jpeg))))));
end

%% Representation des resultats
figure;
plot(1:length(psnr), psnr);
xlabel('facteur de qualite q'); ylabel('PSNR');

%% Performance de compression (quelques secondes)
taille_max = length(imgd)*length(imgd(:,1));

R=zeros(1, 99);
for q=1:length(R)
imwrite(img, 'test.jpeg', 'jpeg', 'Quality' , q);
file = imfinfo('test.jpeg');
R(1,q) = file.FileSize / taille_max;
end

%% Representation des resultats
figure;
plot(1:length(R), R);
xlabel('Facteur de qualite q'); ylabel('Taux de compression');


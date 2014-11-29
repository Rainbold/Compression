function [ e ] = my_entropy_column(img_arg, i)

% i=1 -> ligne, i=2 -> colonne

img = double(imread(img_arg));
img_diff = diff(img, 1, i);
figure
hist(img_diff);
figure
imshow(img_diff);
e = entropy(img_diff);

end
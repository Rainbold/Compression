function [ e ] = my_entropy( img )

%img = double(imread(img));
N = hist(img, 256);
n = sum(N, 2);
n(n==0) = [];
n = n / sum(n,1);
e = -sum(n.*log2(n), 1);

end
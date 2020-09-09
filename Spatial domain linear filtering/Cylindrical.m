%2D Cylindrical PSF

f = imread('forest.jpg');
[M, N, ~] = size(f);
f = rgb2gray(f);
f = double(f)/255.0;
f = imnoise(f, 'gaussian', 0.02);
M1 = 13; %Filter size
N1 = 13;
radius = 3;
P = floor(M1/2);
Q = floor(N1/2);
h = zeros(M1,N1);

for i = 1:M1
    for j = 1:N1
        r = sqrt((i-P)^2 + (j-Q)^2);
        if (r < radius)
            h(i,j) = 1;
        end
    end
end

%Filter Normalization

h = h/sum(sum(h));

%Image reflection at borders

f1 = imageReflection(f, M, N, P, Q);

%Convolution

for i = P+1:M+P
    for j = Q+1:N+Q
        summ = 0;
        for p = -P:P
            for q = -Q:Q
                summ = summ + h(p+P+1,q+Q+1)*f1(i+p,j+q);
            end
        end
        g(i-P,j-Q) = summ;
    end
end

figure;
mesh(h);
title('2D Cylindrical PSF');
figure;
subplot(1,2,1);
imshow(f);
title('Noisy Input Image');
subplot(1,2,2);
imshow(g);
title('Blurred Output Image (Cylindrical PSF)');
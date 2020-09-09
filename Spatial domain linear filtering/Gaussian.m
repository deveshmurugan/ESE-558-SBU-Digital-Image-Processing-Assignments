%Gaussian seperable filter implementation

M1 = 5; %Size of filter
N1 = 5;

P = floor(M1/2);
Q = floor(N1/2);

sd = 1;

for x = -P : P
    h(x+P+1) = (1/sqrt(2*pi*sd^2)) * exp(-(x^2)/(2*sd^2));
end

%h = h/sum(h);
f = imread('forest.jpg');
f = rgb2gray(f);
f = double(f)/255.0;
f = imnoise(f, 'gaussian', 0.02);
f1 = [];
f2 = [];
[M, N] = size(f);

f1 = imageReflection(f, M, N, P, Q);

for i = P+1:M+P
    for j = Q+1:N+Q
        summ = 0;
        for p = -P:P
            for q = -Q:Q
                summ = summ + h(p+P+1)*f1(i+p,j+q);
            end
        end
        f2(i-P,j-Q) = summ;
    end
end

f2 = imageReflection(f2, M, N, P, Q);
h = h';

for i = P+1:M+P
    for j = Q+1:N+Q
        summ = 0;
        for p = -P:P
            for q = -Q:Q
                summ = summ + f2(i+p,j+q)*h(q+Q+1);
            end
        end
        g(i-P,j-Q) = summ;
    end
end

figure;
subplot(1,2,1);
imshow(f);
title('Noisy Input Image');
subplot(1,2,2);
imshow(g/max(max(g)));
title('Blurred Output Image (Gaussian PSF)');
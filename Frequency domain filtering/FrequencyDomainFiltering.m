%Frequency Domain Filtering

f = imread('forest.jpg');
f = rgb2gray(f);
f = double(f)/255.0;
[M, N] = size(f);

for u = 1:M
    for m = 1:M
        P(u,m) = (1/M) * exp(-1i * 2 * pi * ((u * m)/M));
    end
end
for v = 1:N
    for n = 1:N
        Q(v,n) = (1/N) * exp(-1i * 2 * pi * ((v * n)/M));
    end
end

F = P * f * Q; %DFT

H = ones(M,N);
for u = 1:M
    for v = 1:N
        if(((u<5)&&(v<5)) || ((u>m-5)&&(v<5)) || ((u<5)&&(v>M-5)) || ((u>M-5)&&(v>(M-5))))
            H(u,v) = 0.5;
        end
    end
end

G = F .* H; %Convolution in Freq Domain

for u = 1:M
    for m = 1:M
        P1(u,m) = exp(1i * 2 * pi * ((u * m)/M));
    end
end
for v = 1:N
    for n = 1:N
        Q1(v,n) = exp(1i * 2 * pi * ((v * n)/M));
    end
end
g = P1 * G * Q1; %IDFT

subplot(1,2,1);
imshow(f);
title('Input Image');
subplot(1,2,2);
imshow(abs(g));
title('Frequency Domain Filtering Output Image');
% 5X5 Median Filter

f = imread('food1.jpg');

f = rgb2gray(f);
f = double(f)/255.0;

f = imnoise(f, 'salt & pepper', 0.1);
% Introducing salt & pepper noise to the grayscale image

M = size(f,1);
N = size(f,2);

P = 2;
Q = 2;
total = (2*P +1) * (2*Q +1);
% Parameters for filter size

vec = [];
g = []; % Output Image

for m = 1 : M
    for n = 1 : N
        for p = -P : P
            if m-p < 1
                k = abs(m-p)+1;
            elseif m-p > M
                k = M - ((m-p) - M);
            else
                k = m-p;
            end
            for q = -Q : Q 
                if n-q < 1
                    l = abs(n-q)+1;
                elseif n-q > N
                    l = N - ((n-q) - N);
                else
                    l = n-q;
                end
                vec = [vec, f(k,l)];
            end
        end
        vec = sort(vec);
        g(m,n) = vec(round(total/2));
        vec = [];
    end
end
figure;
subplot(1,2,1);
imshow(f);
title('Noisy Input Image')
subplot(1,2,2);
imshow(g);
title('Median Filter Output');
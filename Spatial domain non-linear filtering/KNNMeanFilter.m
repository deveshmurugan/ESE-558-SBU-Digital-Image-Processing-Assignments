% 3X3 KNN Mean Filter

f = imread('food1.jpg');
f = rgb2gray(f);
f = double(f)/255.0;

f = imnoise(f, 'salt & pepper', 0.1);
% Introducing salt & pepper noise to the grayscale image

M = size(f,1);
N = size(f,2);

P = 1;
Q = 1;
K = 4;
% Parameters for filter size and number of neighbors

vec1 =[];
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
                vec1 = [vec1, f(k,l)];
            end
        end
        vec2 = f(m,n) - vec1; % Difference in brightness value of current pixel with it's neighbors
        for i = 1:length(vec2) % Bubble sort
            for j=1:length(vec2) - i
                if abs(vec2(j)) > abs(vec2(j+1)) % Sorting without considering if the difference is negative or positive
                    temp = vec2(j);
                    vec2(j) = vec2(j+1);
                    vec2(j+1) = temp;
                end
            end
        end
        neighbors = f(m,n) - vec2; % Neighbors in the order of closest to farthest to the main pixel 
        g(m,n) = sum(neighbors(2:K+1))/4; % The first value in the array is not considered as it is the value of main pixel. Neighbor pixels start from index 2
        vec1 = [];
    end
end
figure; 
subplot(1,2,1);
imshow(f);
title('Noisy Input Image');
subplot(1,2,2);
imshow(g);
title('KNN Mean Filter Output')
%Part D - Separable Convolution linear transform (SCT)

M = 8;
N = 10;
f= zeros(M,N);
g = f;
g1 = f;

%Getting input f and filters h1c & h2c
for m = 1:M
    for n = 1:N
        f(m,n) = rand()*100;
    end
end
for m = 1:M
    h1c(m) = rand()*100;
end
for n = 1:N
    h2c(n) = rand()*100;
end

%Calculating intermediate result g1
for m = 1:M
    for v = 1:N
        for n = 1:N
            g1(m,v) = g1(m,v) + h2c(rem(v-n+N,N)+1) * f(m,n);
        end
    end
end

%Calculating output g
for u = 1:M
    for v = 1:N
        for m = 1:M
            g(u,v) = g(u,v) + h1c(rem(u-m+M,M)+1) * g1(m,v);
        end
    end
end

fprintf("Input Matrix f: \n");
disp(f);
fprintf("Output Matrix g : \n");
disp(g);
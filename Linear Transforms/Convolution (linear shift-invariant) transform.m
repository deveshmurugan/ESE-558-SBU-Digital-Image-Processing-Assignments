%Part C - Convolution linear transform

M = 8;
N = 10;
f= zeros(M,N);
g = f;

%Getting input f and filter hc
for m = 1:M
    for n = 1:N
        f(m,n) = rand()*100;
        hc(m,n) = rand()*100;
    end
end

%Calculating output g
for u = 1:M
    for v = 1:N
        for m = 1:M
            for n = 1:N
                g(u,v) = g(u,v) + hc(rem(u-m+M,M)+1,rem(v-n+N,N)+1) * f(m,n);
            end
        end
    end
end

fprintf("Input Matrix f: \n");
disp(f);
fprintf("Output Matrix g : \n");
disp(g);
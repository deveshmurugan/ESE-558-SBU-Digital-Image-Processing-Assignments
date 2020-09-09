%Part B - Separable linear transform (SLT)

M = 8;
N = 10;
f= zeros(M,N);
g = f;
g1 = f;

%Getting the input f and filters h1 & h2
for m = 1:M
    for n = 1:N
        f(m,n) = rand()*100;
    end
end
for u = 1:M
    for m = 1:M
        h1(u,m) = rand()*100;
    end
end
for v = 1:N
    for n = 1:N
        h2(v,n) = rand()*100;
    end
end

%Calculating intermediate result g1
for m = 1:M
    for v = 1:N
        for n = 1:N
            g1(m,v) = g1(m,v) + h2(v,n) * f(m,n);
        end
    end
end

%Calculating output g
for u = 1:M
    for v = 1:N
        for m = 1:M
            g(u,v) = g(u,v) + h1(u,m) * g1(m,v);
        end
    end
end

fprintf("Input Matrix f: \n");
disp(f);
fprintf("Output Matrix g : \n");
disp(g);
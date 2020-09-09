%Part A - General (shift-variant) linear transform (GLT)

M = 8;
N = 10;
f= zeros(M,N);
g = f;

%Getting the input f and filter h
for m = 1:M
    for n = 1:N
        f(m,n) = rand()*100;
        for u = 1:M
            for v = 1:N                
                h(m,n,u,v) = rand()*100;
            end
        end
    end
end

%Calculating output g
for u = 1:M
    for v = 1:N
       for m = 1:M
            for n = 1:N
                g(u,v) = g(u,v) + h(u,v,m,n) * f(m,n);  
            end
        end
        
    end
end
fprintf("Input Matrix f: \n");
disp(f);
fprintf("Output Matrix g : \n");
disp(g);
function f1 = imageReflection(f, M, N, P, Q)

f1 = zeros(M + 2*P, N + 2*Q);
f1(1+P:M+P,1+Q:N+Q) = f;

p = P;
i = 1;
while p>0
    f1(i,1+Q:N+Q) = f(p,:);
    p = p-1;
    i = i+1;
end

p = M + 2*P;
i = M-P+1;
while p>M+P
    f1(p,1+Q:N+Q) = f(i,:);
    p = p-1;
    i = i+1;
end

q = 2*Q;
j = 1;
while q>Q
    f1(:,j) = f1(:,q);
    j = j+1;
    q = q-1;
end

q = Q + N;
j = Q + N + 1;
while q>N
    f1(:,j) = f1(:,q);
    j = j+1;
    q = q-1;
end
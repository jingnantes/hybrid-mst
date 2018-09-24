function score=Hodgerank(incomp)

data =incomp;
n = max(max(data));
[compare,col] = size(data);

% transform to (d,y,w)
Z = zeros(n,n);
for k = 1:compare
    a = data(k,:);
    Z(a(1),a(2)) = Z(a(1),a(2))+1;
end
ZZ=Z;
k = 0;
m = sum(sum(Z~=0));
d = zeros(m,n);
w = zeros(m,1);
for i = 1:n
    for j = 1:n
        if (i~=j && Z(i,j)~=0)
            k = k+1;
            w(k) = Z(i,j);
            d(k,i) = 1;
            d(k,j) = -1;
        end
    end
end
y = ones(m,1);
score  = lsqr(d'*diag(w)*d,d'*(w.*y));




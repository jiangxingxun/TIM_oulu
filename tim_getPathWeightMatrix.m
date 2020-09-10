function W = tim_getPathWeightMatrix(N)

W  = zeros(N,N);
for i = 1 : N-1
    W(i,i+1) = 1;
    W(i+1,i) = 1;
end

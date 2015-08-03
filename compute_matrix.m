function compute_matrix(M,N,rho,R)

step = rho(2)-rho(1);
% Computing the matrix A for a given discretization of rho.
A = zeros(M,M);
for num = 1:N/2+1
    for i = 1:M
        for j = 1:i
            A(i,j) = coeff(i-j)*(step^0.5)*K(rho(i),rho(j),num,R,N)/K(rho(i),rho(i),num,R,N);
        end
    end
    S1 = zeros(M,M);
    invB = zeros(M,M);
    [U, S, V] = svd(A(:,:));
    for i = 1:floor(M/2)
       S1(i,i) = 1/S(i,i);
    end
    invB = V*S1*U';
    parsave(sprintf('inv%d.mat', num), invB);
end
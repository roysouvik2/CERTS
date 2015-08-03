% Function representing the inverse operator for Circular Transforms.
function final = inverse_op(g,rho,phi,R)

[M N] = size(g);

% Computing the discrete Fourier Transform with respect to the angular
% variable.

Narr = linspace(1, N, N);

j = 1;
while(j <= M) % Calculating the discrete fourier transform for each rho.
    gdis1(j,:) = fft(g(j,:));
    j = j+1;
end
dlmwrite('datafou.txt',gdis1)

% Solving the Volterra Integral equation of first kind.

for num  = 1:N/2+1
    % Retrieving the inverse of the matrix A.
    load(sprintf('inv%d.mat',num));
   
    %Evaluating the right hand side.
    g = gdis1(:,num);
    for i = 1:M
        gm(i) = g(i)/K(rho(i),rho(i),num,R,N);
    end
    sol = invB*gm';
    invf(:,num) = sol;
    parsave(sprintf('output%d.mat', num), sol);
end

% Computing the solution for the conjugate N's.

for j = 1:M
    for num = N/2+2:N
        invf(j,num) = conj(invf(j,N-num+2));
    end
end


for num = 1:N
    for i = 1:M
        invfm(M+1-i,num) = invf(i,num);
    end
end

% Computing the inverse Fourier Transform.
j = 1;
while(j <= M)
    rfun(j,:) = ifft(invfm(j,:));
    j = j+1;
end

% Converting the solution and polar grid to a solution on Cartesian grid.
[TH R] = meshgrid(phi, rho);

[X,Y,FIN] = pol2cart(TH,R,rfun);
for i = 1:M
    for j = 1:N
        final(i,j) = FIN(i,N-j+1);
    end
end

% Plotting the solution.
figure(3)
colormap(flipud(gray));
surf(X,Y,final,'EdgeColor','none')
view(0,90);


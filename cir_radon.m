% Program to generate the circular Radon data.

function [g, rho, phi] = cir_radon(M,N,R)

% M is the number of discretizations in the radial direction.
% N is the number of discretizations in the angular direction.




eps1 = 0.01; % Cutting of a small neighbourhood of origin and the boundary of the outer circle.

% Evaluating and plotting Shepp-Logan Phantom in polar coordinates.

rho = linspace(eps1, R-eps1, M); % Radial discretization.
phi = linspace(0, 2*pi, N); % Angular discretization.

for j = 1:M
    for l = 1:N
        x2 = rho(j)*cos(phi(l));
        y2 = rho(j)*sin(phi(l));
        f(j,l) = shepp(x2,y2);
    end
end

[TH RHO] = meshgrid(phi, rho);
[X,Y,F] = pol2cart(TH,RHO,f);
figure(1)
colormap(flipud(gray));
surfc(X,Y,F,'EdgeColor','none');
view(0,90);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generating the Radon data.
tot = 200;
ang = linspace(0,2*pi,tot); % Number of discretizations for evaluating the trapezoidal 
                            % integral along circles.
                            
% Array of centers of the integrating circles.
X0 = cos(phi);
Y0 = sin(phi);

for j = 1:M % Fixing a radii rho.
    for l = 1:N % Fixing an angle phi.
    fprintf('j = %d, l = %d \n', j,l);
        
    % Computing the line integral of f over the circle for fixed rho and phi.
        for i = 1:tot
               x1 = (X0(l)+rho(j)*cos(ang(i)));
               y1 = (Y0(l)+rho(j)*sin(ang(i)));
               fun(i) = shepp(x1,y1)*rho(j);

        end
        g(j,l) = trapz(ang, fun);
    end
end

% Surface plot of the Radon data.

figure(2)
surf(phi, rho, g)
xlabel('phi');
ylabel('rho');
view(0,90);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving the Radon data in a file
dlmwrite('slrdata.txt',g);


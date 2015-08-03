% Driver Function.

M = 100;
N = 100;
R = 1.0; % R is the radius of the outer circle.

[g, rho, phi] = cir_radon(M,N,R);
compute_matrix(M,N,rho,R);
final = inverse_op(g,rho,phi,R);

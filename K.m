function Kval = K(rho,u,num,R,N)

if(rho == u)
    Kval = sqrt(2*u*(1-u));
else
    
    num1 = sqrt(-power((power((R-u),2)+power(R,2)-power(rho,2)),2)+power(2*R*(R-u),2));
    den1 = power((R-u),2)+power(R,2)-power(rho,2);
    
    ang = atan(num1./den1);
    if(num <= N/2+1)
        numer = 4.0.*rho.*(R-u).*cos((num-1).*ang);
    else
        numer  =  4.0.*rho*(R-u).*cos((num-N-1)*ang);
    end
    
    den = sqrt((u+rho).*(2.0*R+rho-u).*(2.0*R-rho-u));
    
    Kval = numer./den;
end





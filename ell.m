% Function to generate an elliptical disk.

% x1 is the x coordinate of the domain.
% y1 is the y coordinate of the domain.
% a is the length of the semi-major axis of the ellipse.
% b is the length of the semi-minor axis of the ellipse.
% c1 is the x coordinate of the center of the ellipse.
% c2 is the y coordinate of the center of the ellipse.
% theta is the angle of rotation of the ellipse.

function val = ell(x1,y1,a,b, c1, c2,theta)
x = x1-c1;
y = y1-c2;
if(((sin(theta)*y+cos(theta)*x)/a)^2 + ((sin(theta)*x-cos(theta)*y)/b)^2 <1)
       val = 1.0;
    else
      val = 0.0;
end

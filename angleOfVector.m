function angle = angleOfVector(v)
% ANGLEOFVECTOR returns the angle of the given vector
% determines the angle from the x axis between 0 and 180 degrees
    x = [1, 0];
    angle = acosd(dot(v, x)/(norm(v) * norm(x)));
    
    if v(2) < 0
        angle = 180 - angle;
    end;
end


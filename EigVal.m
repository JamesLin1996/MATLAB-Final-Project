function [sigma1, sigma2] = EigVal(S)
% EIGVAL returns the eigenvalues of the given symmetrix matrix

    I = eye(2);
    eigValEquation = @(lambda) det(S - (lambda * I));
    
    % Use Min-Max theorem to find guesses
    u = [0, 1];
    a = dot(u, S * u');
    min = a;
    max = min;
    
    % Scans the 2D plane for the min and max
    for theta = 0:1:180
        u = [cosd(theta), sind(theta)];
        a = dot(u, S * u');
        if a < min
            min = a;
        elseif a > max
            max = a;
        end;
    end;
    
    % Use the min and max to find the eigenvalues
    sigma1 = fzero(eigValEquation, min);
    sigma2 = fzero(eigValEquation, max);
end


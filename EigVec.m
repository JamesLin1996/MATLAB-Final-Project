function eigVector = EigVec(S, sigma)
% EIGVEC returns the eigenvector of the given matrix and eigenvalue
    syms x2;
    
    % set up equation
    x = [1;x2];
    leftHand = (S - (sigma * eye(2))) * x;
    
    % solve equation
    solved = solve(leftHand(1) == 0, x2);
    
    eigVector = [1;solved];
    % normalize the vector (scale it to a length of 1)
    eigVector = double((1 / norm(eigVector)) * eigVector);
end


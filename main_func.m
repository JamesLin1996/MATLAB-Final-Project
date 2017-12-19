function [EigValues, EigVectors, EigVecAngles, CirclePoints] = main_func(S)
% MAIN_FUNC the main function for the project Gui
% returns:
%   EigValues - an array of eigen values
%   EigVec - an array of eigenvectors that correspond to the eigvalues
%   EigVecAngles - the angles of the corresponding eigenvectors
%   CirclePoints - an array of (x,y) coordinates that form a circle
    
    [sigma1, sigma2] = EigVal(S);   % Get eigvalues
    eigV1 = EigVec(S, sigma1);      % get eigvec1
    eigV2 = EigVec(S, sigma2);      % get eigvec2
    ang1 = angleOfVector(eigV1);    % get eigvec1 angle
    ang2 = angleOfVector(eigV2);    % get eigvec2 angle
    
    % Create list of points of all possible rotations of the matrix
    points = [];
    for a = 0:1:90
        Sp = Rotation(S, a);
        point1 = [Sp(1,1); Sp(1,2)];
        point2 = [Sp(2,2); -Sp(1,2)];
        points = [points, point1, point2];
    end;
    
    EigValues = [sigma1, sigma2];
    EigVectors = [eigV1, eigV2];
    EigVecAngles = [ang1, ang2];
    % Adjust order of points
    CirclePoints = [points(:,1:2:end),points(:,2:2:end)];
    % End of calculation portion
    
    
    % Start of question answering 
    
    % Check eigenvalues and eigenvectors
    correctEigValues = eig(S);
    [correctEigVectors, D] = eig(S);
    fprintf('Checking if eigenvalues are correct.\n');
    fprintf('eig %f ?= calculated %f\n', correctEigValues(1), EigValues(1));
    if correctEigValues(1) == EigValues(1)
        fprintf('There is no difference.\n');
    else
        fprintf('There IS a difference!.\n');
    end;
    
    fprintf('\nThe correct eigenvector for %f is:\n',EigValues(1));
    disp(correctEigVectors(:,1));
    fprintf('The calculated eigenvector is:\n');
    disp(EigVectors(:,1));
    
    fprintf('eig %f ?= calculated %f\n', correctEigValues(2), EigValues(2));
    if correctEigValues(2) == EigValues(2)
        fprintf('There is no difference.\n');
    else
        fprintf('There IS a difference!.\n');
    end;
    
    fprintf('\nThe correct eigenvector for %f is:\n',EigValues(2));
    disp(correctEigVectors(:,2));
    fprintf('The calculated eigenvector is:\n');
    disp(EigVectors(:,2));
    
    fprintf('\nEigenvectors can be the negative of itself without changing the meaning of the eigenvector\n');
    
    % Check S'
    Sp = EigVectors * (S * EigVectors');
    fprintf('\nSp:\n');
    disp(Sp);
    
    threshold = 1e-14; %Eliminates floating point errors
    
    if abs(Sp(1,2) - Sp(2,1)) <= threshold
        fprintf('The matrix Sp is a diagonal matrix!\n');
    else
        fprintf('The matrix Sp is not a diagonal matrix...\n');
    end;
    
    diagonal = diag(Sp);
    if abs(diagonal' - EigValues) <= threshold
        fprintf('The diagonal components of Sp are equal to the eigenvalues\n');
    else
        fprintf('The diagonal components of Sp are not equal to the eigenvalues\n');
    end;
    
    fprintf('\nV:\n');
    disp(EigVectors);
    tf = all(abs(inv(EigVectors) - transpose(EigVectors))<=threshold);
    if tf
        fprintf('V is an orthogonal matrix.\n');
    else
        fprintf('V is not an orthogonal matrix.\n');
    end;
end


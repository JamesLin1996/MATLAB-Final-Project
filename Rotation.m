function rotated = Rotation(S, angle)
% ROTATION returns the given matrix rotated by the given angle
    R = [cosd(angle), -sind(angle); sind(angle), cosd(angle)];
    rotated = R * (S * R');
end


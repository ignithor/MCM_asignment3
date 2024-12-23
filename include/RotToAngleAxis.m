function [h,theta] = RotToAngleAxis(R)
%EULER REPRESENTATION: Given a tensor rotation matrices this function
% should output the equivalent angle-axis representation values,
% respectively 'theta' (angle), 'h' (axis) 
% SUGGESTED FUNCTIONS
    % size()
    % eye()
    % abs()
    % det()
    % NB: Enter a square, 3x3 proper-orthogonal matrix to calculate its angle
    % and axis of rotation. Error messages must be displayed if the matrix
    % does not satisfy the rotation matrix criteria.

    % Check matrix 
    % R to see if its size is 3x3
    if size(R) ~= [3 3]
        error('Wrong size rotation matrix not 3x3');
    end
    % Check if R is orthogonal
    if max(max(abs(R * R' - eye(3)))) > 1e-6
        error('Input matrix R is not orthogonal (R * R'' != I).');
    end
    if abs(det(R) - 1) > 1e-6
        error('The determinant of the rotation matrix is NOT equal to 1.');
    end
    % Compute theta
    theta = acos((trace(R)-1)/2);
    % Compute h
    if theta == 0
        % I chose the simple unitary vector arbitrary
        h = [1 0 0]';
    elseif (3.1415<=theta) && (theta<=3.1416)
        % I chose h_1 >= 0
        if sqrt((R(1,1)+1)/2) ~= 0
            h_1 = sqrt((R(1,1)+1)/2);
            h_2 = sign(R(1,2))*sqrt((R(2,2)+1)/2);
            h_3 = sign(R(1,3))*sqrt((R(3,3)+1)/2);
        elseif sqrt((R(2,2)+1)/2) ~= 0
            h_2 = sqrt((R(2,2)+1)/2);
            h_1 = sign(R(2,1))*sqrt((R(1,1)+1)/2);
            h_3 = sign(R(2,3))*sqrt((R(3,3)+1)/2);
        else
            h_3 = sqrt((R(3,3)+1)/2);
            h_1 = sign(R(3,1))*sqrt((R(1,1)+1)/2);
            h_2 = sign(R(3,2))*sqrt((R(2,2)+1)/2);
        end
        h = [h_1 h_2 h_3]';
    elseif (0<theta) && (theta<3.1415)
        a = vex((R-R')/2);
        h =(1/sin(theta))*a;
    end
end

 
function a = vex(S_a)
% input: skew matrix S_a (3x3)
% output: the original a vector (3x1)
if ~isequal(size(S_a), [3, 3]) || ~isequal(S_a, -S_a')
    error('Input matrix S_a must be a 3x3 skew-symmetric matrix.');
end
a = [S_a(3,2) S_a(1,3) S_a(2,1)]';
end
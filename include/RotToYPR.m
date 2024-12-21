function [psi,theta,phi] = rotToYPR(R)
% Given a rotation matrix the function outputs the relative euler angles
% usign the convention YPR
% Input:
% R rotation matrix
% Output:
% psi angle around z axis (yaw)
% theta angle around y axis (theta)
% phi angle around x axis (phi)
% SUGGESTED FUNCTIONS
    % atan2()
    % sqrt()
    % Check matrix R to see if its size is 3x3
if size(R) ~= [3 3]
    error('Wrong size rotation matrix not 3x3');
end
if (det(R) < 0.999) || (det(R)>1.001)
    error('Not a Rotation Matrix : det(R) = %d',det(R));
end
if (R*R' ~= eye(3))
    error("Not an orthogonale matrix because RR' ~= eye")
end
% Compute theta
theta = atan2(-R(3,1),sqrt(R(1,1)^2 +R(2,1)^2));
if cos(theta) == 0
    error('Configuration singular cos(theta) = 0')
else
    psi = atan2(R(2,1),R(1,1));
    phi = atan2(R(3,2),R(3,3));
end
end


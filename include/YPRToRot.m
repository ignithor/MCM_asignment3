function [R] = YPRToRot(psi, theta, phi)
% The function compute the rotation matrix using the YPR (yaw-pitch-roll)
% convention, given psi, theta, phi.
% Input:
% psi angle around z axis (yaw)
% theta angle around y axis (theta)
% phi angle around x axis (phi)
% Output:
% R rotation matrix
R = zeros(3,3);
R(1,1)=cos(psi)*cos(theta);
R(1,2)=-sin(psi)*cos(phi)+cos(psi)*sin(theta)*sin(phi);
R(1,3)=sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta);
R(2,1)=sin(psi)*cos(theta);
R(2,2)=cos(psi)*cos(phi)+sin(phi)*sin(theta)*sin(psi);
R(2,3)=-cos(psi)*sin(phi)+sin(theta)*sin(psi)*cos(phi);
R(3,1)=-sin(theta);
R(3,2)=cos(theta)*sin(phi);
R(3,3)=cos(theta)*cos(phi);
end
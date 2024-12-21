%% Kinematic Model Class - GRAAL Lab
classdef cartesianControl < handle
    % KinematicModel contains an object of class GeometricModel
    % gm is a geometric model (see class geometricModel.m)
    properties
        gm % An instance of GeometricModel
        k_a
        k_l
    end

    methods
        % Constructor to initialize the geomModel property
        function self = cartesianControl(gm,angular_gain,linear_gain)
            if nargin > 2
                self.gm = gm;
                self.k_a = angular_gain;
                self.k_l = linear_gain;
            else
                error('Not enough input arguments (cartesianControl)')
            end
        end
        function [x_dot]=getCartesianReference(self,bTg)
            %% getCartesianReference function
            % Inputs :
            % bTg : goal frame
            % Outputs :
            % x_dot : cartesian reference for inverse kinematic control
            bTt = gm.getToolTransformWrtBase();
            cartesian_error = bTg(1:3,4) - bTt(1:3,4);
            angular_error = RotToYPR(bTt(1:3,1:3)'*bTg(1:3,1:3));
            error = [angular_error ; cartesian_error];

            K = zeros(6);
            K(1,1) = self.k_a;
            K(2,2) = self.k_a;
            K(3,3) = self.k_a;
            K(4,4) = self.k_l;
            K(5,5) = self.k_l;
            K(6,6) = self.k_l;

            x_dot = K * error;
       
            
        end
    end
end
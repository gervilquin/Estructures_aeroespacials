classdef ElementalStiffnessMatrixComputer < handle
    properties (Access = private)
        coords
        Tnod
        Tmat
        mat
        Rot
        nnodes
        nDOFnode
    end

    methods (Access = public)
        function obj = ElementalStiffnessMatrixComputer(cParams)
            obj = obj.init(cParams);
        end

        function Kel = compute(obj)
            nel = size(obj.Tnod,1);
            nnodel = size(obj.Tnod,2);
            nDOFel = nnodel*obj.nDOFnode;
            Kel = zeros(nDOFel,nDOFel,nel);
            for i=1:nel
                K1  = obj.AxialStiffnessMatrixComputer(i);
                K2 = obj.computeShearBendingStiffnesMatrix(i);
                K = K1 + K2;
                Kel(:,:,i)=transpose(obj.Rot(:,:,i))*K*obj.Rot(:,:,i);
            end
        end
    end

    methods (Access = private)
        function [l_x,l_y,l] = ComputeLengthElement(obj,el) % This method is repeated in different classes. Duplicate code! RotationMatrixComputer
            nodeA = obj.Tnod(el,1);
            nodeB = obj.Tnod(el,2);

            coordXA = obj.coords(nodeA,1);
            coordXB = obj.coords(nodeB,1);
            coordYA = obj.coords(nodeA,2);
            coordYB = obj.coords(nodeB,2);

            l_x = coordXB- coordXA;
            l_y = coordYB - coordYA;
            l = sqrt(l_x^2 + l_y^2);
        end

        function K = AxialStiffnessMatrixComputer(obj,el)
            [~,~,l] = ComputeLengthElement(obj,el);
            Kcoef = ((obj.mat(obj.Tmat(el,1),1)*(obj.mat(obj.Tmat(el,1),2)))/l); %% Express with phyisical magnitudes
            K = Kcoef*[  1    0   0   -1    0     0;
                         0    0   0    0    0     0;
                         0    0   0    0    0     0;
                        -1    0   0    1    0     0;
                         0    0   0    0    0     0;
                         0    0   0    0    0     0]; 
        end

        function K = computeShearBendingStiffnesMatrix(obj,el)
          [~,~,l] = ComputeLengthElement(obj,el);
          Kcoef = ((obj.mat(obj.Tmat(el,1),1)*(obj.mat(obj.Tmat(el,1),3)))/l^3); %% Express with physical magnitudes
          K = Kcoef*[   0    0      0    0    0       0   ;
                        0    12    6*l   0   -12     6*l  ;
                        0   6*l   4*l^2  0   -6*l   2*l^2 ;
                        0    0      0    0    0       0   ;
                        0   -12   -6*l   0    12    -6*l  ;
                        0   6*l   2*l^2  0   -6*l   4*l^2 ];
        end

        function obj = init(obj,cParams)
            obj.Tnod = cParams.Tnod;
            obj.coords = cParams.coords;
            obj.Tmat = cParams.Tmat;
            obj.mat = cParams.mat;
            obj.Rot = cParams.Rot;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end
    end
end
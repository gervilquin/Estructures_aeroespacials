classdef ElementalStiffnessMatrixComputer
    properties %(Access = private)
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
            obj.Tnod = cParams.Tnod;
            obj.coords = cParams.coords;
            obj.Tmat = cParams.Tmat;
            obj.mat = cParams.mat;
            obj.Rot = cParams.Rot;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end

        function Kel = compute(obj)
            nel = size(obj.Tnod,1);
            nnodel = size(obj.Tnod,2);
            nDOFel = nnodel*obj.nDOFnode;
            Kel = zeros(nDOFel,nDOFel,nel);
            for i=1:nel
                K1 = AxialStiffnessMatrixComputer(obj,i);
                K2 = ShearBendingStiffnessMatrixComputer(obj,i);
                K = K1 + K2;
                Kel(:,:,i)=transpose(obj.Rot(:,:,i))*K*obj.Rot(:,:,i);
            end
        end
    end

    methods (Access = private)
        function [l_x,l_y,l] = ComputeLengthElement(obj,el) % This method is repeated in different classes. Duplicate code!
            l_x = obj.coords(obj.Tnod(el,2),1) - obj.coords(obj.Tnod(el,1),1);
            l_y = obj.coords(obj.Tnod(el,2),2) - obj.coords(obj.Tnod(el,1),2);
            l = sqrt(l_x^2 + l_y^2);
        end

        function K = AxialStiffnessMatrixComputer(obj,el)
            [~,~,l] = ComputeLengthElement(obj,el);
            Kcoef = ((obj.mat(obj.Tmat(el,1),1)*(obj.mat(obj.Tmat(el,1),2)))/l);
            K = Kcoef*[  1    0   0   -1    0     0;
                         0    0   0    0    0     0;
                         0    0   0    0    0     0;
                        -1    0   0    1    0     0;
                         0    0   0    0    0     0;
                         0    0   0    0    0     0]; 
        end

        function K = ShearBendingStiffnessMatrixComputer(obj,el)
          [~,~,l] = ComputeLengthElement(obj,el);
          Kcoef = ((obj.mat(obj.Tmat(el,1),1)*(obj.mat(obj.Tmat(el,1),3)))/l^3);
          K = Kcoef*[   0    0      0    0    0       0   ;
                        0    12    6*l   0   -12     6*l  ;
                        0   6*l   4*l^2  0   -6*l   2*l^2 ;
                        0    0      0    0    0       0   ;
                        0   -12   -6*l   0    12    -6*l  ;
                        0   6*l   2*l^2  0   -6*l   4*l^2 ];
        end
    end
end
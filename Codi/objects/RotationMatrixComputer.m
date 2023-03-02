classdef RotationMatrixComputer
    properties (Access = private)
        Tnod
        coords
        nnodes
        nDOFnode
    end

    methods
        function obj = RotationMatrixComputer(cParams)
            obj.Tnod = cParams.Tnod;
            obj.coords = cParams.coords;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end

        function R = compute(obj)
            nel = size(obj.Tnod,1);
            nnodel = size(obj.Tnod,2);
            nDOFel = nnodel*obj.nDOFnode;
            R = zeros(nDOFel,nDOFel,nel);
            for i=1:nel
                [l_x,l_y,l] = ComputeLengthElement(obj,i);
                Re=[  l_x   l_y    0    0     0    0;
                     -l_y   l_x    0    0     0    0;
                       0     0     l    0     0    0;
                       0     0     0   l_x   l_y   0;
                       0     0     0  -l_y   l_x   0;
                       0     0     0    0     0    l];
                R(:,:,i) = Re/l;
            end
        end
    end

    methods (Access = private)
        function [l_x,l_y,l] = ComputeLengthElement(obj,el)
            l_x = obj.coords(obj.Tnod(el,2),1) - obj.coords(obj.Tnod(el,1),1);
            l_y = obj.coords(obj.Tnod(el,2),2) - obj.coords(obj.Tnod(el,1),2);
            l = sqrt(l_x^2 + l_y^2);
        end
    end
end
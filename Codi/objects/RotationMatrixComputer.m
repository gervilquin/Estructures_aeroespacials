classdef RotationMatrixComputer < handle
    properties (Access = private)
        Tnod
        coords
        nnodes
        nDOFnode
    end

    methods
        function obj = RotationMatrixComputer(cParams)
            obj = obj.init(cParams);
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
        function [l_x,l_y,l] = ComputeLengthElement(obj,el) %% This function should include an object 'computerLengthElement' 
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

        function obj = init(obj,cParams)
            obj.Tnod = cParams.Tnod;
            obj.coords = cParams.coords;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end
    end
end
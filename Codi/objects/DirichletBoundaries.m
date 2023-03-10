classdef DirichletBoundaries < handle
    properties
        nDOFnode
        nnodes
        fixNodes
    end

    methods
        function obj = DirichletBoundaries(cParams)
            obj = obj.init(cParams);
        end

        function [BC] = apply(obj)
            nDOF = obj.nDOFnode*obj.nnodes;
            fixDOF  = obj.fixNodes(:,2);
            BC.vR=obj.nDOFnode*(obj.fixNodes(:,1)-1) + fixDOF; %% Used on previous classes
            BC.vL=setdiff(1:nDOF,BC.vR)';
            BC.uR=obj.fixNodes(:,3);
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            obj.nDOFnode = cParams.nDOFnode;
            obj.nnodes = cParams.nnodes;
            obj.fixNodes = cParams.fixNodes;
        end
    end
end
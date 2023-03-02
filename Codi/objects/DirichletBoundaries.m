classdef DirichletBoundaries
    properties
        nDOFnode
        nnodes
        fixNodes
    end

    methods
        function obj = DirichletBoundaries(cParams)
            obj.nDOFnode = cParams.nDOFnode;
            obj.nnodes = cParams.nnodes;
            obj.fixNodes = cParams.fixNodes;
        end

        function [BC] = apply(obj)
            nDOF = obj.nDOFnode*obj.nnodes;
            
            BC.vR=obj.nDOFnode*obj.fixNodes(:,1)-(obj.nDOFnode-obj.fixNodes(:,2));
            BC.vL=setdiff(1:nDOF,BC.vR)';
            BC.uR=obj.fixNodes(:,3);
        end
    end
end
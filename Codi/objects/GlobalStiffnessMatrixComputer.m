classdef GlobalStiffnessMatrixComputer < handle
    properties (Access = private)
         Kel 
         Tnod
         nnodes
         nDOFnode
    end

    methods
        function obj = GlobalStiffnessMatrixComputer(cParams) % Constructor parameters
            obj = obj.init(cParams);
        end

        function K = compute(obj)
            nDOFs = obj.nnodes*obj.nDOFnode;
            nel = size(obj.Kel,3);
            K = sparse(nDOFs,nDOFs);
            for e=1:nel
                gDOFnodeA = obj.nDOFnode*(obj.Tnod(e,1)-1)+(1:obj.nDOFnode); % This operation is repeated at ForceVectorComputer, convert to class.
                gDOFnodeB = obj.nDOFnode*(obj.Tnod(e,2)-1)+(1:obj.nDOFnode); 
                DOF = [gDOFnodeA, gDOFnodeB];
                K(DOF,DOF)=K(DOF,DOF)+obj.Kel(:,:,e);
            end
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            obj.Kel = cParams.Kel;
            obj.Tnod = cParams.Tnod;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end
    end
end
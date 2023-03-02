classdef GlobalStiffnessMatrixComputer
    properties (Access = private)
         Kel 
         Tnod
         nnodes
         nDOFnode
    end

    methods
        function obj = GlobalStiffnessMatrixComputer(cParams) % Constructor parameters

            obj.Kel = cParams.Kel;
            obj.Tnod = cParams.Tnod;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;

        end

        function K = compute(obj)
            nDOFs = obj.nnodes*obj.nDOFnode;
            nel = size(obj.Kel,3);
            K = sparse(nDOFs,nDOFs);
            for e=1:nel
                DOF = [obj.nDOFnode*(obj.Tnod(e,1)-1)+(1:obj.nDOFnode), obj.nDOFnode*(obj.Tnod(e,2)-1)+(1:obj.nDOFnode) ];
                K(DOF,DOF)=K(DOF,DOF)+obj.Kel(:,:,e);
            end

        end
    end
end
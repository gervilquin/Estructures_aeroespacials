classdef ForceVectorComputer < handle
    properties (Access = private)
        Fdata
        nnodes
        nDOFnode
    end

    methods
        function obj = ForceVectorComputer(cParams)
            obj = obj.init(cParams);
        end

        function F = compute(obj)
            nDOFs = obj.nnodes*obj.nDOFnode;
            F=zeros(nDOFs,1);
            [rownum , ~]=size(obj.Fdata);
            for i=1:rownum
                node    = obj.Fdata(i,1);
                nodeDOF = obj.Fdata(i,2);
                fval    = obj.Fdata(i,3);
                fDOF = obj.nDOFnode*(node-1) + nodeDOF;
         
                F(fDOF,1)= fval;
            end
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            obj.Fdata = cParams.Fdata;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end
    end
end
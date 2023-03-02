classdef ForceVectorComputer
    properties (Access = private)
        Fdata
        nnodes
        nDOFnode
    end

    methods
        function obj = ForceVectorComputer(cParams)
            obj.Fdata = cParams.Fdata;
            obj.nnodes = cParams.nnodes;
            obj.nDOFnode = cParams.nDOFnode;
        end

        function F = compute(obj)
            nDOFs = obj.nnodes*obj.nDOFnode;
            F=zeros(nDOFs,1);
            [rownum , ~]=size(obj.Fdata);
            for i=1:rownum
                F(obj.nDOFnode*(obj.Fdata(i,1)-1) + obj.Fdata(i,2),1)= obj.Fdata(i,3);
            end
        end
    end
end
classdef TestGlobalForceVector < handle
    properties
        testIn
        testOut
        tol
    end

    methods (Access = public)
        function obj = TestGlobalForceVector(cParams)
            obj.testIn = cParams.testIn;
            obj.testOut = cParams.testOut;
            obj.tol = cParams.tol;
        end

        function test(obj)
            n_i = obj.testIn.nDOFnode;
            n_nodes = obj.testIn.nnodes;
            Fdata = obj.testIn.Fdata;
            testRes = computeF(n_i,n_nodes,Fdata);
            PrintResults(obj,testRes);
        end
    end

    methods (Access = private)
        function PrintResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 2: Global force vector assembly = SUCCESS')
            else
                disp('TEST 2: Global force vector assembly = FAILED')
            end
        end
    end
end
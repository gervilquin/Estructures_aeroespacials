classdef TestGlobalStiffnessMatrix < handle
    properties
        testIn
        testOut
        tol
    end

    methods (Access = public)
        function obj = TestGlobalStiffnessMatrix(cParams)
            obj.testIn = cParams.testIn;
            obj.testOut = cParams.testOut;
            obj.tol = cParams.tol;
        end

        function test(obj)
            k = GlobalStiffnessMatrixComputer(obj.testIn);
            testRes = k.compute(); 
            PrintResults(obj,testRes);
        end
    end

    methods (Access = private)
        function PrintResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 1: Stiffness matrix assembly process = SUCCESS')
            else
                disp('TEST 1: Stiffness matrix assembly process = FAILED')
            end
        end
    end
end
classdef TestForceVector < handle
    properties
        testIn
        testOut
        tol
    end

    methods (Access = public)
        function obj = TestForceVector(cParams)
            obj.testIn = cParams.testIn;
            obj.testOut = cParams.testOut;
            obj.tol = cParams.tol;
        end

        function test(obj)
            f = ForceVectorComputer(obj.testIn);
            testRes = f.compute();
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
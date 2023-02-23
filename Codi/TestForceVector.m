classdef TestForceVector < test
    methods (Access = public)
        function obj = TestForceVector(cParams)
            obj = obj@test(cParams);
        end

        function run(obj)
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
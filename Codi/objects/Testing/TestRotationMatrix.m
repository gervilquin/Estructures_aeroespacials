classdef TestRotationMatrix < test

    methods (Access = public)
        function obj = TestRotationMatrix(cParams)
            obj = obj@test(cParams);
        end

        function run(obj)
            c = RotationMatrixComputer(obj.testIn);
            testRes = c.compute();
            printResults(obj,testRes);
        end
    end

    methods (Access = private)
        function printResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 5: Rotation Matrix Computer = SUCCESS')
            else
                disp('TEST 5: Rotation Matrix Computer = FAILED')
            end
        end
    end
end
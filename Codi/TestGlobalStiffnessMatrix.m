classdef TestGlobalStiffnessMatrix < test
    methods (Access = public)
        function obj = TestGlobalStiffnessMatrix(cParams)
            obj = obj@test(cParams);
        end

        function run(obj)
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
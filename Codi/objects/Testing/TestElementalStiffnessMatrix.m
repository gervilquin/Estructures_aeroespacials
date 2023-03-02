classdef TestElementalStiffnessMatrix < test
    methods (Access = public)
        function obj = TestElementalStiffnessMatrix(cParams)
            obj = obj@test(cParams);
        end

        function run(obj)
            %kel = ElementalStiffnessMatrixComputer(obj.testIn);
            %testRes = kel.compute();
            testRes = 0;
            PrintResults(obj,testRes);
        end
    end

    methods (Access = private)
        function PrintResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 6: Elemental stiffness matrix computer = SUCCESS')
            else
                disp('TEST 6: Elemental stiffness matrix computer = FAILED')
            end
        end
    end
end
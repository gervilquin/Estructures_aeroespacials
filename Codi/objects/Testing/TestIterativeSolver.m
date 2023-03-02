classdef TestIterativeSolver < test
    methods (Access = public)
        function obj = TestIterativeSolver(cParams)
            obj = obj@test(cParams);
        end

        function run(obj)
            s = Solver.create(obj.testIn);
            testRes = s.solve();
            PrintResults(obj,testRes);
        end
    end

    methods (Access = private)
        function PrintResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 3: Iterative solver = SUCCESS')
            else
                disp('TEST 3: Iterative solver = FAILED')
            end
        end
    end
end
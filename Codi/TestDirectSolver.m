classdef TestDirectSolver < handle
    properties
        testIn
        testOut
        tol
    end

    methods (Access = public)
        function obj = TestDirectSolver(cParams)
            obj.testIn = cParams.testIn;
            obj.testOut = cParams.testOut;
            obj.tol = cParams.tol;
        end

        function test(obj)
            s = Solver.create(obj.testIn);
            testRes = s.solve();
            PrintResults(obj,testRes);
        end
    end

    methods (Access = private)
        function PrintResults(obj,testRes)
            err = max(max(abs(testRes - obj.testOut)));
            if err < obj.tol
                disp('TEST 4: Direct solver = SUCCESS')
            else
                disp('TEST 4: Direct solver = FAILED')
            end
        end
    end
end
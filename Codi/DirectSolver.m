classdef DirectSolver < Solver

    methods (Access = public)
        function obj = DirectSolver(cParams)
            obj = obj.init(cParams);
        end
    end

    methods (Access = public)
        function Result = solve(obj)
            Result = obj.LHS\obj.RHS;
        end
    end
end
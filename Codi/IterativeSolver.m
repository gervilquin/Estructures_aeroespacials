classdef IterativeSolver < Solver

    methods (Access = public)
        function obj = IterativeSolver(cParams)
            obj = obj.init(cParams);
        end
    end

    methods (Access = public)
        function Result = solve(obj)
            Result = pcg(obj.LHS,obj.RHS);
        end
    end
end
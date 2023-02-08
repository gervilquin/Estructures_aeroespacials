classdef IterativeSolver < Solver

    methods
        function obj = IterativeSolver(Inputs)
            obj = obj@Solver(Inputs);
        end

        function Result = solve(obj)
            Result = pcg(obj.LHS,obj.RHS);
        end

    end
end
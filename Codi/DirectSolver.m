classdef DirectSolver < Solver

    methods
        function obj = DirectSolver(Inputs)
            obj = obj@Solver(Inputs);
        end

        function Result = solve(obj)
            Result = obj.LHS\obj.RHS;
        end

    end
end
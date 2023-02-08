classdef Solver
    properties
        LHS
        RHS
    end

    methods
        function obj = Solver(Inputs)
            obj.LHS = Inputs.LHS;
            obj.RHS = Inputs.RHS;
        end
    end
    
    methods (Abstract)
        solve()
    end
end
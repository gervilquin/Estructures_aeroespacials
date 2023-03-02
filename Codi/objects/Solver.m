classdef Solver < handle
    properties (Access = protected)
        LHS
        RHS
    end

    methods (Access = public, Static)
        function obj = create(cParams)
            switch cParams.type
                case 'Iterative'
                    obj = IterativeSolver(cParams);
                case 'Direct'
                    obj = DirectSolver(cParams);
            end
        end
    end
    
    methods (Access = public, Abstract)
        solve()
    end

    methods (Access = protected)
        function obj = init(obj,cParams)
            obj.LHS = cParams.LHS;
            obj.RHS = cParams.RHS;
        end
    end
end
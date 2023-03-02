classdef test < handle
    properties (Access = protected)
        testIn
        testOut
        tol
    end

    methods 
        function obj = test(cParams)
            obj.testIn = cParams.testIn;
            obj.testOut = cParams.testOut;
            obj.tol = cParams.tol;
        end
    end

    methods (Access = public, Abstract)
           run()
    end
end
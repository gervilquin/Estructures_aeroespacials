classdef Tester < handle
    methods (Access = public, Static)
        function obj = create(cParams)
            switch cParams.type 
                case 'Complete'
                    obj = CompleteTest(cParams);
                case 'Fast'
                    obj = FastTest(cParams);
            end
        end
    end

    methods (Access = public, Abstract)
           test()
    end

    methods (Access = protected)
        function init(obj,cParams)
            obj.tData = cParams.tData;
        end
    end
end
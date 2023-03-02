classdef Tester < handle
    properties (Access = private)
        test_vector
    end

    methods 
        function obj = Tester(test_vector)
            obj.test_vector = test_vector;
        end

        function run(obj)
            for i=1:length(obj.test_vector)
                obj.test_vector{i}.run();
            end
        end
    end

end
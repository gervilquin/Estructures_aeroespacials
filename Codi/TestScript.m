% TEST SCRIPT %
clc,clear

load('TestData');
test_vector{1} = TestGlobalStiffnessMatrix(testData.t1.d1);
test_vector{2} = TestForceVector(testData.t2.d1);
test_vector{3} = TestIterativeSolver(testData.t3.d1);
test_vector{4} = TestDirectSolver(testData.t4.d1);
test_vector{5} = TestRotationMatrix(testData.t5.d1);
test_vector{6} = TestElementalStiffnessMatrix(testData.t6.d1); 
t = Tester(test_vector);
t.run();
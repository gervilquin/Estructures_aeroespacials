clc,clear
load('testData');
save('testData_old','testData')
testData.t7.d1.testIn.Tnod = [1 2];
testData.t7.d1.testIn.coords = [0 0; cos(pi/3) sin(pi/3)];
testData.t7.d1.testIn.Tmat = [1];
testData.t7.d1.testIn.mat = [3 5 7];
testData.t7.d1.testIn.nnodes = 2;
testData.t7.d1.testIn.nDOFnode = 3;
testData.t7.d1.tol = 10e-5;
save('testData','testData')
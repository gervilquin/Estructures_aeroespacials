clc,clear
load('testData');
testData.t6.d1.testIn.mat = [1 2];
testData.t6.d1.testIn.Tmat = [0 0; cos(pi/3) sin(pi/3)];
testData.t6.d1.testIn.nnodes = 3;
testData.t6.d1.testIn.nDOFnode = 3;


testData.t6.d1.testIn.R = [];

testData.t6.d1.testOut = [];

testData.t6.d1.tol = 10e-5;


save('testData','testData')
function testStiffnessAssembly()
    %load('testStiffnessAssembly.mat'); TO BE IMPLEMENTED
    % Predefinition of constant test inputs
    Kel_test = ones(2,2,3); Kel_test(:,:,2) = 2*Kel_test(:,:,2); Kel_test(:,:,3) = 3*Kel_test(:,:,3); 
    Tnod_test = [1 2;
                 2 3;
                 3 4];
    nnod_test = 4; 
    nDOFnode_test = 1;
    
    KG_expected = [1 1 0 0;
                   1 3 2 0;
                   0 2 5 3;
                   0 0 3 3];

    % Test of function under test inputs
    KParams_test.Kel = Kel_test ; KParams_test.Tnod = Tnod_test; KParams_test.nnodes = nnod_test; KParams_test.nDOFnode = nDOFnode_test;


    t1Data.testIn = KParams_test;
    t1Data.testOut = KG_expected;
    t1Data.tol = 10e-5;
    TestGlobalStiffnessMatrix(t1Data);

end
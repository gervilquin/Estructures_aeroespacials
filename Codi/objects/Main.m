classdef Main < handle
    properties (Access = private)
        inputs
        results
    end

    methods (Access = public)
        function obj = Main()
            load("Input.mat",'Input')
            obj = obj.init(Input);
            Rot = obj.computeRotationMatrix();
            Kel = obj.computeElementalStiffnessMatrix(Rot);
            K   = obj.computeGlobalStiffnessMatrix(Kel);
            F   = obj.computeGlobalForceVector();
            BC  = obj.applyBoundaryConditions();
            obj.results = obj.solveSystem(K,F,BC);
        end

        function res = getResults(obj)
            res = obj.results;
        end

        function res = getInputs(obj)
            res = obj.inputs;
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            obj.inputs = Inputs(cParams);
        end

        function Rot = computeRotationMatrix(obj)
            Rparams.Tnod     = obj.inputs.getNodesConnectivity(); 
            Rparams.coords   = obj.inputs.getCoords(); 
            Rparams.nnodes   = obj.inputs.getTotalNumberNodes(); 
            Rparams.nDOFnode = obj.inputs.getDOFperNode();
            r = RotationMatrixComputer(Rparams);
            Rot = r.compute();
        end

        function Kel = computeElementalStiffnessMatrix(obj,Rot)
            s.Tnod     = obj.inputs.getNodesConnectivity();
            s.coords   = obj.inputs.getCoords();
            s.mat      = obj.inputs.getMatProperties();
            s.Tmat     = obj.inputs.getMatConnectivity();
            s.Rot      = Rot; 
            s.nnodes   = obj.inputs.getTotalNumberNodes();  
            s.nDOFnode = obj.inputs.getDOFperNode();
            k = ElementalStiffnessMatrixComputer(s);
            Kel = k.compute();
        end

        function KG = computeGlobalStiffnessMatrix(obj,Kel)
            Kparams.Kel      = Kel; 
            Kparams.Tnod     = obj.inputs.getNodesConnectivity(); 
            Kparams.nnodes   = obj.inputs.getTotalNumberNodes(); 
            Kparams.nDOFnode = obj.inputs.getDOFperNode();
            k = GlobalStiffnessMatrixComputer(Kparams);
            KG = k.compute();
        end

        function Fext = computeGlobalForceVector(obj)
            Fparams.Fdata    = obj.inputs.getNeumannBC(); 
            Fparams.nnodes   = obj.inputs.getTotalNumberNodes();
            Fparams.nDOFnode = obj.inputs.getDOFperNode();
            f = ForceVectorComputer(Fparams);
            Fext = f.compute();
        end

        function BC = applyBoundaryConditions(obj)
            BCparams.nDOFnode = obj.inputs.getDOFperNode();
            BCparams.nnodes   = obj.inputs.getTotalNumberNodes();
            BCparams.fixNodes = obj.inputs.getDirichletBC();
            d = DirichletBoundaries(BCparams);
            BC = d.apply();
        end

        function Res = solveSystem(obj,K,F,BC)
            SolParams.K        = K; 
            SolParams.F        = F; 
            SolParams.BC       = BC; 
            SolParams.nDOFnode = obj.inputs.getDOFperNode();
            SolParams.nnodes   = obj.inputs.getTotalNumberNodes();
            SolParams.type     = obj.inputs.getType();
            s = SystemSolver(SolParams);
            Res = s.solve();
        end
    end
end
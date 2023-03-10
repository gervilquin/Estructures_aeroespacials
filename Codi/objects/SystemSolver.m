classdef SystemSolver < handle
    properties (Access = private)
        BC
        K
        F
        nDOFnode
        nnodes
        type
    end

    methods
        function obj = SystemSolver(cParams)
            obj = obj.init(cParams);
        end

        function Res = solve(obj)
            Matrices = obj.SplitSystem();
            Res.u = obj.computeDisplacements(Matrices);
            Res.R = obj.computeReactions(Matrices,Res.u);
        end
    end

    methods (Access = private)
        function obj = init(obj,cParams)
            obj.BC = cParams.BC;
            obj.K = cParams.K;
            obj.F = cParams.F;
            obj.nDOFnode = cParams.nDOFnode;
            obj.nnodes = cParams.nnodes;
            obj.type = cParams.type;
        end

        function Matrices = SplitSystem(obj)
            vL = obj.BC.vL;
            vR = obj.BC.vR;
            Matrices.KLL=obj.K(vL,vL);
            Matrices.KLR=obj.K(vL,vR);
            Matrices.KRL=obj.K(vR,vL);
            Matrices.KRR=obj.K(vR,vR);
            Matrices.FL=obj.F(vL);
            Matrices.FR=obj.F(vR);
        end

        function u = computeDisplacements(obj,Matrices)
            nDOF = obj.nDOFnode*obj.nnodes;
            u = zeros(nDOF,1);
            uR = obj.BC.uR;
            vL = obj.BC.vL;
            vR = obj.BC.vR;
            SParam.LHS = Matrices.KLL; 
            SParam.RHS = (Matrices.FL - Matrices.KLR*uR);
            SParam.type = obj.type;
            s = Solver.create(SParam);
            uL = s.solve();
            u(vL,1)=uL;
            u(vR,1)=uR;
        end

        function R = computeReactions(obj,Matrices,u)
            nDOF = obj.nDOFnode*obj.nnodes;
            R = zeros(nDOF,1);      
            vL = obj.BC.vL;
            vR = obj.BC.vR;
            RR= Matrices.KRR*u(vR,1) + Matrices.KRL*u(vL,1) - Matrices.FR;
            R(vR,1)=RR;
        end
    end
end
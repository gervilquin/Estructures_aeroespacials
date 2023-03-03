classdef SystemSolver
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
            obj.BC = cParams.BC;
            obj.K = cParams.K;
            obj.F = cParams.F;
            obj.nDOFnode = cParams.nDOFnode;
            obj.nnodes = cParams.nnodes;
            obj.type = cParams.type;
        end

        function Res = solve(obj)
            nDOF = obj.nDOFnode*obj.nnodes;
            Res.R = zeros(nDOF,1); Res.u = zeros(nDOF,1);

            vL = obj.BC.vL;
            K_LL=obj.K(vL,vL);
            K_LR=obj.K(obj.BC.vL,obj.BC.vR);
            K_RL=obj.K(obj.BC.vR,obj.BC.vL);
            K_RR=obj.K(obj.BC.vR,obj.BC.vR);
            F_L=obj.F(obj.BC.vL);
            F_R=obj.F(obj.BC.vR);
            
            SParam.LHS = K_LL; SParam.RHS = (F_L-K_LR*obj.BC.uR);
            SParam.type = obj.type;
            s = Solver.create(SParam);
            uL = s.solve();

            RR=K_RR*obj.BC.uR+K_RL*uL-F_R;
            Res.u(obj.BC.vL,1)=uL;
            Res.u(obj.BC.vR,1)=obj.BC.uR;
            Res.R(obj.BC.vR,1)=RR;
        end
    end
end
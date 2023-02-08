function [u,R] = solveSys(vL,vR,uR,KG,Fext)

[rownum,~]=size(KG);
R=zeros(rownum,1);

K_LL=KG(vL,vL);
K_LR=KG(vL,vR);
K_RL=KG(vR,vL);
K_RR=KG(vR,vR);
F_L=Fext(vL);
F_R=Fext(vR);

%uL=K_LL\(F_L-K_LR*uR);
SParam.LHS = K_LL; SParam.RHS = (F_L-K_LR*uR); SParam.switcher = 1;
%s = IterativeSolver(SParam);
s = DirectSolver(SParam);
uL = s.solve();
RR=K_RR*uR+K_RL*uL-F_R;

u(vL,1)=uL;
u(vR,1)=uR;
R(vR,1)=RR;

%--------------------------------------------------------------------------
% The function takes as inputs:
%   - vL      Free degree of freedom vector
%   - vR      Prescribed degree of freedom vector
%   - uR      Prescribed displacement vector
%   - KG      Global stiffness matrix [n_dof x n_dof]
%              KG(I,J) - Term in (I,J) position of global stiffness matrix
%   - Fext    Global force vector [n_dof x 1]
%              Fext(I) - Total external force acting on DOF I
%--------------------------------------------------------------------------
% It must provide as output:
%   - u       Global displacement vector [n_dof x 1]
%              u(I) - Total displacement on global DOF I
%   - R       Global reactions vector [n_dof x 1]
%              R(I) - Total reaction acting on global DOF I
%--------------------------------------------------------------------------




end
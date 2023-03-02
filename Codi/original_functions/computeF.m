function Fext = computeF(n_i,n_nodes,Fdata)
n_dof = n_nodes*n_i;
Fext=zeros(n_dof,1);
[rownum , ~]=size(Fdata);

for i=1:rownum
    Fext(n_i*Fdata(i,1)-(n_i-Fdata(i,2)),1)=Fdata(i,3);
end

%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_i         Number of DOFs per node
%                  n_dof       Total number of DOFs
%   - Fdata  External nodal forces [Nforces x 3]
%            Fdata(k,1) - Node at which the force is applied
%            Fdata(k,2) - DOF (direction) at which the force acts
%            Fdata(k,3) - Force magnitude in the corresponding DOF
%--------------------------------------------------------------------------
% It must provide as output:
%   - Fext  Global force vector [n_dof x 1]
%            Fext(I) - Total external force acting on DOF I
%--------------------------------------------------------------------------
% Hint: Use the relation between the DOFs numbering and nodal numbering to
% determine at which DOF in the global system each force is applied.



end
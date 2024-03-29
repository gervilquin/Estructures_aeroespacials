function Td = connectDOFs(n_el,n_nod,n_i,Tnod)

matrix=zeros(n_el,n_nod,n_i);
Td=zeros(n_el,1);

for i=1:n_i
    matrix(:,:,i)=n_i*Tnod-(n_i-i);
end

for j=1:n_nod
        Td=[Td squeeze(matrix(:,j,:))];
end

Td(:,1)=[];

%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_el     Total number of elements
%                  n_nod    Number of nodes per element
%                  n_i      Number of DOFs per node
%   - Tn    Nodal connectivities table [n_el x n_nod]
%            Tn(e,a) - Nodal number associated to node a of element e
%--------------------------------------------------------------------------
% It must provide as output:
%   - Td    DOFs connectivities table [n_el x n_el_dof]
%            Td(e,i) - DOF i associated to element e
%--------------------------------------------------------------------------
% Hint: Use the relation between the DOFs numbering and nodal numbering.



end
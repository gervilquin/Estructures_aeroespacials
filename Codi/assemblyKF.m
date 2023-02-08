            function [KG] = assemblyKF(n_el,n_nod,n_i,nnod,Kel,Td)

n_el_dof=n_nod*n_i;


KG = zeros(nnod*n_i);

    for e=1:n_el
        for i=1:n_el_dof
            for j=1:n_el_dof
                KG(Td(e,i),Td(e,j))=KG(Td(e,i),Td(e,j))+Kel(i,j,e);
            end
        end
    end
    
end


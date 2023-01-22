function [Fx,Fy,Mz] = internalFM(n_el,n_nod,n_i,u,Kel,Rot,Td)

n_dof = n_nod*n_i;
u_el = zeros(n_dof,1);
Fx = zeros(n_el,n_nod);
Fy = zeros(n_el,n_nod);
Mz = zeros(n_el,n_nod);

    for i=1:n_el
        for j=1:n_dof
            u_el(j,1)=u(Td(i,j));
        end
        F_int=Kel(:,:,i)*u_el;
        F_int_local = Rot(:,:,i)*F_int;

        Fx(i,1) = -F_int_local(n_i-2);
        Fx(i,2) = F_int_local(2*n_i-2);
        Fy(i,1) = -F_int_local(n_i-1);
        Fy(i,2) = F_int_local(2*n_i-1);
        Mz(i,1) = -F_int_local(n_i);
        Mz(i,2) = F_int_local(2*n_i);
    end

end


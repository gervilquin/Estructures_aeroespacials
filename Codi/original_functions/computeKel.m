function [Kel] = computeKel(n_el,n_i,n_nod,R,l_e,mat,Tmat)

% Code only valid for 2D cases with shear, bendind and axial stress. (Change matrix K to adapt)

Kel = zeros(n_nod*n_i,n_nod*n_i,n_el);

for i=1:n_el
      K_1 = [   0       0              0        0        0              0;
                0       12         6*l_e(i,1)   0       -12         6*l_e(i,1);
                0   6*l_e(i,1)   4*l_e(i,1)^2   0   -6*l_e(i,1)    2*l_e(i,1)^2;
                0       0              0        0        0              0;
                0      -12        -6*l_e(i,1)   0        12         -6*l_e(i,1);
                0    6*l_e(i,1)   2*l_e(i,1)^2  0   -6*l_e(i,1)    4*l_e(i,1)^2
          ];
      
      K_1 = ((mat(Tmat(i,1),1)*(mat(Tmat(i,1),3)))/l_e(i,1)^3)*K_1;
      
      K_2 = [  1    0   0   -1    0     0;
               0    0   0    0    0     0;
               0    0   0    0    0     0;
              -1    0   0    1    0     0;
               0    0   0    0    0     0;
               0    0   0    0    0     0];
           
      K_2 = ((mat(Tmat(i,1),1)*(mat(Tmat(i,1),2)))/l_e(i,1))*K_2;
      
      K = K_1 + K_2;
      
      Kel(:,:,i)=transpose(R(:,:,i))*K*R(:,:,i);
end

end


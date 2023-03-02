function [l_e,R] = computeR(n_el,n_d,n_nod,n_i,Tnod,x)

% Code only valid for 2D cases with shear,bendind and axial stress. (Change R to adapt)

element_position=zeros(n_el,n_d,n_nod);
l=zeros(n_el,n_d); %1)dx 2)dy ...
l_e=zeros(n_el,1); %element's lenght matrix
R = zeros(2*n_i,2*n_i,n_el);

for i=1:n_el
    for j=1:n_d
        for k=1:n_nod
            element_position(i,j,k)=x(Tnod(i,k),j);
        end
    end
end

for i=1:n_el
    for j=1:n_d
        l(i,j)=element_position(i,j,2)-element_position(i,j,1);
        l_e(i,1)=l_e(i,1)+l(i,j).^2;
    end
    l_e(i,1)=sqrt(l_e(i,1));
    
    % Change R to adapt
    R_e=[ l(i,1)   l(i,2)     0         0       0        0;
         -l(i,2)   l(i,1)     0         0       0        0;
             0          0   l_e(i,1)    0       0        0;
             0          0     0      l(i,1)   l(i,2)     0;
             0          0     0     -l(i,2)   l(i,1)     0;
             0          0     0         0       0     l_e(i,1)];
        
    R(:,:,i)=R_e./l_e(i,1);
end


end


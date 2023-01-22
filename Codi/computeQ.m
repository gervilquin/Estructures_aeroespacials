function [Q] = computeQ(n_el,l,Tnod,x,L1,L2,M,g)

lambda_1 = @(x) (((3.*M)./(2.*L1.^2)).*(L1-x)+(M./(4.*(L1+L2))));
lambda_2 = M./(4.*(L1+L2));

lift_1 = @(x) l.*(0.85-0.15.*cos(pi.*x./L1));
lift_2 = @(x) -l.*((L1-L2-x).*(L1+L2-x))./L2.^2;

Q = zeros(n_el,1);

    for i=1:n_el
        if x(Tnod(i,1))<L1
        weight=g*integral(lambda_1,x(Tnod(i,1)),x(Tnod(i,2)));
        lift=integral(lift_1,x(Tnod(i,1)),x(Tnod(i,2)));
        Q(i,1)=lift-weight;
        
        else
        weight=g*lambda_2*(x(Tnod(i,2))-x(Tnod(i,1)));
        lift=integral(lift_2,x(Tnod(i,1)),x(Tnod(i,2)));
        Q(i,1)=lift-weight;
        end    
    end
end


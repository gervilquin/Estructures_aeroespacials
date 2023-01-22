function l = computeL(M,Me,L1,L2,g)

wing_1 = @(x) g.*(((3.*M)./(2.*L1.^2)).*(L1-x)+(M./(4.*(L1+L2))));
wing_2 = g.*M./(4.*(L1+L2));

%Wing weight
w_1=integral(wing_1,0,L1);
w_2=(L2)*wing_2;
W_w=w_1+w_2;


lift_1 = @(x) (0.85-0.15.*cos(pi.*x./L1));
lift_2 = @(x) -((L1-L2-x).*(L1+L2-x))./L2^2;


%Engine weight
W_e=Me*g;

%Total lift force
l_1=integral(lift_1,0,L1);
l_2=integral(lift_2,L1,L1+L2);
L_f=l_1+l_2;

% l calculation
l=(W_w+W_e)/L_f;

end


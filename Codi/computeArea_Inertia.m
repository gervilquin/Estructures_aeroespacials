function [A,I] = computeArea_Inertia(a,b,h,t)
% a = web thickness
% b = top/bottom width
% h = distance between centroids of wing areas (NOT Web height)
% t = top/bottom thickness 

% Y direction = only crosses web rectangle
% Z direction = crosses top,web and bottom rectangles

% Area calculation
A_1=b*t; % Top/bottom area
A_2=(h-t)*a; % Mid area


A_m=[A_1; A_2; A_1];
A=sum(A_m);

% Centroid of areas (z,y)
C_1=[h/2 0]; % Top/bottom area centroid 
C_2=[0 0];   % Mid area centroid

C_m=[C_1; C_2; -C_1];
n=size(C_m,1);

C=zeros(1,2);

% Centroid
for i=1:2
    for j=1:n
    C(1,i)=C(i)+C_m(j,i)*A_m(j)/A;
    end
end

% Inertia
I_1=[b*t^3/12 b^3*t/12]; %Iy / Iz
I_2=[a*(h-t)^3/12 a^3*(h-t)/12]; %Iy / Iz

I_m=[I_1; I_2; I_1];

I=zeros(1,2);

for i=1:2
    for j=1:n
        I(1,i)=I(1,i)+I_m(j,i)+(A_m(j,1)*C_m(j,i)^2);
    end
end

end


%-------------------------------------------------------------------------%
% EVALUATION PROBLEM
%-------------------------------------------------------------------------%
% Date: 06/05/2020
% Author/s: Gerard Villalta
%
%TODO
%struct
% not entering obj
% tests in other script out of main
% function should just do 1 thing
%Intial data in a class... design class to maximize cohesion
% class herencia de handle
% main a class
% UML
%Task 5 i 6

clear;
close all;
addpath(genpath('original_functions/'));
addpath(genpath('objects/'));

%% INPUT DATA

% Material properties
E = 150e9; % Pa

% Cross-section parameters
d = 205e-3; % m
tA = 10e-3; % m
tB = 4e-3; % m
tC = 3e-3; % m
a = 60e-3; % m
b = 80e-3; % m
c = 70e-3; % m

% Other data
L = 0.5; % m
H1 = 0.90; % m
H2 = 1.70; % m
alpha = deg2rad(12); % rad (12º)
rw = 0.48; % m
I0 = 330;%163*sqrt(2); % kg m2
dt = 0.95; %1.5/2; % s
mu = 0.4; %0.45/sqrt(2); 
V = 285/3.6; % m/s (285 km/h)
%% PRECOMPUTATIONS

% Compute section properties AA, AB, AC (area), IzA, IzB, IzC (inertia) 
AA=pi*(d*tA);
IzA=(pi/4)*(((d+tA)/2)^4-((d-tA)/2)^4);

AB=2*a*tB+b*tB;
IzB=2*(a*tB*((b/2)^2))+(tB*b^3)/12;

AC=(a+c)*tC;
C_y= (c*tC*c/2)/AC; %Y coordinate of section's centroid
IzC=((((tC^3)*a)/12)+a*tC*(C_y)^2)+((c^3)*tC)/12+c*tC*((c/2)-C_y)^2;

% Compute forces (normal N and friction F)
N = (I0*V)/(dt*mu*rw^2);
F = mu*N;

%% PREPROCESS

% Nodal coordinates
%  x(a,j) = coordinate of node a in the dimension j
x = [
    0,         0; % Node 1
    L,        H2; % Node 2
    0,        H2; % Node 3
    0,     H2-H1; % Node 4
    0,   H2-H1/2; % Node 5
  L/3, H2-2*H1/3; % Node 6
];

% Nodal connectivities  
%  Tnod(e,a) = global nodal number associated to node a of element e
Tnod = [
    1, 4; % Element 1-4
    4, 5; % Element 4-5
    5, 3; % Element 5-3
    2, 6; % Element 2-6
    6, 4; % Element 6-4
    6, 5; % Element 6-5
];


% Fix nodes matrix creation
%  fixNod(k,1) = node at which some DOF is prescribed
%  fixNod(k,2) = DOF prescribed
%  fixNod(k,3) = prescribed displacement in the corresponding DOF (0 for fixed)
fixNod = [% Node        DOF  Magnitude
             2           1    0;
             2           2    0;
             2           3    0;
             3           1    0;
             3           2    0;
             3           3    0;
];

% External force matrix creation
%  Fdata(k,1) = node at which the force is applied
%  Fdata(k,2) = DOF (direction) at which the force is applied
%  Fdata(k,3) = force magnitude in the corresponding DOF
Fdata = [%   Node              DOF            Magnitude
             1                  1         N*sin(alpha)-F*cos(alpha);
             1                  2         N*cos(alpha)+F*sin(alpha);

];

% Material properties matrix
%  mat(m,1) = Young modulus of material m
%  mat(m,2) = Section area of material m
%  mat(m,3) = Section inertia of material m
mat = [% Young M.        Section A.    Inertia 
               E,               AA,        IzA;  % Material 1
               E,               AB,        IzB;  % Material 2
               E,               AC,        IzC;  % Material 3
];

% Material connectivities
%  Tmat(e) = Row in mat corresponding to the material associated to element e 
Tmat = [
    1; % Element 1-4 / Material 1 (A)
    1; % Element 4-5 / Material 1 (A)
    1; % Element 5-3 / Material 1 (A)
    2; % Element 2-6 / Material 2 (B)
    2; % Element 6-4 / Material 2 (B)
    3; % Element 6-5 / Material 3 (C)
];

nnodes = size(x,1);
nDOFnode = 3; %Node dimensions
nel = size(Tnod,1);

%% SOLVER
    
% Obtain connectivity table of degrees of freedom
%Td = connectDOFs(nel,2,nDOFnode,Tnod);

% Compute rotation matrix and elements' length
%[l_e,Rot] = computeR(nel,2,2,nDOFnode,Tnod,x);
Rparams.Tnod     = Tnod; 
Rparams.coords   = x; 
Rparams.nnodes   = nnodes; 
Rparams.nDOFnode = nDOFnode;
r = RotationMatrixComputer(Rparams);
Rot = r.compute();

% Compute stifness matrix
%[Kel] = computeKel(nel,nDOFnode,2,Rot,l_e,mat,Tmat);
s.Tnod     = Tnod;
s.coords   = x;
s.mat      = mat;
s.Tmat     = Tmat;
s.Rot      = Rot; 
s.nnodes   = nnodes; 
s.nDOFnode = nDOFnode;
k = ElementalStiffnessMatrixComputer(s);
Kel = k.compute();

% Compute force vector
%[Fext] = computeF(n_i,nnod,Fdata);
Fparams.Fdata    = Fdata; 
Fparams.nnodes   = nnodes; 
Fparams.nDOFnode = nDOFnode;
f = ForceVectorComputer(Fparams);

% Compute stiffness matrix and force matrix in global coordinates
%[KG] = assemblyKF(n_el,n_nod,n_i,nnod,Kel,Td);
Kparams.Kel      = Kel; 
Kparams.Tnod     = Tnod; 
Kparams.nnodes   = nnodes; 
Kparams.nDOFnode = nDOFnode;
k = GlobalStiffnessMatrixComputer(Kparams);

KG = k.compute();
Fext = f.compute();

% Applying boundary conditions
%[vL,vR,uR] = applyCond(nDOFnode,nnodes,fixNod);
BCparams.nDOFnode = nDOFnode; 
BCparams.nnodes   = nnodes; 
BCparams.fixNodes = fixNod;
d = DirichletBoundaries(BCparams);
BC = d.apply();

% Solve equations' system
%[u,R] = solveSys(vL,vR,uR,KG,Fext);
SolParams.K        = KG; 
SolParams.F        = Fext; 
SolParams.BC       = BC; 
SolParams.nDOFnode = nDOFnode; 
SolParams.nnodes   = nnodes;
SolParams.type     = type.Iterative;
s = SystemSolver(SolParams);
Results = s.solve();

% Compute internal forces and momentums
%[Fx_el,Fy_el,Mz_el] = internalFM(nel,n_nod,nDOFnode,u,Kel,Rot,Td);


%% POSTPROCESS

% Plot of the deformed structure
u = Results.u;
plotBeam2D(x,Tnod,u,20);

% Plot of the internal forces distribution
%plotBeamIntForces(x,Tnod,Fx_el,Fy_el,Mz_el);
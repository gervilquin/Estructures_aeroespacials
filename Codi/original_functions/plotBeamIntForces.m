function plotBeamIntForces(x,Tnod,Fx_el,Fy_el,Mz_el)
% PLOTBEAMINTFORCES - Plot internal forces distribution for the 2D beam
% problem
% Inputs:
%   x        Nodal coordinates matrix
%   Tnod     Nodal connectivities matrix
%   Fx_el    Elemental axial forces [nel x 2]: values of the axial forces
%            at each element's nodes
%   Fy_el    Elemental shear forces [nel x 2]: values of the shear forces
%            at each element's nodes
%   Mz_el    Elemental bending moments [nel x 2]: values of the bending
%            moment at each element's nodes

figure

% Local coordinates (beam 1-3)
l13 = reshape(sqrt((x(Tnod(1:3,:),1)-x(Tnod(1,1),1)).^2 + (x(Tnod(1:3,:),2)-x(Tnod(1,1),2)).^2),size(Tnod(1:3,:)));

% Local coordinates (beam 2-4)
l24 = reshape(sqrt((x(Tnod(4:5,:),1)-x(Tnod(4,1),1)).^2 + (x(Tnod(4:5,:),2)-x(Tnod(4,1),2)).^2),size(Tnod(4:5,:)));

% Local coordinates (beam 6-5)
l65 = reshape(sqrt((x(Tnod(6,:),1)-x(Tnod(6,1),1)).^2 + (x(Tnod(6,:),2)-x(Tnod(6,1),2)).^2),size(Tnod(6,:)));

Fxmin = min([0,min(Fx_el(:))]);
Fxmax = max([0,max(Fx_el(:))]);

subplot(3,3,1)
hold on
grid on
box on
plot(l13',zeros(size(l13')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l13',Fx_el(1:3,:)','color','b','linewidth',2.5);
xlabel('Node');
ylabel('Axial (N)');
title('Element 1-3');
% set(gca,'ylim',[Fxmin-0.2*(Fxmax-Fxmin),Fxmax+0.2*(Fxmax-Fxmin)],
set(gca,'xlim',l13([1,6]),'xtick',l13([1,2,3,6]),'xticklabel',[1 4 5 3]);

subplot(3,3,2)
hold on
grid on
box on
plot(l24',zeros(size(l24')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l24',Fx_el(4:5,:)','color','b','linewidth',2.5);
xlabel('Node');
ylabel('Axial (N)');
title('Element 2-4');
% set(gca,'ylim',[Fxmin-0.2*(Fxmax-Fxmin),Fxmax+0.2*(Fxmax-Fxmin)],
set(gca,'xlim',l24([1,4]),'xtick',l24([1,2,4]),'xticklabel',[2,6,4]);

subplot(3,3,3)
hold on
grid on
box on
plot(l65',zeros(size(l65')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l65',Fx_el(6,:)','color','b','linewidth',2.5);
xlabel('Node');
ylabel('Axial (N)');
title('Element 6-5');
% set(gca,'ylim',[Fxmin-0.2*(Fxmax-Fxmin),Fxmax+0.2*(Fxmax-Fxmin)],
set(gca,'xlim',l65([1,2]),'xtick',l65([1,2]),'xticklabel',[6,5]);


Fymin = min([0,min(Fy_el(:))]);
Fymax = max([0,max(Fy_el(:))]);

subplot(3,3,4)
hold on
grid on
box on
plot(l13',zeros(size(l13')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l13',Fy_el(1:3,:)','color','r','linewidth',2.5);
xlabel('Node');
ylabel('Shear (N)');
% set(gca,'ylim',[Fymin-0.2*(Fymax-Fymin),Fymax+0.2*(Fymax-Fymin)],
set(gca,'xlim',l13([1,6]),'xtick',l13([1,2,3,6]),'xticklabel',[1 4 5 3]);

subplot(3,3,5)
hold on
grid on
box on
plot(l24',zeros(size(l24')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l24',Fy_el(4:5,:)','color','r','linewidth',2.5);
xlabel('Node');
ylabel('Shear (N)');
% set(gca,'ylim',[Fymin-0.2*(Fymax-Fymin),Fymax+0.2*(Fymax-Fymin)],
set(gca,'xlim',l24([1,4]),'xtick',l24([1,2,4]),'xticklabel',[2,6,4]);

subplot(3,3,6)
hold on
grid on
box on
plot(l65',zeros(size(l65')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l65',Fy_el(6,:)','color','r','linewidth',2.5);
xlabel('Node');
ylabel('Shear (N)');
% set(gca,'ylim',[Fymin-0.2*(Fymax-Fymin),Fymax+0.2*(Fymax-Fymin)],
set(gca,'xlim',l65([1,2]),'xtick',l65([1,2]),'xticklabel',[6,5]);

Mzmin = min([0,min(Mz_el(:))]);
Mzmax = max([0,max(Mz_el(:))]);

subplot(3,3,7)
hold on
grid on
box on
plot(l13',zeros(size(l13')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l13',Mz_el(1:3,:)','color','k','linewidth',2.5);
xlabel('Node');
ylabel('Bending (Nm)');
% set(gca,'ylim',[Mzmin-0.2*(Mzmax-Mzmin),Mzmax+0.2*(Mzmax-Mzmin)],
set(gca,'xlim',l13([1,6]),'xtick',l13([1,2,3,6]),'xticklabel',[1 4 5 3]);

subplot(3,3,8)
hold on
grid on
box on
plot(l24',zeros(size(l24')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l24',Mz_el(4:5,:)','color','k','linewidth',2.5);
xlabel('Node');
ylabel('Bending (Nm)');
% set(gca,'ylim',[Mzmin-0.2*(Mzmax-Mzmin),Mzmax+0.2*(Mzmax-Mzmin)],
set(gca,'xlim',l24([1,4]),'xtick',l24([1,2,4]),'xticklabel',[2,6,4]);

subplot(3,3,9)
hold on
grid on
box on
plot(l65',zeros(size(l65')),'color',[0.5,0.5,0.5],'linewidth',2.5);
plot(l65',Mz_el(6,:)','color','k','linewidth',2.5);
xlabel('Node');
ylabel('Bending (Nm)');
% set(gca,'ylim',[Mzmin-0.2*(Mzmax-Mzmin),Mzmax+0.2*(Mzmax-Mzmin)],
set(gca,'xlim',l65([1,2]),'xtick',l65([1,2]),'xticklabel',[6,5]);


end
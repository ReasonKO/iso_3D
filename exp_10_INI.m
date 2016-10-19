clear all
close all
clc;
def_ini
%% ��������� ������� � ���������� ������.
R=[30,80,2]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %���� ���������� �� Z � ���� ���������� �� X;
[~,~,I]=locI(Rang_);
%% ��������� ��������� � �������������
global Modul
Modul.freq=1;  %������� ���������� �������� � ��������
Modul.Tend=700;%865;

Modul.SaveExp=true;

global PAR
PAR.d0=40^2;        %������������ ��������
PAR.d0d=10^2;        %������ � ������ ���������� 5.5

%PAR.Sgrad=0.6;    %����� � ������ ����������
PAR.Sgrad=30;

PAR.Hspeed=0.03;   %���*
PAR.Hmax=25;    %H+
PAR.Hmin=0;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������
PAR.Uh=0.1;    %u_h � ������
PAR.Um=1;       %u � ������
PAR.Tin=30;     %����� �������� IN
PAR.WipeAuto=1;
PAR.dHmax=3;
PAR.run_dynamic='exp_10_dyn';
%PAR.AngH=true;
%PAR.accumH=true;
%PAR.accumH_def=-20;
PAR.ExpName='Anny_spfera';
PAR.Dfunction=@(R)exp_8_D(R);

%% ������ 
PAR.COLOR.R=[0,0,0];
PAR.COLOR.RL=[0,0,0];
PAR.COLOR.RH=[0,0,1];
%% ����
R_=20;
N=10;
[X,Y]=meshgrid(1:N,1);
Z=zeros(size(X));

figure(3000)
clf
axis([-100,50,-100,50,-50,100])
hold on
%mesh(X,Y,Z,'EdgeColor','none');
global VIZ_9
%[VIZ_9.field]=mesh(X,Y,Z,'FaceAlpha',0.55,'EdgeColor','none');
colormap('gray');
VIZ_9.field_2=plot3(X,Y,Z,'.','Color',[0.8,0,0],'MarkerSize',15);
%VIZ_9.field_3=plot3(X(end),Y(end),0,'R-','LineWidth',3);
%shading interp
view([70,80,50]);

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xm_save=field.Xm;
field.Ym_save=field.Ym;
field.Zm_save=field.Zm;


field.Xsize=[-50,50];
field.Ysize=[-50,50];
field.Zsize=[-50,50];

[ang1,ang2]=meshgrid(-pi:pi/10:pi,-pi/2:pi/10:pi/2);

    X2=(R_+5)*sin(ang1).*cos(ang2);
    Y2=(R_+5)*sin(ang1).*sin(ang2);
    Z2=(R_+5)*cos(ang1);
% 
% for i=1:field.l
surf(X2,Y2,Z2,'FaceAlpha',0.55,'EdgeColor','none')
colormap('autumn');
% [~,k2]=mesh(X2,Y2,Z2,'R');
% set(k2,'LineWidth',2);
% [~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
% set(k3,'LineWidth',2);
% end
%%
PAR.d_noise=0;
PAR.h_noise=0.00;
PAR.filtON=false;
iso_MODUL
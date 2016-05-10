clear all
clc;
%% ��������� ������� � ���������� ������.
R=[0,0,0]; %[x,y,z]
Rang_=[pi/2,0]; %���� ���������� �� Z � ���� ���������� �� X;
%% ��������� ��������� � �������������
global Modul
Modul.dt=0.02; %��� �������������
Modul.T=0;     %������� ����� 
Modul.Tend=1;     %������� ����� 
Modul.N=0;     %������� ���
Modul.freq=1;  %������� ���������� �������� � ��������
Modul.SaveExp=false;

global PAR
PAR.d0=20;      %������������ ��������
PAR.d0d=10;     %������ � ������ ���������� 5.5
PAR.Sgrad=0.9;    %����� � ������ ����������
PAR.Hspeed=1;   %���*
PAR.H=[0,0,1];  %������ h
%PAR.re_H=@(R)([0,0,1]);
PAR.re_h=@(R)(R(3));
PAR.d_noise=0;
PAR.h_noise=0;
PAR.filtON=0;
PAR.accumH=0;
PAR.AngH=false;
PAR.accumH_def=0;
PAR.dHmax=1;    %������� ������������ ����

PAR.Dfunction='';
PAR.ExpName='';

PAR.Hmax=15;    %H+
PAR.Hmin=-15;    %H-
PAR.USpeed=1;   %������� ��������
PAR.VSpeed=20;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=10;     %����� �������� IN
PAR.Smod=1;     %��������� �������� S+-

PAR.run_dynamic='';
PAR.green_iso=false;
PAR.WipeTime=0;
PAR.WipeAuto=0;
PAR.Smod_old=0;
PAR.viz_graph=true;%false;
%% ������
PAR.COLOR.R=[0,1,0]; %���� ��������������
PAR.COLOR.RL=[0,1,0]; %���� ������������
PAR.COLOR.RH=[0,0,1]; %���� ������� H
%% ����-----------

RB=50;
RM=15;

% figure(3000)
% clf
% axis([-160,160,-160,160,-160,160])
% hold on
% [angin,angout]=meshgrid(0:pi/50:2*pi,pi:pi/100:3*pi);
% R_=RB+RM*cos(angin);
% Z=RM*sin(angin);
% X=R_.*cos(angout);
% Y=R_.*sin(angout);
% 
% 
% PAR.Hspeed=2;   %���*
% PAR.Hmax=50;    %H+
% PAR.Hmin=-50;    %H-
% X_=X;
% X=Z*2;
% Z=X_*2;

% surf(X,Y,Z,'EdgeColor','none');
% colormap('copper');
% shading interp
% 
global field
field.l=1;
% field.Xm={X};
% field.Ym={Y};
% field.Zm={Z};

field.Xsize=[-200,200];
field.Ysize=[-200,200];
field.Zsize=[-200,200];


% for i=1:field.l
% [~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
% set(k2,'LineWidth',2);
% [~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
% set(k3,'LineWidth',2);
% end

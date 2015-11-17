
close all
clear all
clc;
def_ini
%% ��������� ������� � ���������� ������.
R=[60,40,0]; %[x,y,z]
Rang_=[pi/2+0.1,0]; %���� ���������� �� Z � ���� ���������� �� X;
%% ��������� ��������� � �������������
global Modul
Modul.freq=5;%0.4;  %������� ���������� �������� � ��������
Modul.Tend=250;

global PAR
PAR.d0=10;      %������������ ��������
PAR.d0d=5;     %������ � ������ ���������� 5.5
PAR.Hspeed=0.1;   %���*
PAR.H=[0,0,1];
PAR.re_h=@(R)mod(150+100*(atan2(R(2),R(3)))/pi,200)-100;

PAR.dHmax=2;    %������� ������������ ����

PAR.Hmax=110;    %H+
PAR.Hmin=-110;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.05;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=20;     %����� �������� IN
PAR.Smod=1;     %��������� �������� S+-

PAR.run_dynamic='exp_3_dyn';
%% ����

RB=50;
RM=10;

figure(3000)
clf
axis([-100,100,-100,100,-100,100])
hold on
[angin,angout]=meshgrid(0:pi/50:2*pi,pi:pi/100:3*pi);
R_=RB+RM*cos(angin);
Z=RM*sin(angin);
X=R_.*cos(angout);
Y=R_.*sin(angout);

X_=X;
X=Z*2;
Z=X_*2;

surf(X,Y,Z,'EdgeColor','none');
colormap('copper');
shading interp

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xsize=[-100,100];
field.Ysize=[-100,100];
field.Zsize=[-100,100];


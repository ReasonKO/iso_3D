clear all
clc;
%% ��������� ������� � ���������� ������.
R=[-70,-70,5]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %���� ���������� �� Z � ���� ���������� �� X;
[~,~,I]=locI(Rang_);
%% ��������� ��������� � �������������
global Modul
Modul.dt=0.01; %��� �������������
Modul.T=0;     %������� ����� 
Modul.N=0;     %������� ���
Modul.freq=0.4;  %������� ���������� �������� � ��������
Modul.freqN=floor(Modul.freq/Modul.dt);

global PAR
PAR.d0=20;      %������������ ��������
PAR.d0d=10;     %������ � ������ ���������� 5.5
PAR.Sgrad=1;    %����� � ������ ����������
PAR.Hspeed=0.2;   %���*
PAR.H=[0,0,1];  %������ h


PAR.Hmax=15;    %H+
PAR.Hmin=-15;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=20;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=10;     %����� �������� IN
PAR.Smod=1;     %��������� �������� S+-
%% ����

RB=50;
RM=15;

figure(3000)
clf
axis([-80,80,-80,80,-80,80])
hold on
[angin,angout]=meshgrid(0:pi/50:2*pi,pi:pi/100:3*pi);
R_=RB+RM*cos(angin);
Z=RM*sin(angin);
X=R_.*cos(angout);
Y=R_.*sin(angout);


PAR.Hspeed=2;   %���*
PAR.Hmax=50;    %H+
PAR.Hmin=-50;    %H-
X_=X;
X=Z;
Z=X_;

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


for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end

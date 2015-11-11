clear all
clc;
%% ��������� ������� � ���������� ������.
R=[0,5,15]; %[x,y,z]
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
PAR.d0=10;      %������������ ��������
PAR.d0d=5;     %������ � ������ ���������� 5.5
PAR.Sgrad=1;    %����� � ������ ����������
PAR.Hspeed=1;   %���*
PAR.H=[0,0,1];  %������ h


PAR.Hmax=90;    %H+
PAR.Hmin=10;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=20;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=10;     %����� �������� IN
PAR.Smod=1;     %��������� �������� S+-
%% ����

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
%axis([-20,20,-20,20,0,10])
hold on
[ang,h]=meshgrid(0:pi/50:2*pi,0:100);
R_=sqrt(h)+5;
Z=h;
X=R_.*cos(ang)*5;
Y=R_.*sin(ang)*5;

surf(X,Y,Z,'EdgeColor','none');
[ang,R_]=meshgrid(0:pi/10:2*pi,0:0.2:26);
surf(R_.*sin(ang),R_.*cos(ang),zeros(size(ang)));

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

clear all
close all
clc;
def_ini
%% ��������� ������� � ���������� ������.
R=[0,5,15]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %���� ���������� �� Z � ���� ���������� �� X;
[~,~,I]=locI(Rang_);
%% ��������� ��������� � �������������
global Modul
Modul.freq=2;  %������� ���������� �������� � ��������
Modul.Tend=210;

global PAR
PAR.d0=10;        %������������ ��������
PAR.d0d=5;        %������ � ������ ���������� 5.5
PAR.Sgrad=0.8;    %����� � ������ ����������

PAR.Hspeed=0.1;   %���*

PAR.Hmax=90;    %H+
PAR.Hmin=10;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=25;     %����� �������� IN
PAR.WipeTime=[110];

%% ����

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
axis([-100,80,-100,80,0,100])
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
view([30,20,100]);

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

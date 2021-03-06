clear all
close all
clc;
def_ini
%% ��������� ������� � ���������� ������.
R=[-90,90,60]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %���� ���������� �� Z � ���� ���������� �� X;
[~,~,I]=locI(Rang_);
%% ��������� ��������� � �������������
global Modul
Modul.freq=0.5;  %������� ���������� �������� � ��������
Modul.Tend=5000;

Modul.SaveExp=true;

global PAR
PAR.d0=10;        %������������ ��������
PAR.d0d=5;        %������ � ������ ���������� 5.5
PAR.Sgrad=0.8;    %����� � ������ ����������

PAR.Hspeed=0.05;   %���*

PAR.Hmax=155;    %H+
PAR.Hmin=50;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=15;     %����� �������� IN
PAR.WipeTime=[280,520];

PAR.run_dynamic='exp_11_dyn';
PAR.dHmax=2;
%% ����

figure(3000)
clf
%axis([-20,20,-20,20,0,10])
hold on

%R_=R0*ones(size(ang1));
step=pi/100
[ang,hY]=meshgrid(0:step:2*pi,0:step:pi);
R_=20+abs(sin((ang+pi)*2.5))*50;
Y=-50+20*(hY-pi/2);%+50;
Z=100+R_.*cos(ang).*(abs(sin(hY)));
X=R_.*sin(ang).*(abs(sin(hY)));


global VIZ_11
VIZ_11=mesh(X,Y,Z,'EdgeColor','none');
axis equal
axis([-100,100,-100,100,0,200])
hold on
%plot3(0
%[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
%R_2=vt(abs(ang)*2/pi).*R__*27;
%surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));
colormap('gray');
%colormap('copper');
shading interp
%view([90,120,140]);
view(-37.2,18.8)

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xm_save{1}=X;
field.Ym_save{1}=Y;
field.Zm_save{1}=Z;

field.Xsize=[-100,100];
field.Ysize=[-100,100];
field.Zsize=[-120,120];


for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end

%% %  

PAR.viz_graph=false;%false;
iso_MODUL
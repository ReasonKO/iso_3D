clear all
close all
clc;
def_ini
%% ��������� ������� � ���������� ������.
R=[80,40,15]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %���� ���������� �� Z � ���� ���������� �� X;
[~,~,I]=locI(Rang_);
%% ��������� ��������� � �������������
global Modul
Modul.freq=3;  %������� ���������� �������� � ��������
Modul.Tend=280+40;

global PAR
PAR.d0=10;        %������������ ��������
PAR.d0d=5;        %������ � ������ ���������� 5.5
PAR.Sgrad=0.8;    %����� � ������ ����������

PAR.Hspeed=0.08;   %���*

PAR.Hmax=95;    %H+
PAR.Hmin=5;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=15+40;     %����� �������� IN
PAR.WipeTime=41.1+[130];

%% ����

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
axis([-80,80,-100,100,0,100])
hold on
[ang,h]=meshgrid(-pi:pi/50:pi,0:100);
vt=@(t)(0.2+((sin((abs(t)*2-1)*pi/2))/2+0.5)*0.8).*(abs(t)<1)+1*(abs(t)>=1);
%figure(5)
%plot(-pi:pi/50:pi,vt(-pi:pi/50:pi));
%return
R_=(sqrt(h)+5).*vt(abs(ang)*2/pi);
Z=100-h;
X=R_.*cos(ang)*5;
Y=R_.*sin(ang)*5;

surf(X,Y,Z,'EdgeColor','none');
hold on
[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
R_2=vt(abs(ang)*2/pi).*R__*27;
surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));

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
field.Zsize=[-120,120];


for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end

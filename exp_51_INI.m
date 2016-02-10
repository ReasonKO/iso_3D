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
<<<<<<< HEAD
Modul.Tend=265*3+200;%865;
=======
Modul.Tend=265*3;%865;
>>>>>>> origin/master
Modul.SaveExp=true;

global PAR
PAR.d0=10;        %������������ ��������
PAR.d0d=5;        %������ � ������ ���������� 5.5
PAR.Sgrad=0.8;    %����� � ������ ����������

PAR.Hspeed=0.025;   %���*

PAR.Hmax=95;    %H+
PAR.Hmin=5;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=65;     %����� �������� IN
<<<<<<< HEAD
PAR.WipeTime=420;
=======
PAR.WipeTime=390;
>>>>>>> origin/master

%% ����

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
axis([-100,60,-220,-40,0,80])
hold on
[ang,h]=meshgrid(-pi:pi/100:pi,0:0.5:100);
vt=@(t)(0.2+((sin((abs(t)*2-1)*pi/2))/2+0.5)*0.8).*(abs(t)<1)+1*(abs(t)>=1);
%figure(5)
%plot(-pi:pi/50:pi,vt(-pi:pi/50:pi));
%return
R_=h.*vt(abs(ang)*2/pi);
Z=100-h;
X=R_.*cos(ang);
Y=R_.*sin(ang)-1.5*h;

surf(X,Y,Z,'EdgeColor','none');
hold on
[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
R_2=vt(abs(ang)*2/pi).*R__*27;
%surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));

colormap('gray');
shading interp
view([70,80,50]);

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xsize=[-120,90];
field.Ysize=[-240,50];
field.Zsize=[0,100];


for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end
%%
PAR.d_noise=1;
PAR.h_noise=0.05;
PAR.filtON=true;
iso_MODUL
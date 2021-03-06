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
Modul.freq=10;  %������� ���������� �������� � ��������
Modul.Tend=820;

global PAR
PAR.d0=10;        %������������ ��������
PAR.d0d=5;        %������ � ������ ���������� 5.5
PAR.Sgrad=0.8;    %����� � ������ ����������

PAR.Hspeed=0.05;   %���*

PAR.Hmax=135;    %H+
PAR.Hmin=5;    %H-
PAR.USpeed=5;   %������� ��������
PAR.VSpeed=10;  %�������� ��������

PAR.Uh=0.01;    %u_h � ������
PAR.Um=1;       %u � ������

PAR.Tin=15;     %����� �������� IN
PAR.WipeTime=[280,520];

PAR.run_dynamic='exp_6_dyn';
%% ����

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
%axis([-20,20,-20,20,0,10])
hold on
[ang1,ang2]=meshgrid(-pi:pi/200:pi,(-pi/2):pi/200:(pi/2));
vt=@(t)(1-(sin((abs(t)*2-1)*pi/2)))/2;
vt2=@(t1,t2)1+vt(t1).*vt(t2).*(abs(t1)<1).*(abs(t2)<1);
figure(5)
plot(-pi:pi/50:pi,vt((-pi:pi/50:pi)*2+pi/4));

figure(3000)
R_=80*ones(size(ang1));
R_=R_.*vt2(ang1,(abs(ang2)-0.50)*2.5);
%R=R.*vt((abs(ang2)-pi/6)/pi*12);
%R(or(abs(ang1*2)>=1,abs(abs(ang2)-pi/6)/pi*12>1))=1;
%R(or(abs(ang2*2+pi/4)>=1,abs(ang1*3)>=1))=1;
Z=R_.*cos(ang2);
X=R_.*cos(ang1).*sin(ang2);
Y=R_.*sin(ang1).*sin(ang2)*0.6;



surf(X,Y,Z,'EdgeColor','none');
axis([-100,100,-100,100,0,150])
hold on
%[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
%R_2=vt(abs(ang)*2/pi).*R__*27;
%surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));

colormap('copper');
shading interp
view([90,120,140]);

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

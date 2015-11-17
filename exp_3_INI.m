
close all
clear all
clc;
def_ini
%% Начальная позиция и ориентация робота.
R=[60,40,0]; %[x,y,z]
Rang_=[pi/2+0.1,0]; %Угло отклонения от Z и угол отклонения от X;
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=5;%0.4;  %Частота обновления картинки в секундах
Modul.Tend=250;

global PAR
PAR.d0=10;      %Приследуемое значение
PAR.d0d=5;     %дельта в законе управления 5.5
PAR.Hspeed=0.1;   %Эта*
PAR.H=[0,0,1];
PAR.re_h=@(R)mod(150+100*(atan2(R(2),R(3)))/pi,200)-100;

PAR.dHmax=2;    %Толщина сканируемого слоя

PAR.Hmax=110;    %H+
PAR.Hmin=-110;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость

PAR.Uh=0.05;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=20;     %время процесса IN
PAR.Smod=1;     %Начальное значение S+-

PAR.run_dynamic='exp_3_dyn';
%% Поле

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


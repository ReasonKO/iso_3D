clear all
clc;
%% Начальная позиция и ориентация робота.
R=[-70,-70,5]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.dt=0.01; %Шаг дискретизации
Modul.T=0;     %текущее время 
Modul.N=0;     %текущий шаг
Modul.freq=0.4;  %Частота обновления картинки в секундах
Modul.freqN=floor(Modul.freq/Modul.dt);

global PAR
PAR.d0=20;      %Приследуемое значение
PAR.d0d=10;     %дельта в законе управления 5.5
PAR.Sgrad=1;    %Гамма в законе управления
PAR.Hspeed=0.2;   %Эта*
PAR.H=[0,0,1];  %Вектор h


PAR.Hmax=15;    %H+
PAR.Hmin=-15;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=20;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=10;     %время процесса IN
PAR.Smod=1;     %Начальное значение S+-
%% Поле

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


PAR.Hspeed=2;   %Эта*
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

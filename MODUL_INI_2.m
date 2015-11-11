clear all
clc;
%% Начальная позиция и ориентация робота.
R=[-70,-70,30]; %[x,y,z]
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
PAR.Hspeed=1;   %Эта*
PAR.H=[0,0,1];  %Вектор h

PAR.Hmax=230;    %H+
PAR.Hmin=20;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=20;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=10;     %время процесса IN
PAR.Smod=1;     %Начальное значение S+-
%% Поле
[X,Y]=meshgrid(-100:100,-100:100);
Z=max(0,50^2-X.^2-Y.^2).^(1)/25;
Z(Z==0)=NaN;
al=pi/6;
Xn=X;
Yn=Y*cos(al)-Z*2*sin(al)-25;
Zn=Y*sin(al)+Z*2*cos(al)+80;
Xn2=X;
Yn2=Y*cos(-al)-Z*2*sin(-al)+25;
Zn2=Y*sin(-al)+Z*2*cos(-al)+80;
Xn3=X*sqrt(2);
Yn3=Y*2;
Zn3=Z*2;
Xn3=Xn3.*(1-0.3*min(1,max(0,(-0.5+(Zn3-40)/40))).*(abs(Yn3)<30).*(1-sin(abs(Yn3)/30*pi/2)));
Zn3(Zn3>110)=NaN;


global field
field.l=3;
field.Xm={Xn,Xn2,Xn3};
field.Ym={Yn,Yn2,Yn3};
field.Zm={Zn,Zn2,Zn3};

field.Xsize=[min(min(min(min(field.Xm{1},field.Xm{2}),field.Xm{3}))),max(max(max(max(field.Xm{1},field.Xm{2}),field.Xm{3})))];
field.Ysize=[min(min(min(min(field.Ym{1},field.Ym{2}),field.Ym{3}))),max(max(max(max(field.Ym{1},field.Ym{2}),field.Ym{3})))];
field.Zsize=[min(min(min(min(field.Zm{1},field.Zm{2}),field.Zm{3}))),max(max(max(max(field.Zm{1},field.Zm{2}),field.Zm{3})))];

figure(3001)
clf
mesh(Xn,Yn,Zn,'EdgeColor','none');
hold on
mesh(Xn2,Yn2,Zn2,'EdgeColor','none');
mesh(Xn3,Yn3,Zn3,'EdgeColor','none');
colormap('copper');
shading interp


figure(3000)
clf
plot3(0,0,0);
hold on
axis([field.Xsize,field.Ysize,field.Zsize]);
surf(Xn,Yn,Zn,'EdgeColor','none');
hold on
surf(Xn2,Yn2,Zn2,'EdgeColor','none');
surf(Xn3,Yn3,Zn3,'EdgeColor','none');
colormap('copper');
shading interp

for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end

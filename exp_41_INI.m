clear all
close all
clc;
def_ini
%% Начальная позиция и ориентация робота.
R=[5,5,15]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=2;  %Частота обновления картинки в секундах
Modul.Tend=210+85*2;

global PAR
PAR.d0=10;        %Приследуемое значение
PAR.d0d=5;        %дельта в законе управления 5.5
PAR.Sgrad=0.8;    %Гамма в законе управления

PAR.Hspeed=0.05%1;   %Эта*

PAR.Hmax=90;    %H+
PAR.Hmin=10;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=25;     %время процесса IN
PAR.WipeTime=[110]+85;

%% Поле

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
axis([-70,50,-80,60,0,100])
hold on
[ang,h]=meshgrid(-pi:pi/50:pi,0:100);
R_=sqrt(h)+5;

vt=@(t)(0.3+((sin((abs(t)*2-1)*pi/2))/2+0.5)*0.7).*(abs(t)<1)+1*(abs(t)>=1);


Z=h;
X=R_.*cos(ang)*5.*vt(ang).*vt(azi(pi+ang));
Y=R_.*sin(ang)*5.*vt(ang).*vt(azi(pi+ang));

surf(X,Y,Z,'EdgeColor','none');
[ang,R_]=meshgrid(-pi:pi/10:pi,0:0.2:28);
surf(R_.*cos(ang).*vt(ang).*vt(azi(pi+ang)),R_.*sin(ang).*vt(ang).*vt(azi(pi+ang)),zeros(size(ang)));

colormap('gray');
shading interp
view([30,50,150]);

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
%%
%iso_MODUL

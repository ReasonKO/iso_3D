clear all
close all
clc;
def_ini
%% Начальная позиция и ориентация робота.
R=[30,80,-20]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=1;  %Частота обновления картинки в секундах
Modul.Tend=265*3+170;%865;

%Modul.SaveExp=true;

global PAR
PAR.d0=10;        %Приследуемое значение
PAR.d0d=5;        %дельта в законе управления 5.5
PAR.Sgrad=0.6;    %Гамма в законе управления
PAR.Hspeed=0.1;   %Эта*
PAR.Hmax=40;    %H+
PAR.Hmin=-40;    %H-
PAR.USpeed=2;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость
PAR.Uh=0.1;    %u_h с чертой
PAR.Um=1;       %u с чертой
PAR.Tin=40;     %время процесса IN
PAR.WipeAuto=1;
PAR.dHmax=3;
PAR.run_dynamic='exp_71_dyn';
PAR.accumH=true;
%% Поле

vt=@(t)1;%(0.2+((sin((abs(t)*2-1)*pi/2))/2+0.5)*0.8).*(abs(t)<1)+1*(abs(t)>=1);
[ang1,ang2]=meshgrid(-pi:pi/40:pi,-pi/2:pi/40:pi/2);
R_=50;
X=R_*sin(ang1).*cos(ang2).*max(vt(azi(ang1-pi/3)),vt(ang2));
Y=R_*cos(ang1).*cos(ang2).*max(vt(azi(ang1-pi/3)),vt(ang2));
Z=R_*sin(ang2);
figure(3000)
clf
axis([-50,50,-50,50,-50,50])
hold on
surf(X,Y,Z,'EdgeColor','none');
colormap('gray');
shading interp
view([70,80,50]);

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xsize=[-50,50];
field.Ysize=[-50,50];
field.Zsize=[-50,50];


for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end
%%
PAR.d_noise=0;
PAR.h_noise=0.00;
PAR.filtON=true;
iso_MODUL
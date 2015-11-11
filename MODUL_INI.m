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
PAR.d0=10;      %Приследуемое значение
PAR.d0d=10;     %дельта в законе управления 5.5
PAR.Sgrad=1;    %Гамма в законе управления
PAR.Hspeed=0.3; %Эта*

PAR.Hmax=40;    %H+
PAR.Hmin=20;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=20;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=10;     %время процесса IN
PAR.Smod=1;     %Начальное значение S+-
%% Поле
[Xm,Ym]=meshgrid(-100:0.5:100,-100:0.5:100);
%Zm=sqrt(max(0,4000-(Xm.^2+Ym.^2)))-1/3*sqrt(max(0,6000-((Xm*0.7).^2+(Ym+40).^2)));
%Zm=sqrt(max(0,max(4000-(((Xm-20)*2).^2+Ym.^2),4000-(((Xm+20)*2).^2+(Ym).^2))));

Zm=sqrt(max(0,4000-(Xm.^2+Ym.^2)))-1/2*sqrt(max(0,4000-((Xm*2.5).^2+(Ym+50).^2)));
Zms1=sqrt(max(0,3000-(((Xm-34)*2.2).^2+(Ym+10).^2))).*max(0,min(1,(-Ym+30)/(50*0.6)+0.4));
Zms2=sqrt(max(0,3000-(((Xm+34)*2.2).^2+(Ym+10).^2))).*max(0,min(1,(-Ym+30)/(50*0.6)+0.4));
Zm=max(Zm,max(Zms1,Zms2));
Zm(Zm<0)=NaN;

%Zm=sqrt(max(0,4000-(Xm.^2+Ym.^2)))-1/2*sqrt(max(0,4000-((Xm*2).^2+(Ym+30).^2)));
%Zms1=sqrt(max(0,3000-(((Xm-37)*3).^2+(Ym+5).^2))).*max(0,min(1,(-Ym+30)/(50*0.7)+0.3));
%Zms2=sqrt(max(0,3000-(((Xm+37)*3).^2+(Ym+5).^2))).*max(0,min(1,(-Ym+30)/(50*0.7)+0.3));
%Zm=max(Zm,max(Zms1,Zms2))

global field
field.X=Xm;
field.Y=Ym;
field.Z=Zm;
field.Xsize=[min(min(Xm)),max(max(Xm))];
field.Ysize=[min(min(Ym)),max(max(Ym))];
field.Zsize=[min(min(Zm)),max(max(Zm))];
%% Стартовая графика
figure(3000)
clf
plot3(0,0,0);
hold on
axis([field.Xsize,field.Ysize,field.Zsize])
k=surf(Xm,Ym,Zm,'FaceColor','interp','FaceLighting','phong', 'EdgeColor','none');
surf(Xm,Ym,zeros(size(Ym)));
colormap('Copper')
hold on
[~,k2]=contour3(field.X,field.Y,field.Z,PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.X,field.Y,field.Z,PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);

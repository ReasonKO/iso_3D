function U = rul(R,I)
global rul_data
global Modul
global PAR
[IT,IN]=locI(I);
d0=PAR.d0;
d0d=PAR.d0d;
Sgrad=PAR.Sgrad;
Hspeed=PAR.Hspeed;

Uh=PAR.Uh;    %u_h с чертой
Um=PAR.Um;       %u с чертой

h=PAR.re_h(R);
d=re_D(R);
%% Шум
d=d+randn(1)*PAR.d_noise;
h=h+randn(1)*PAR.h_noise;

%%
d=myfilt(d);
h=myfilt2(h);

if isempty(rul_data)
    rul_data.h_old=h;   
    rul_data.d_old=d;   
end

h_dot=(h-rul_data.h_old)/Modul.dt/PAR.VSpeed;
d_dot=(d-rul_data.d_old)/Modul.dt/PAR.VSpeed;
rul_data.d_old=d;
rul_data.h_old=h;

if h>PAR.Hmax
    PAR.Smod=-1;
end
if h<PAR.Hmin
    PAR.Smod=1;
end
if Modul.T<PAR.Tin
    eta=0;
else    
    eta=Hspeed*(PAR.Smod);
end

xi=@(d)sign(d)*min(abs(d)/PAR.d0d,1)*Sgrad;

fd=@(p)max(-1,min(1,p/0.2));
fh=@(p)max(-1,min(1,p/0.05));

%U=-Uh*sign(h_dot-eta)*IT+...
%    sqrt(Um^2-Uh^2)*sign(d_dot+xi(d-d0))*IN;
drul=-fh(h_dot-eta);
hrul=fd(d_dot+xi(d-d0));
%% filt
global filtHD
if isempty(filtHD)
    filtHD.h=hrul;
    filtHD.d=drul;
end

if PAR.filtON
    drul=drul-0.01*(drul-filtHD.d)/Modul.dt;
    hrul=hrul-0.001*(hrul-filtHD.h)/Modul.dt;
end
filtHD.h=hrul;
filtHD.d=drul;

U=Uh*drul*IT+...
    sqrt(Um^2-Uh^2)*hrul*IN;


%% графика
if PAR.viz_graph

global alg_info
if isempty(alg_info)
    figure(145);
    clf
    
    subplot(2,1,1);
    alg_info.d_dot=plot(0,d_dot);
    hold on
    alg_info.d_need=plot(0,-xi(d-d0),'R','linewidth',1);
    legend('d''','-xi');
    title('Xi & d''')
    
    subplot(2,1,2);
    alg_info.h_dot=plot(0,h_dot);
    hold on
    alg_info.h_need=plot(0,eta,'R','linewidth',1);
    legend('h''','\eta');
    title('\eta & h''')
    
    figure(146);
    clf 
    
    subplot(2,1,1);    
    alg_info.d=plot(0,d);
    hold on
    alg_info.d0=plot(0,d0,'R');
    legend('d','d0');
    title('d')
    
    subplot(2,1,2);    
    ylim([PAR.Hmin-1,PAR.Hmax+1])
    hold on
    alg_info.h=plot(0,h);    
    alg_info.hmax=plot(0,PAR.Hmax,'R','linewidth',2);        
    alg_info.hmin=plot(0,PAR.Hmin,'R','linewidth',2);        
    legend('h','h_+','h_-');
    title('h')
end

addPlotData(alg_info.d_dot,d_dot);
addPlotData(alg_info.h_dot,h_dot);
addPlotData(alg_info.d_need,-xi(d-d0));
addPlotData(alg_info.h_need,eta);

addPlotData(alg_info.d,d);
addPlotData(alg_info.h,h);
addPlotData(alg_info.hmax,PAR.Hmax);
addPlotData(alg_info.hmin,PAR.Hmin);
addPlotData(alg_info.d0,d0);
end

end


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

if ~isfield(rul_data,'R_old')
    rul_data.R_old=R;
    rul_data.accumH=0;
    rul_data.oldH=PAR.H;
end

if PAR.accumH
    rul_data.accumH=rul_data.accumH+sum((R-rul_data.R_old).*rul_data.oldH);
%    rul_data.accumH=rul_data.accumH+1/Modul.dt*sum((R-rul_data.R_old).*PAR.H);
    rul_data.R_old=R;
    h=rul_data.accumH;
    rul_data.oldH=PAR.H;
else
    h=PAR.re_h(R);
end

d=re_D(R);
%% Шум
d=d+randn(1)*PAR.d_noise;
h=h+randn(1)*PAR.h_noise;

%%
%d=myfilt(d);
%h=myfilt2(h);

if ~isfield(rul_data,'h_old')
    rul_data.h_old=h;   
    rul_data.d_old=d; 
end

if PAR.AngH
h_dot=azi((h-rul_data.h_old)/10)/Modul.dt/PAR.VSpeed;
else
h_dot=(h-rul_data.h_old)/Modul.dt/PAR.VSpeed;
end
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
fh=@(p)max(-1,min(1,p/5*0.05));

%U=-Uh*sign(h_dot-eta)*IT+...
%    sqrt(Um^2-Uh^2)*sign(d_dot+xi(d-d0))*IN;
hrul=-fh(h_dot-eta);
drul=fd(d_dot+xi(d-d0));
%% filt
% global filtHD
% if isempty(filtHD)
%     filtHD.h=hrul;
%     filtHD.d=drul;
% end

% if PAR.filtON
%     drul=drul-0.01*(drul-filtHD.d)/Modul.dt;
%     hrul=hrul-0.001*(hrul-filtHD.h)/Modul.dt;
% end
% filtHD.h=hrul;
% filtHD.d=drul;

U=Uh*hrul*IT+...
    sqrt(Um^2-Uh^2)*drul*IN;


%% графика
if PAR.viz_graph

global alg_info
if isempty(alg_info)
    alg_info.ddd=(d-d0)*ones(1,100);
    alg_info.ddd2=(d-d0)*ones(1,500);
    figure(147)
    clf
        subplot(3,1,2);
    alg_info.h_ddd=semilogy(0,0);
    title('~d (for100tick)')  
        subplot(3,1,3);
    alg_info.h_ddd2=semilogy(0,0);
    title('~d (for500tick)')  
    subplot(3,1,1);
    alg_info.hdt=plot(0,Modul.dt);
    title('dt')  
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
alg_info.ddd2=[(d-d0)^2,alg_info.ddd2(1:499)];
alg_info.ddd=[(d-d0)^2,alg_info.ddd(1:99)];
addPlotData(alg_info.h_ddd,sqrt(sum(alg_info.ddd)/100));
addPlotData(alg_info.h_ddd2,sqrt(sum(alg_info.ddd2)/500));

addPlotData(alg_info.hdt,Modul.dt);
    
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


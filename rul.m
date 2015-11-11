function U = rul(R,I)
global rul_data
global Modul
global PAR
[IT,IN]=locI(I);
d0=PAR.d0;
d0d=PAR.d0d;
Sgrad=PAR.Sgrad;
Hspeed=PAR.Hspeed;

Uh=PAR.Uh;    %u_h � ������
Um=PAR.Um;       %u � ������

h=R(3);
d=re_D(R);
d=myfilt(d);

if isempty(rul_data)
    rul_data.h_old=h;   
    rul_data.d_old=d;   
end

h_dot=(h-rul_data.h_old)/Modul.dt;
d_dot=(d-rul_data.d_old)/Modul.dt;
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

xi=@(d)sign(d)*min(abs(d),d0d)*Sgrad;

fd=@(p)max(-1,min(1,p/2));
fh=@(p)max(-1,min(1,p/0.05));

%U=-Uh*sign(h_dot-eta)*IT+...
%    sqrt(Um^2-Uh^2)*sign(d_dot+xi(d-d0))*IN;
U=-Uh*fh(h_dot-eta)*IT+...
    sqrt(Um^2-Uh^2)*fd(d_dot+xi(d-d0))*IN;

%% �������

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

UpPlotData(alg_info.d_dot,d_dot);
UpPlotData(alg_info.h_dot,h_dot);
UpPlotData(alg_info.d_need,-xi(d-d0));
UpPlotData(alg_info.h_need,eta);

UpPlotData(alg_info.d,d);
UpPlotData(alg_info.h,h);
UpPlotData(alg_info.hmax,PAR.Hmax);
UpPlotData(alg_info.hmin,PAR.Hmin);
UpPlotData(alg_info.d0,d0);


end

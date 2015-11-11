function d=re_D(s)
%s=[50,79,20];
dzmax=2;
x=s(1);
y=s(2);
z=s(3);
Kmin=1;
Dmin=inf;
Iopt=1;
global field
for k=1:field.l

Z=field.Zm{k};
X=field.Xm{k};
Y=field.Ym{k};

Zz=Z(abs(Z-z)<dzmax);
Xz=X(abs(Z-z)<dzmax);
Yz=Y(abs(Z-z)<dzmax);

D=sqrt((Xz-x).^2+(Yz-y).^2);
[d,I]=min(D);
if isempty(d)
    d=inf;
end
if (d<Dmin)
    Iopt=I;
    Kmin=k;
    Dmin=d;
end
end
Z=field.Zm{Kmin};
X=field.Xm{Kmin};
Y=field.Ym{Kmin};
Zz=Z(abs(Z-z)<dzmax);
Xz=X(abs(Z-z)<dzmax);
Yz=Y(abs(Z-z)<dzmax);
d=Dmin;
I=Iopt;

%% графика ----------------------------------------------------------------
    
global fig
if ~isfield(fig,'layer') || ~ishandle(fig.layer.figH)
    fig.layer.figH=figure(1001);
    clf
    axis([field.Xsize,field.Ysize])
    hold on
    title('layer');
    %fig.trace2=plot(x,y,'B','linewidth',1.5);
    for i=1:field.l
        fig.layer.fieldi{i}=plot(0,0,'K.');
    end
    fig.layer.robot=plot(0,0,'R*');
    fig.layer.line=plot(0,0,'R-');
end

if isequal('on',get(fig.layer.figH,'Visible'))
    for i=1:field.l
        Zi=field.Zm{i};
        Xi=field.Xm{i};
        Yi=field.Ym{i};        
        Xzi=Xi(abs(Zi-z)<dzmax);
        Yzi=Yi(abs(Zi-z)<dzmax);
        set(fig.layer.fieldi{i},'xdata',Xzi,'ydata',Yzi);
    end
    set(fig.layer.robot,'xdata',x,'ydata',y);
    set(fig.layer.line,'xdata',[x,Xz(I)],'ydata',[y,Yz(I)]);
    %UpPlotData(fig.trace2,x,y);
end

global Modul PAR
if Modul.T<PAR.Tin
if ~isfield(fig,'layer2') || ~ishandle(fig.layer2.figH)
    fig.layer2.figH=figure(1002);
    clf
    axis([field.Xsize,field.Ysize])
    hold on
    title('layer t<Tin');
    fig.trace3=plot(x,y,'B','linewidth',1.5);
    fig.layer2.field2=plot(0,0,'K.');
    fig.layer2.robot2=plot(0,0,'R*');
    fig.layer2.line2=plot(0,0,'R-');
end

if isequal('on',get(fig.layer2.figH,'Visible'))
    set(fig.layer2.field2,'xdata',Xz,'ydata',Yz);
    set(fig.layer2.robot2,'xdata',x,'ydata',y);
    set(fig.layer2.line2,'xdata',[x,Xz(I)],'ydata',[y,Yz(I)]);
    UpPlotData(fig.trace3,x,y);
end    
end
    %if Modul.T>PAR.Tin
    %    break
    %end

if ~isfield(fig,'trace')
    figure(3000);
    fig.trace=plot3(Xz(I),Yz(I),z,'B','linewidth',3);    
end
UpPlotData(fig.trace,Xz(I),Yz(I),z);
end
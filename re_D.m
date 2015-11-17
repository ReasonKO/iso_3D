function d=re_D(R)
%s=[50,79,20];
global PAR field Modul
dzmax=PAR.dHmax*5;
x=R(1);
y=R(2);
z=R(3);

Kopt=1;
Dmin=inf;
Iopt=1;
H=PAR.H/norm(PAR.H);
%layerf=@(A,B,C,s)and(and(...
%        abs((A-s(1))*H(1)+(B-s(2))*H(2))<PAR.dHmax,...
%        abs((B-s(2))*H(2)+(C-s(3))*H(3))<PAR.dHmax),...
%        abs((C-s(3))*H(3)+(A-s(1))*H(1))<PAR.dHmax);
layerln=@(A,B,C,s)abs((A-s(1))*H(1)+(B-s(2))*H(2)+(C-s(3))*H(3));
layerf=@(A,B,C,s)(abs((A-s(1))*H(1)+(B-s(2))*H(2)+(C-s(3))*H(3))<PAR.dHmax);
%% перебор слоев
for k=1:field.l
    Z_k=field.Zm{k};
    X_k=field.Xm{k};
    Y_k=field.Ym{k};
    
    layerln=layerln(X_k,Y_k,Z_k,R);
    layer=layerln<PAR.dHmax;
    %abs(Z_k-z)<dzmax;
    
    Zz_k=Z_k(layer);
    Xz_k=X_k(layer);
    Yz_k=Y_k(layer);
    layerln_k=layerln(layer);
    D_k=sqrt((Xz_k-x).^2+(Yz_k-y).^2+(Zz_k-z).^2-layerln_k.^2);
    [d_k,Ind]=min(D_k);
    if isempty(d_k)
        d_k=inf;
    end
    if (d_k<Dmin)
        Iopt=Ind;
        Kopt=k;
        Dmin=d_k;
    end
end
%% Сбор информации с лучшего слоя
Z=field.Zm{Kopt};
X=field.Xm{Kopt};
Y=field.Ym{Kopt};
layer=layerf(X,Y,Z,R);
Zz=Z(layer);
Xz=X(layer);
Yz=Y(layer);
d=Dmin;
Ind=Iopt;
if (d==inf)
    return
end
%% графика ----------------------------------------------------------------
global fig
if ~isfield(fig,'trace')
    figure(3000);
    if (PAR.green_iso)
        fig.layer3=plot3(Xz,Yz,Zz,'G.');      
    end
    fig.trace=plot3(Xz(Ind),Yz(Ind),Zz(Ind),'B','linewidth',3);  
end
if sum(abs(PAR.WipeTime-Modul.T)<Modul.dt)
    setPlotData(fig.trace,[],[],[]);
end    
addPlotData(fig.trace,Xz(Ind),Yz(Ind),Zz(Ind));
if PAR.green_iso
    set(fig.layer3,'xdata',Xz,'ydata',Yz,'zdata',Zz);
end
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
    set(fig.layer.line,'xdata',[x,Xz(Ind)],'ydata',[y,Yz(Ind)]);
    %UpPlotData(fig.trace2,x,y);
end

if Modul.T<PAR.Tin
if ~isfield(fig,'layer2') || ~ishandle(fig.layer2.figH)
    fig.layer2.figH=figure(1002);
    clf
    axis([field.Xsize,field.Ysize])
    hold on
    title('layer t<Tin');
    fig.trace3=plot(x,y,'B','linewidth',1.5);
    fig.layer2.field2=plot(0,0,'K.');
    fig.layer2.robot2=plot(0,0,'R*','linewidth',2);
    fig.layer2.line2=plot(0,0,'R-');
end

if isequal('on',get(fig.layer2.figH,'Visible'))
    set(fig.layer2.field2,'xdata',Xz,'ydata',Yz);
    set(fig.layer2.robot2,'xdata',x,'ydata',y);
    set(fig.layer2.line2,'xdata',[x,Xz(Ind)],'ydata',[y,Yz(Ind)]);
    addPlotData(fig.trace3,x,y);
end    
end

end
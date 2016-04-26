function [Dmin] = exp_8_D(R)
%s=[50,79,20];
global PAR field Modul
x=R(1);
y=R(2);
z=R(3);

Dmin=inf;
%H=PAR.H/norm(PAR.H);
k=1;
    Z_k=field.Zm{k};
    X_k=field.Xm{k};
    Y_k=field.Ym{k};
size_=size(Z_k,1)*size(Z_k,2);
D_k=(X_k-x).^2+(Y_k-y).^2+(Z_k-z).^2;
    Dmin=sum(sum(D_k))/size_ ;




    
% %% перебор слоев
% for k=1:field.l
%     Z_k=field.Zm{k};
%     X_k=field.Xm{k};
%     Y_k=field.Ym{k};
%     
%     size_=size(Z_k,1)*size(Z_k,2);
%     Z_k=reshape(Z_k,size_,1);
%     X_k=reshape(X_k,size_,1);
%     Y_k=reshape(Y_k,size_,1);
%     
%     D_k=sqrt((X_k-x).^2+(Y_k-y).^2+(Z_k-z).^2);   
%     [d_k,Ind]=min(D_k);
%     if isempty(d_k)
%         d_k=inf;
%     end
%     if (d_k<Dmin)
%         Iopt=Ind;
%         Kopt=k;
%         Dmin=d_k;
%     end
% end
% 
%% графика ----------------------------------------------------------------

global fig
if ~isfield(fig,'trace')
    figure(3000);
    fig.trace=plot3(x,y,z,'B','linewidth',3);  
end

addPlotData(fig.trace,x,y,z);
return


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
    %fig.layer.field3=surf(X_layer,Y_layer,zeros(size(Z_layer))); 
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
    %set(fig.layer.field3,'xdata',X_layer,'ydata',Y_layer,'zdata',Z_layer-z*ones(size(Z_layer)));    
    set(fig.layer.robot,'xdata',x,'ydata',y);
    set(fig.layer.line,'xdata',[x,Xz(Ind)],'ydata',[y,Yz(Ind)]);
    %UpPlotData(fig.trace2,x,y);
end

if Modul.T<=PAR.Tin
if ~isfield(fig,'layer2') || ~ishandle(fig.layer2.figH)
    fig.layer2.figH=figure(1002);
    clf
    axis([field.Xsize,field.Ysize])
    hold on
    title('layer t<Tin');
    fig.trace3=plot(x,y,'B','linewidth',1.5);
    fig.layer2.field2=plot(NaN,NaN,'K.');
    %fig.layer2.field3=surf(X_layer,Y_layer,zeros(size(Z_layer)));
    fig.layer2.robot2=plot(0,0,'R*','linewidth',2);
    fig.layer2.line2=plot(0,0,'R-');
end
if isequal('on',get(fig.layer2.figH,'Visible'))
    addPlotData(fig.layer2.field2,Xz(Ind),Yz(Ind));
    %set(fig.layer2.field2,'xdata',Xz,'ydata',Yz);
    %set(fig.layer2.field3,'xdata',X_layer,'ydata',Y_layer,'zdata',Z_layer-z*ones(size(Z_layer)));
    set(fig.layer2.robot2,'xdata',x,'ydata',y);
    set(fig.layer2.line2,'xdata',[x,Xz(Ind)],'ydata',[y,Yz(Ind)]);
    addPlotData(fig.trace3,x,y);
end    
end

end


global MAP_PAR PAR field
l=10;
[IT,IN,I,H]=locI(I);

if isempty(MAP_PAR)
    figure(3000)
    MAP_PAR.MAP_H=figure(3000);
    MAP_PAR.R=plot3(R(1),R(2),R(3),'*','linewidth',3,'Color',PAR.COLOR.R);
    MAP_PAR.Rl=plot3(R(1)+l*[0, I(1)],R(2)+l*[0, I(2)],R(3)+l*[0, I(3)],'-','linewidth',1.5,'Color',PAR.COLOR.RL);
%    MAP_PAR.RT=plot3(R(1)+l*[0,IT(1)],R(2)+l*[0,IT(2)],R(3)+l*[0,IT(3)],'R-');    
%    MAP_PAR.RN=plot3(R(1)+l*[0,IN(1)],R(2)+l*[0,IN(2)],R(3)+l*[0,IN(3)],'Y-');    
    MAP_PAR.RH=plot3(R(1)+l*[0,H(1)],R(2)+l*[0,H(2)],R(3)+l*[0,H(3)],'-','Color',PAR.COLOR.RH);    
%     for i=1:field.l
%         [~,MAP_PAR.contour{i}]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},R(3)*[1,1],'G');
%         set(MAP_PAR.contour{i},'LineWidth',2);
%     end  
else
    %if (get(0,'CurrentFigure')==3000)

    setPlotData(MAP_PAR.R,R(1),R(2),R(3));
    setPlotData(MAP_PAR.Rl,R(1)+l*[0, I(1)],R(2)+l*[0, I(2)],R(3)+l*[0, I(3)]);
    setPlotData(MAP_PAR.RH,R(1)+l*[0,H(1)],R(2)+l*[0,H(2)],R(3)+l*[0,H(3)]);
%    set(MAP_PAR.RT,'xdata',R(1)+l*[0,IT(1)],'ydata',R(2)+l*[0,IT(2)],'zdata',R(3)+l*[0,IT(3)]);
%    set(MAP_PAR.RN,'xdata',R(1)+l*[0,IN(1)],'ydata',R(2)+l*[0,IN(2)],'zdata',R(3)+l*[0,IN(3)]);
%    set(MAP_PAR.RH,'xdata',R(1)+l*[0, H(1)],'ydata',R(2)+l*[0, H(2)],'zdata',R(3)+l*[0, H(3)]);
    %for i=1:field.l
%        delete(MAP_PAR.contour{i});
%        [~,MAP_PAR.contour{i}]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},R(3)*[1,1],'G');
%        set(MAP_PAR.contour{i},'LineWidth',2);
    %end  
    %end
end

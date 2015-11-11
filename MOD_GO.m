%re=MOD_GO(X,Xang,Rul)
%re=[X(1),X(2),Xang] 
%Моделирование движения робота
function [R,Rang]=MOD_GO(R,Rang,U,V,dT)
Rang=Rang+U/2*dT;
R=R+V*dT*[sin(Rang(1))*cos(Rang(2)),sin(Rang(1))*sin(Rang(2)),cos(Rang(1))];
Rang=Rang+U/2*dT;


% global Modul;
% if isempty(Modul)
%     error('Modul is empty.')
% end
% if (nargin==3)    
%     dT=Modul.dT;
% end
% %% Инициализация параметров
% l=Modul.l_wheel;
% if (l==0)
%     warning('l=0! a non-rotatable model?');
%     l=inf;
% end
% Speed=Modul.vSpeed;
% %% Переход к скоростям
% Left=Rul(1)*Speed;
% Right=Rul(2)*Speed;
% U=(Right-Left)/(2*l);
% V=(Left+Right)/2;
% %% Вычисления длины хорды
% fi=sign(U*dT).*mod(abs(U*dT),2*pi);
% if (U==0)
%     L=dT*V;
% else
%     L=sqrt(2)*sign(dT)*V/abs(U)*sqrt(1-cos(fi));
% end
% %% Поворот, лин.движение, поворот.
% Xang=Xang+fi/2;
% X=X+L*[cos(Xang),sin(Xang)];
% Xang=azi(Xang+fi/2);
% %% Вывод
% re=[X(1),X(2),Xang];
end


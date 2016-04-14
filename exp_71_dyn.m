global PAR
%oldH=H;
%an1=atan2(R(1),R(2));
%an2=atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2;
%PAR.H=[sin(an1)*cos(an2),cos(an1)*cos(an2),sin(an2)];
PAR.H=cross(R,I);
PAR.H=PAR.H/norm(PAR.H);

% global fsdfsdf
% if isempty(fsdfsdf)
% figure(3000)
% fsdfsdf=plot3(60*sin(an1)*cos(an2),...
%      60*cos(an1)*cos(an2),...
%      60*sin(an2),'R*');
% else
%     setPlotData(fsdfsdf,R(1)+3*sin(an1)*cos(an2),...
%      R(2)+3*cos(an1)*cos(an2),...
%      R(3)+3*sin(an2));
% end

%PAR.H=[sin(atan2(R(1),R(2)))*cos(atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2),cos(atan2(R(1),R(2)))*cos(atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2),sin(atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2)];

% global save
% if isempty(save)
%     save.oldh=0;
% end
%save.old=PAR.re_h(R);
%PAR.re_h=@(R)save.old+H-

%atan2(H(3),H(1))-atan2(oldH(3),oldH(1))-
%save.old+azi(atan2(R(3),R(1))-save.oldh);
%save.oldh=atan2(R(3),R(1));
%PAR.re_h=@(R)mod(150+100*atan2(PAR.H(3),PAR.H(2))/pi,200)-100;


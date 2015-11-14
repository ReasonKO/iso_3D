%% 
function [IT,IN,I,H] = locI(in)
if (length(in)==2)
    Rang=in;
    I=[sin(Rang(1))*cos(Rang(2)),sin(Rang(1))*sin(Rang(2)),cos(Rang(1))];
else
    I=in;
end
global PAR
H=PAR.H/norm(PAR.H);
alV=cross(H,I);    
al=asin(max(0,min(1,norm(alV))));
IT=(H-cos(al)*I)/sin(al);
IN=cross(IT,I);
end


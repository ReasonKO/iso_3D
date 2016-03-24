%exp_1_INI
%exp_2_INI
%exp_3_INI
%exp_4_INI
%exp_5_INI
% exp_6_INI
% 
% exp_31_INI

global Modul PAR
%PAR.d_noise=1;
%PAR.h_noise=0.05;
%PAR.filtON=true;

Modul.SaveExp=true;

[~,~,I]=locI(Rang_);
while Modul.T<=Modul.Tend
    Iu=rul(R,I);
    R=R+I*Modul.dt*PAR.VSpeed;
    I=I+Modul.dt*PAR.USpeed*Iu;
    I=I/norm(I);
    if mod(Modul.N,floor(Modul.freq/Modul.dt))==0 
        MAP();
        drawnow();
        iso_save_map();
    end
    run(PAR.run_dynamic);
    Modul.T=Modul.T+Modul.dt;
    Modul.N=Modul.N+1;
end
iso_save_param();
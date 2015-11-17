global MAP_PAR
global PAR
global Modul
if isfield(MAP_PAR,'SAVEMAP')
    saveas(1001,[MAP_PAR.SAVEMAP.name,'/','field','.png']);
    saveas(1002,[MAP_PAR.SAVEMAP.name,'/','Tini','.png']);
    saveas(145,[MAP_PAR.SAVEMAP.name,'/','ddot & hdot','.png']);
    saveas(146,[MAP_PAR.SAVEMAP.name,'/','d&h','.png']);

    fid=fopen([MAP_PAR.SAVEMAP.name,'/','param.txt'],'wb');
    fwrite(fid,sprintf('iso_experiment : %s \n',MAP_PAR.SAVEMAP.name),'int16');    
    
    fwrite(fid,sprintf('---Modul---\n'),'int16');
    fldnms=fieldnames(Modul);
    for i=1:length(fldnms)
        temp_field=getfield(Modul,fldnms{i});
        if (isnumeric(temp_field)==1 && numel(temp_field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},temp_field),'int16');
        end
    end
    
    fwrite(fid,sprintf('---PAR---\n'),'int16');
    fldnms=fieldnames(PAR);
    for i=1:length(fldnms)
        temp_field=getfield(PAR,fldnms{i});
        if (isnumeric(temp_field)==1 && numel(temp_field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},temp_field),'int16');
        end
    end
    fclose(fid);
end

create or replace procedure sp_check_pmuinfo(
i_psno varchar2,--pmu ÐòÁÐºÅ
i_serial varchar2,--pmu ×¢²áÂë
o_result out varchar2) is
--
v_rownum number;
v_idex varchar2(64);
v_stationid number;
begin
     select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
     if v_rownum >0 then
        select nvl(stationid,0),idex into v_stationid,v_idex from tb_pmu where psno = upper(i_psno);
        if v_stationid =0 then
           if v_idex = i_serial then
              o_result := 'ok';
           else
              o_result:='err_serial';
           end if;
        else
           o_result:='err_used';
        end if;
     else
        o_result:='err_psno';
     end if;
end sp_check_pmuinfo;
/


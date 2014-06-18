create or replace procedure sp_check_pmubindenabled(
i_psno varchar2,--pmu 序列号
i_serial varchar2,--pmu 注册码
o_result out varchar2) is
--检测PMU编号及验证号及状态是否可以用来做绑定
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
end sp_check_pmubindenabled;
/


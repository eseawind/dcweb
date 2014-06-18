create or replace procedure sp_stationunbindpmu(
i_stationid number,
i_psno varchar2,
o_result out varchar2
) is
--电站PMU解除绑定关系,因扩展功能需要该函数作废
v_rownum number;
begin
   if i_stationid is not null and i_psno is not null and length(i_psno) >5 then
     select count(1) into v_rownum from tb_pmu where stationid = i_stationid and psno = upper(i_psno);
     if v_rownum >0 then
        update tb_inverter set stationid = null,psno = null where psno = upper(i_psno);
        update tb_pmu set stationid = null where psno = upper(i_psno);
        insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
        values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DCG100',100,-1,-1,'stationid='|| trim(to_char(i_stationid,'99999999'))||';psno='|| i_psno||';');
        commit;
        o_result:='ok';
     else
        o_result:='err_pmualreadybind';
     end if;
    else
        o_result:='err_psnoerr';
    end if;
end sp_stationunbindpmu;
/


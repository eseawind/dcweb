create or replace procedure sp_stationunbindpmuex(
i_stationid number,
i_psno varchar2,
i_idex varchar2,
i_opdate varchar2,
o_result out varchar2
) is
/*================================================================
功能说明:电站PMU解除绑定关系
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Device management
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
v_curdate date;--电站所在时区当前时间
begin
   if i_stationid is not null and i_idex is not null and  i_psno is not null and length(i_psno) >2 then
      select count(1) into v_rownum from tb_pmu where stationid = i_stationid and psno = upper(i_psno) and i_idex = idex;
      if v_rownum >0 then
         update tb_inverter set /*stationid = null,*/psno = null where psno = upper(i_psno);
         update tb_pmu set stationid = null where psno = upper(i_psno);
         --v_curdate:=fn_get_station_local_date(i_stationid);--获得该电站的所在时区的当前时间
         v_curdate:= to_date(i_opdate,'yyyy-MM-dd hh24:mi:ss');
         insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,302,0,0);--插入PMU上线事件记录
         insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
             values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',100,-1,-1,'stationid='|| trim(to_char(i_stationid,'99999999'))||';psno='|| i_psno||';');
         commit;
         o_result:='ok';
      else
         o_result:='err_psno_idex';
      end if;
   else
        o_result:='err_itemempty';
   end if;
end sp_stationunbindpmuex;
/

